//
//  NSObject+KVO.m
//  KVO实现原理
//
//  Created by PingAnXL on 17/4/28.
//  Copyright © 2017年 PingAnXL. All rights reserved.
//

#import "NSObject+KVO.h"
#import <objc/runtime.h>
#import <objc/message.h>

NSString *const YXGKVOClassPrefix = @"YXKVOClassPrefix_";
NSString *const YXGKVOAssociatedObservers = @"YXKVOAssociatedObservers";

#pragma mark - 建一个类来储存东西

@interface YXObservationInfo : NSObject

/** BLOCK **/
@property (nonatomic, copy) YXObsevingBlock block;

/** object **/
@property (nonatomic, weak) NSObject * observer;
/** dsada **/
@property (nonatomic, copy) NSString * key;


@end

@implementation YXObservationInfo

- (instancetype)initWithObserver:(NSObject *)observer Key:(NSString *)key block:(YXObsevingBlock)block{

    self = [super init];
    
    if (self) {
        
        _observer = observer;
        _key = key;
        _block = block;
        
    }
    
    return self;
    
}

@end

#pragma mark - Debug Help Methods
static NSArray *ClassMethodNames(Class c)
{
    NSMutableArray *array = [NSMutableArray array];
    
    unsigned int methodCount = 0;
    Method *methodList = class_copyMethodList(c, &methodCount);
    unsigned int i;
    for(i = 0; i < methodCount; i++) {
        [array addObject: NSStringFromSelector(method_getName(methodList[i]))];
    }
    free(methodList);
    
    return array;
}


static void PrintDescription(NSString *name, id obj)
{
    NSString *str = [NSString stringWithFormat:
                     @"%@: %@\n\tNSObject class %s\n\tRuntime class %s\n\timplements methods <%@>\n\n",
                     name,
                     obj,
                     class_getName([obj class]),
                     class_getName(object_getClass(obj)),
                     [ClassMethodNames(object_getClass(obj)) componentsJoinedByString:@", "]];
    printf("%s\n", [str UTF8String]);
}



#pragma mark - helper

static NSString * getterForSetter(NSString * setter) {
    
    if (setter.length <= 0 || ![setter hasPrefix:@"set"] || ![setter hasSuffix:@":"]) {
        return nil;
    }
    
    // remove 'set' at the begining and ':' at the end
    NSRange range = NSMakeRange(3, setter.length - 4);
    NSString *key = [setter substringWithRange:range];
    
    // lower case the first letter
    NSString *firstLetter = [[key substringToIndex:1] lowercaseString];
    key = [key stringByReplacingCharactersInRange:NSMakeRange(0, 1)
                                       withString:firstLetter];
    return key;
    
}

// C语言函数
static NSString * setterForGetter(NSString * getter){
    
    if (getter.length <= 0) {
        return nil;
    }
    NSString * firstLetter = [[getter substringToIndex:1] uppercaseString];
    NSString * remainingLeters = [getter substringFromIndex:1];
    NSString * setter = [NSString stringWithFormat:@"set%@%@:",firstLetter,remainingLeters];
    return setter;
    
}
#pragma mark - 重写方法父类的setter 方法

static void kvo_setter(id self, SEL _cmd, id newValue){

    NSString *setterName = NSStringFromSelector(_cmd);
    NSString *getterName = getterForSetter(setterName);
    
    if (!getterName) {
        NSString *reason = [NSString stringWithFormat:@"Object %@ does not have setter %@", self, setterName];
        @throw [NSException exceptionWithName:NSInvalidArgumentException
                                       reason:reason
                                     userInfo:nil];
        return;
     }

    id oldValue = [self valueForKey:getterName];
    
    struct objc_super superclazz = {
        .receiver = self,
        .super_class = class_getSuperclass(object_getClass(self))
    };
    
    void (*objc_msgSendSuperCasted)(void *, SEL, id) = (void *)objc_msgSendSuper;
    
    objc_msgSendSuperCasted(&superclazz, _cmd, newValue);

    NSMutableArray * observers = objc_getAssociatedObject(self, (__bridge const void *)(YXGKVOAssociatedObservers));
    
    for (YXObservationInfo * each in observers) {
        
        if ([each.key isEqualToString:getterName]) {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                each.block(self, getterName, oldValue, newValue);
            });
        }
    }


}

