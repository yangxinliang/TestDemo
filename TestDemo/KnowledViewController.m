//
//  KnowledViewController.m
//  TestDemo
//
//  Created by PingAnXL on 2017/8/21.
//  Copyright © 2017年 PingAnXL. All rights reserved.
//

#import "KnowledViewController.h"

#import "kPerson.h"
#import "MRCObject.h"

#import "ButtonCallbackObject.h"

#import "BlockObject.h"

extern NSString * Yannik; // extern只是用来声明外部全局变量，注意 extern 只能声明，不能用于定义。先在当前文件查找有没有全局变量，没有找到，才会去其他文件查找
@interface KnowledViewController ()
{
    // 声明一个block
    void (^_yannikBlock)(void);
    
}
@property (nonatomic, strong) UILabel * label;



@end

@implementation KnowledViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    BlockObject * obj = [[BlockObject alloc] init];
    
    NSLog(@"%@",obj);
    
    // 一定要在这个对象使用完后 处于闲置的状态时 去 执行这个方法 来破坏循环引用的
    [obj execBlock];


    // 实现block
    _yannikBlock = ^{
        
        
        
    };
    

    void (^block)() = ^{
        
        NSLog(@"无参无返回");
        
    };
    block();
    
    int (^block1)() = ^{
        
        return 10;
    };
    
    NSLog(@"%d",block1());
    
    // 有参数有返回值
    int (^block2)(int number) = ^(int number){
        
        return number;
    };
    
    int a = block2(10);
    
    NSLog(@"%d",a);
    
    // 防止循环引用定义的弱引用
    __weak typeof(self) weakSelf = self;
    
    // 如果在block内部延时操作还使用弱引用的话会取不到该弱指针，需要在block内部再将弱指针强引用一下
    __strong typeof(self) strongSelf = weakSelf;
    
    
    //    // 值传递 不可以修改
    //    __block int a = 0;
    //    NSLog(@"定义前 : %p",&a);
    //    void (^food)() = ^ {
    //        a = 1;
    //        NSLog(@"block内部: %p",&a);
    //    };
    //    NSLog(@"定义后：%p",&a);
    //    food();
    //
    //    // 地址传递  可以修改
    //    NSMutableString * str = [NSMutableString stringWithFormat:@"Hello"];
    //
    //
    //    void (^callBlock)() = ^ {
    //        [str appendFormat:@"   world"];
    //        NSLog(@"%@",str);
    //    };
    //    callBlock();
    
    
    //
    //    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(10,84, 100, 30)];
    //    label.backgroundColor = [UIColor redColor];
    //    [self.view addSubview:label];
    //
    //    self.label = label;
    //
    
    //    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceOrientationDidChange) name:UIDeviceOrientationDidChangeNotification object:nil];
    // 通过类名的字符串形式实例化对象
    Class class = NSClassFromString(@"Person");
    
    NSLog(@"11111111%@",class);
    // 把类名转化成字符串
    NSString * str = NSStringFromClass([kPerson class]);
    
    NSLog(@"@22222222%@",str);
    // isa 指针是一个class类型的指针 每个实例对象有个isa 的指针，他指向对象的类，而class里也有个isa 的指针，指向meteClass,元类保存在类方法的列表，当类方法被调用时，先会从本身查找类方法的实现，如果没有，元类会向他的父类查找该方法，同时注意的是 袁磊也是类，它也是对象，元类也有ISA 指针，它的isa 指针指向本身，这样形成一个封闭的内循环



}

