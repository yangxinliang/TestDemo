//
//  BlockObject.m
//  高级编程例子
//
//  Created by PingAnXL on 17/4/20.
//  Copyright © 2017年 PingAnXL. All rights reserved.
//

#import "BlockObject.h"


//这个定义全局变量的block 这个block作为oc 的对象 NSConcreteGlobalBlock 类对象 存储在 数据区.date
void (^globalBlock)(void) = ^{
    printf("Global Block\n");
    
};


@implementation BlockObject

- (instancetype)init{
    self = [super init];

//   id  __weak weakSelf = self;
    
    
    // 使用 __block 来解决循环引用的时候  一定要注意在合适的位置去 execBlock去调这个方法 否则的话对象是会提前释放，导致僵尸指针，致死程序crash
    __block id temp = self;
    blk_ = ^{
    
        NSLog(@"self = %@",temp);
        
        temp = nil;
    };
    
    

    return self;
}


- (void)testBlock {

    // 有参数有返回值的block  声明一个block void(^blockName)(int arg1,int arg2)  void 是返回值  blockName 是block的名称， 后面是参数列表
    int (^sum)(int a, int b)  = ^(int a,int b){
        return a + b;
    };
    NSLog(@"%d",sum(10,20));
    
    // 无参数 无返回值的Block
    void (^yannik)() = ^{
        NSLog(@"我是Yannik");
    };
    yannik();
    
    // 这个定义在局部变量的Block， 此时block的对象是 NSConcreteGlobalBlock 类对象 存储在 栈上
    void (^xinliang)() = ^(NSInteger a){
        
        NSLog(@"%ld",a);
        
    };
    xinliang(10);
    
    int (^yangxin)() = ^(int a, int b){
        
        return a + b;
    };
    yangxin(10,40);
    
    NSLog(@"%d",yangxin(10,40));
    
    // 截获自动变量
    /**
     int val = 10;
     
     const char * fmt = "val = %d\n";
     // 定义个block
     void (^blk)(void) = ^{
     printf(fmt,val);
     };
     val = 2;
     fmt = "These values were changed.val = %d\n";
     blk();
     */
    
    // __block 的使用  若想在block的语法表达式中  使用外部变量赋值，需要使用__block
    
    __block int val1 = 0;
    void (^blk)() = ^{
        
        val1 = 1;
        NSLog(@"%ld",(NSInteger)val1);
        
    };
    blk();
    
    // 截获oc 的对象  在block  中使用截获的对象是没有问题的， 如果对截获的对象赋值会报错的，这时需要使用__block 对对象进行修饰
    
    id array = [[NSMutableArray alloc] init];
    void (^ocBlk)() = ^{
        
        id obj = [[NSObject alloc] init];
        
        [array addObject:obj];
        
    };
    
    ocBlk();
    
    //  block 实质是栈上的Block 的结构体实例  __block变量 栈上__block 变量的结构体实例
    // 另外 将Block 作为oc 的类 可以把block 分为三和类， _NSConcreteStackBlock  _NSConcreteGlobalBlock _NSConcreteMallocBlock  分别存储在  栈上， 程序的数据区域 .data区 ， 堆上
    
    // 存储在数据区 .date的block 还有以下这种情况 因为block内部没有截获外部变量 所以还是存储在数据区域.data
    
    typedef int (^blkGlocb)(int);
    
    for (int rate = 0; rate < 10; ++rate) {
        
        blkGlocb blk = ^(int count){
            
            return count;
        };
        
        NSLog(@"%d",blk(10));
    }
    
    for (int rate = 0; rate < 10; ++rate) {
        
        blkGlocb blk = ^(int count){
            
            return rate * count;
        };
        
        NSLog(@"%d",blk(10));
        
    }
    // 堆上的Block
    
    // 堆上的block
    //        typedef int (^yangXinliang) (int a);
    //
    //        yangXinliang func(int rate){
    //
    //            return ^(int count){
    //                return rate * count;
    //            };
    //        };
    
    //  截获对象
    
    //        typedef void(^objectBlock) (id obj);
    //
    //        id array1 = [[NSMutableArray alloc] init];
    //
    //        objectBlock objBloc = [^(id obj){
    //
    //            [array1 addObject:obj];
    //
    //            NSLog(@"array1 count = %ld",[array1 count]);
    //
    //        } copy];
    //
    //        objBloc([[NSObject alloc] init]);
    //        objBloc([[NSObject alloc] init]);
    //        objBloc([[NSObject alloc] init]);
    
    
    // 不使用 copy
    typedef void(^objectBlock) (id obj);
    
    id array1 = [[NSMutableArray alloc] init];
    
    objectBlock objBloc = ^(id obj){
        
        [array1 addObject:obj];
        
        NSLog(@"array1 count = %ld",[array1 count]);
        
    };
    
    objBloc([[NSObject alloc] init]);
    objBloc([[NSObject alloc] init]);
    objBloc([[NSObject alloc] init]);
    


}

- (void)execBlock {

    blk_();

}


- (void)dealloc {

    NSLog(@"dealloc");

}





@end
