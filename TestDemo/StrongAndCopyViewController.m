//
//  StrongAndCopyViewController.m
//  TestDemo
//
//  Created by PingAnXL on 2017/8/21.
//  Copyright © 2017年 PingAnXL. All rights reserved.
//

#import "StrongAndCopyViewController.h"

@interface StrongAndCopyViewController ()
/** strong 的使用 **/
@property (nonatomic, strong) NSArray * strongArray;
/** copy的使用 **/
@property (nonatomic, copy) NSArray * copyyArray;

/** chang strong **/
//@property (nonatomic, strong) NSMutableArray * changeStrongArr;
///** chang copy **/
//@property (nonatomic, copy) NSMutableArray * changeCopyArr;

/** strong **/
@property (nonatomic, strong) NSString * strongStr;
/** copy  **/
@property (nonatomic, copy) NSString * copyyStr;


/** strong 修饰可别数组的时候 **/
@property (nonatomic, strong) NSMutableArray * changArr;
/** copy 修饰可别数组的时候   这种修饰方法不可采取的**/
@property (nonatomic, copy) NSMutableArray * copyyArr;

/** strong 修饰可变字典 **/
@property (nonatomic, strong) NSMutableDictionary * strongdic;
/** copy  修饰可变字典  这种修饰方法是不对的 程序会crash **/
@property (nonatomic, copy) NSMutableDictionary * copyyDic;




/*
 
 1.当可别数组使用copy 修饰的时候 使用 addObject 这个程序会运行报错 crash 掉 我们知道addObject后的array其实是变了，可能内存变大了,你可以理解成这个对象已经不是原来的了，变成了不可变的数组了，就相当于没有定义一个具体实例对象一样。但通过@synthesize 默认的setter不能保证copy就一定等于mutableCopy；所以我们需要自定义自己的setter方法。
 例如我的定义，在.m中增加我们自己定义的setter方法，让它进行mutableCopy即可
 
 2、把copy变成retain，strong，因为不是copy创建新内存和新赋值的话，原有实例对象就不会“全新”导致unrecognized selector sent to instance。
 
 */
@end

@implementation StrongAndCopyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //    [self noChangeString];
    //    [self changeString];
    
    self.changArr = [NSMutableArray array];
    
    self.copyyArr = [NSMutableArray array];
    
    self.strongdic = [NSMutableDictionary dictionary];
    self.copyyDic = [NSMutableDictionary dictionary];
    
    
    
    
    //    [self mutableCopyDic];
    
    //    [self changArray];
    
    //    [self changDic];
    
    [self changeString];

}
- (void)mutableCopyDic {
    
    
    //    NSDictionary * dic = @{@"1":@"Y"};
    //
    //    NSMutableDictionary * secondDic = [dic mutableCopy];
    //
    //    //输出两个对象的指针，判断是否是一样
    //
    //    NSLog(@"原来:%p ---%@,新的:%p ---%@",dic,dic,secondDic,secondDic);
    
    
    
    
    
    
    
    
}

// 可变字典
- (void)changDic {
    
    [self.strongdic setObject:@"12321" forKey:@"dsadas"];
    
    NSLog(@"%@",self.strongdic);
    
    
    //
    //    [self.copyyDic setObject:@"Yannik" forKey:@"abcd"];
    //
    //    NSLog(@"%@",self.copyyDic);
}




#pragma mark - 可变数组如果使用copy修饰的时候，这样会把可别数组生成不可变数组  使用 strong、retain

- (void)changArray {
    
    //    [self.changArr addObject:@"DSADASD"];
    //
    //    [self.copyyArr addObject:@"dsadasdas"];
    
    
    NSLog(@"%@,%@",_changArr,_copyyArr);
    
    
    
    for (NSInteger i=0 ; i <8 ; i ++) {
        
        NSString * str = [NSString stringWithFormat:@"%ld",(long)i];
        
        [self.changArr addObject:str];
        
        
        
        NSLog(@"%p-----%p",_changArr,_copyyArr);
        
        NSLog(@"%@222222%@",_changArr,_copyyArr);
    }
}


#pragma mark - 非集合类

#pragma mark - 不可变 strong 只是增加一个引用计数，copy 为浅拷贝同样也是增加了一个引用计数

- (void)noChangeString {
    
    NSString * str = @"Yannik";
    
    self.strongStr = str ;
    self.copyyStr = str;
    
    NSLog(@"%p------%p------%p",str,_strongStr,_copyyStr);
    
}

#pragma mark -  strong 同样只是增加了一个引用计数，到时copy却为深拷贝重新生成了一个地址，当可别字符串改变的时候strong 修饰的字符串内容也会改变，copy 修饰的字符串内容不会改变的


- (void)changeString {
    
    
    NSMutableString * str = [NSMutableString stringWithString:@"Yannik"];
    
    self.strongStr = str;
    self.copyyStr = str;
    
    NSLog(@"%p------%p------%p",str,_strongStr,_copyyStr);
    
    NSLog(@"%@1111111 === %@1111111===%@",str,_strongStr,_copyyStr);
    
    
    [str appendString:@"12344"];
    
    NSLog(@"%p------%p------%p",str,_strongStr,_copyyStr);
    
    NSLog(@"%@2222222 == %@   22222222== %@",str,_strongStr,_copyyStr);
    
    
}



#pragma mark - 1、集合类

#pragma mark -  strong 同样只是增加了一个引用计数，到时copy却为深拷贝重新生成了一个地址，当可别数组改变的时候strong 修饰的数组内容也会改变，copy 修饰的数组内容不会改变的

- (void)change {
    
    
    NSMutableArray * testChangeArr = [NSMutableArray arrayWithArray:@[@"test1"]];
    
    self.strongArray = testChangeArr;
    self.copyyArray = testChangeArr;
    
    NSLog(@"%p-----%p----%p",testChangeArr,_strongArray,_copyyArray);
    
    NSLog(@"%@111111%@111111%@",testChangeArr,_strongArray,_copyyArray);
    
    
    [testChangeArr addObject:@"Yannik"];
    
    
    NSLog(@"%p=====%p========%p",testChangeArr,_strongArray,_copyyArray);
    
    NSLog(@"%@2222222%@222222222%@",testChangeArr,_strongArray,_copyyArray);
    
    
}

#pragma mark - copy strong 操作不可变的时候  都只是增加一个引用计数 都是浅拷贝 只拷贝内容，不会生产一个新的地址

- (void)nochange {
    
    NSArray * testArray = @[@"testArray"];
    self.strongArray = testArray;
    
    self.copyyArray = testArray;
    
    NSLog(@"%p-----%p----%p",testArray,_strongArray,_copyyArray);
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