- (void)deviceOrientationDidChange
{
    NSLog(@"NAV deviceOrientationDidChange:%ld",(long)[UIDevice currentDevice].orientation);
    if([UIDevice currentDevice].orientation == UIDeviceOrientationPortrait) {
        [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationPortrait];
        //注意： UIDeviceOrientationLandscapeLeft 与 UIInterfaceOrientationLandscapeRight
        [self orientationChange:NO];
        NSLog(@"UIInterfaceOrientationPortrait");
        
    } else if ([UIDevice currentDevice].orientation == UIDeviceOrientationLandscapeLeft) {
        [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeRight];
        
        NSLog(@"UIInterfaceOrientationLandscapeRight");
        
        
        
        [self orientationChange:YES];
        
        
        
        
    }
}
- (void)orientationChange:(BOOL)landscapeRight
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    if (landscapeRight) {
        [UIView animateWithDuration:0.2f animations:^{
            self.view.transform = CGAffineTransformMakeRotation(-M_PI_2);
            self.view.bounds = CGRectMake(0, 0, width, height);
        }];
    } else {
        [UIView animateWithDuration:0.2f animations:^{
            self.view.transform = CGAffineTransformMakeRotation(0);
            self.view.bounds = CGRectMake(0, 0, width, height);
        }];
    }
}

// 编写一个函数，实现递归删除指定路径下的所有文件

- (void)deleteFiles:(NSString *)path {
    
    NSFileManager * fileManger = [NSFileManager defaultManager];
    
    BOOL isDir = NO;
    
    BOOL isExist = [fileManger fileExistsAtPath:path isDirectory:&isDir];
    
    if (isExist) {
        if (isDir) {
            NSArray * dirArray = [fileManger contentsOfDirectoryAtPath:path error:nil];
            NSString * subPath = nil;
            
            for (NSString * str  in dirArray) {
                subPath = [path stringByAppendingPathComponent:str];
                BOOL issubDir = NO;
                [fileManger fileExistsAtPath:subPath isDirectory:&issubDir];
                
                [self deleteFiles:subPath];
            }
        }else {
            
            [fileManger removeItemAtPath:path
                                   error:nil];
        }
        
        
    }else {
        
        NSLog(@"你打印的是目录或者不存在");
        
    }
    
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    //    // oc  关键字的使用
    //    [KeyWord test];
    //    NSLog(@"%@",Yannik);
    
    
    //    QuChong * g = [[QuChong alloc] init];
    //
    //    [g testType:typeFour];
    //
    
    //    sortArray * p = [[sortArray alloc] init];
    //
    //    [p sortArray:sortNrayType3];
    
    [ButtonCallbackObject buttonCallBackObject:@"wo" callBlock:^(NSString *str1) {
        
        NSLog(@"%@",str1);
        
        
    }];
}


//- (int)methodUsingBlock:(blk_t)blk rate:(int)rate {
//    
//    return blk(rate);
//}



void func (int (^blk) (int)){
    
    
    
}
//int (^func())(int){
//
//    return ^(int count){
//        return count + 1;
//    };
//
//}


// block
- (void)test2Object {
    
    
    
    int (^blk)(int) =  ^(int count) {
        
        return count + 1;
    };
    
    int (^blk1)(int) = blk;
    
    int (^blk2)(int);
    
    blk2 = blk1;
    
    
    
    
    
}

// 引用计数
- (void)test1Object {
    
    
    //    id obj = [NSMutableArray array];
    //
    //    NSLog(@"%p %d",obj ,(long)[obj retainCount]);
    //
    //    id obj1 = [NSArray alloc];
    //
    //    NSLog(@"obj2===%d",(long)[[obj1 init] retainCount]);
    //
    //    [obj release];
    
    
    MRCObject * obj = [[MRCObject alloc] init];
    
    [obj print];
    
//    
//    id obj1 = [obj allocObjct];
//    
//    NSLog(@"%u",[obj1 retainCount]);
//    
//    [obj1 release];
//    
//    //    NSLog(@"%u",[obj1 retainCount]);
//    
//    
//    // 取得非自己持有的对象
//    id obj2 = [obj objct];
//    
//    NSLog(@"obj2=====%u",[obj2 retainCount]);
    
    // 如果释放非自己持有的对象 会引起程序crash
    //    [obj2 release];
    
    
}

- (BOOL)shouldAutorotate {
    
    return YES;
}


- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    // 如果该界面需要支持横竖屏切换
    return UIInterfaceOrientationMaskAll;
    // 如果该界面仅支持横屏
    // return UIInterfaceOrientationMaskLandscapeRight；
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
