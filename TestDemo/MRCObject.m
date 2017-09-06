//
//  MRCObject.m
//  高级编程例子
//
//  Created by PingAnXL on 17/4/18.
//  Copyright © 2017年 PingAnXL. All rights reserved.
//

#import "MRCObject.h"

@implementation MRCObject

- (void)print {

    NSObject * obj = [[NSObject alloc] init];
    
    NSLog(@"%ld------",[obj retainCount]);

    // obj1并不持有 obj  只是引用了
    NSObject * obj1 = obj;
    
    [obj1 retain];
    
    NSLog(@"%ld------%ld",[obj retainCount],[obj1 retainCount]);
    
    

}

- (id)allocObjct {

    // 自己生成并持有
    id obj = [[NSObject alloc] init];
    
    return obj;
}

- (id)objct {

    id obj = [[NSObject alloc] init];

    [obj autorelease];

    return obj;
}

// autorelase 的内部实现
- (void)objectAutorelease {

    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    
    id obj = [[NSObject alloc] init];
    
    [obj autorelease];

    [pool drain]; // 等同于   [obj release];



}

// _strong属性赋值

- (void)_getStrong {
    
    id __strong obj0 = [[NSObject alloc] init];  /*对象A*/
    /*
     * obj0 持有对象A 的强引用
     */
    
    id __strong obj1 = [[NSObject alloc] init]; /*对象B*/
    /*
     * obj1 持有对象B 的强引用
     */
    id __strong obj2 = nil;
    /*
     * obj2 不持有任何对象
     */
    
    obj0 = obj1;
    /* 因为 objo0 持有 由obj1赋值的对象B 的强引用 
       因为 obj0 被赋值，所以原先持有的对象A 的强引用失效
       对象A 的所有者不存在，因此要废弃对象A
       此时 持有对象B的强引用的变量为
     
      obj0 obj1
     
     */
   
    obj2 = obj0;
    /*
     obj2 持有由 obj0 的赋值对象B 的强引用
     此时持有B的引用为
     
     obj1,obj1,obj2
     
     */
    
    obj1 = nil; /*因为nil 被赋值给obj1 所已对对象B的强引用失效  此时持有B的引用为
                 
                 obj0,obj2 */
    obj0 = nil;/*因为nil 被赋值给obj0 所已对对象B的强引用失效  此时持有B的引用为
                
                obj2 */
    
    obj2 = nil; /*因为nil 被赋值给obj2 所已对对象B的强引用失效  对象B 的所有者不存在，因此要废弃对象B
                 
                  */


}





@end
