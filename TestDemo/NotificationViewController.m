//
//  NotificationViewController.m
//  TestDemo
//
//  Created by PingAnXL on 2017/8/21.
//  Copyright © 2017年 PingAnXL. All rights reserved.
//

#import "NotificationViewController.h"
#import <UserNotifications/UserNotifications.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <CoreLocation/CoreLocation.h>


@interface NotificationViewController ()

@end

@implementation NotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self requestLocationNotification];

}

- (void)requestLocationNotification {
    
    UNMutableNotificationContent * content = [[UNMutableNotificationContent alloc] init];
    
    content.title = @"杨新亮测试通知";
    content.subtitle = @"测试通知";
    content.body = @"来自我的mac";
    content.badge = @3;
    NSError * error = nil;
    NSString * path = [[NSBundle mainBundle] pathForResource:@"icon_certification_status1@2x" ofType:@"png"];
    
    [UIApplication sharedApplication].applicationIconBadgeNumber = 3;
    
    
    // 1.设置通知附件内容
    UNNotificationAttachment * att = [UNNotificationAttachment attachmentWithIdentifier:@"att1" URL:[NSURL fileURLWithPath:path] options:nil error:&error];
    if (error) {
        NSLog(@"attachment error %@",error);
    }
    content.attachments = @[att];
    
    content.launchImageName = @"icon_certification_status1@2x";
    
    // 2. 设置声音
    UNNotificationSound * sound = [UNNotificationSound defaultSound];
    content.sound = sound;
    
    // 3.触发模式
    
    UNTimeIntervalNotificationTrigger * trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:5 repeats:NO];
    
    // 4. 设置UNNotificationRequest
    NSString * requestIdentifer = @"TestRequest";
    
    UNNotificationRequest * request = [UNNotificationRequest requestWithIdentifier:requestIdentifer content:content trigger:trigger];
    
    // 5 把通知加到UNUserNotificationCenter，到指定触发点被触发
    [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        
        
        NSLog(@"添加到通知错误%@",error);
        
    }];
    
    
    
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