static Class kvo_class(id self, SEL _cmd)
{
    return class_getSuperclass(object_getClass(self));
}

@implementation NSObject (KVO)

- (void)YX_addObserver:(NSObject *)observer foKey:(NSString *)key withBlock:(YXObsevingBlock)block {
    
    
    SEL setteSelector = NSSelectorFromString(setterForGetter(key));
    
    Method setterMethod = class_getInstanceMethod([self class], setteSelector);
    if (!setterMethod) {
        NSString *reason = [NSString stringWithFormat:@"Object %@ does not have a setter for key %@", self, key];
        @throw [NSException exceptionWithName:NSInvalidArgumentException
                                       reason:reason
                                     userInfo:nil];
        return;
    }
    
    Class clazz = object_getClass(self);
    NSString * clazzName = NSStringFromClass(clazz);
    
    if (![clazzName hasPrefix:YXGKVOClassPrefix]) {
    
        clazz = [self makeKvoClassWithOriginalClassName:clazzName];
        object_setClass(self, clazz);
        
    }

    if (![self hasSelector:setteSelector]) {
        const char * types = method_getTypeEncoding(setterMethod);
        class_addMethod(clazz, setteSelector,(IMP)kvo_setter, types);
    }
    
    YXObservationInfo *info = [[YXObservationInfo alloc] initWithObserver:observer Key:key block:block];
    NSMutableArray *observers = objc_getAssociatedObject(self, (__bridge const void *)(YXGKVOAssociatedObservers));
    if (!observers) {
        observers = [NSMutableArray array];
        objc_setAssociatedObject(self, (__bridge const void *)(YXGKVOAssociatedObservers), observers, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    [observers addObject:info];
    
}

- (void)YX_removeObserver:(NSObject *)observer foKey:(NSString *)key {
    
    NSMutableArray* observers = objc_getAssociatedObject(self, (__bridge const void *)(YXGKVOAssociatedObservers));
    
    YXObservationInfo *infoToRemove;
    for (YXObservationInfo* info in observers) {
        if (info.observer == observer && [info.key isEqual:key]) {
            infoToRemove = info;
            break;
        }
    }
    
    [observers removeObject:infoToRemove];
    
    
}

- (Class)makeKvoClassWithOriginalClassName:(NSString *)originalClazzName {
    
    NSString *kvoClazzName = [YXGKVOClassPrefix stringByAppendingString:originalClazzName];
    Class clazz = NSClassFromString(kvoClazzName);
    
    if (clazz) {
        return clazz;
    }
    
    Class originalClazz = object_getClass(self);
    Class kvoClazz = objc_allocateClassPair(originalClazz, kvoClazzName.UTF8String, 0);
    
    
    Method clazzMethod = class_getInstanceMethod(originalClazz, @selector(class));
    
    const char * types = method_getTypeEncoding(clazzMethod);
    class_addMethod(kvoClazz, @selector(class), (IMP)kvo_class, types);
    objc_registerClassPair(kvoClazz);
    return kvoClazz;
}

// 判断这个类中是否含有该方法
- (BOOL)hasSelector:(SEL)selector {
    
    Class clazz = object_getClass(self);
    
    unsigned int methodCount = 0;
    Method * methodList = class_copyMethodList(clazz, &methodCount);
    
    for (unsigned int i = 0; i < methodCount; i ++) {
        SEL thisSelector = method_getName(methodList[i]);
        if (thisSelector == selector) {
            free(methodList);
            return YES;
        }
    }
    free(methodList);
    return NO;
    
}


@end
