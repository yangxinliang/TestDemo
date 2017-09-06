//
//  ScanQRViewController.m
//  TestDemo
//
//  Created by PingAnXL on 2017/8/21.
//  Copyright © 2017年 PingAnXL. All rights reserved.
//

#import "ScanQRViewController.h"

@interface ScanQRViewController ()

@end

@implementation ScanQRViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(40, 100, 200, 200)];
    
    
    imageView.image = [self qrImageForString:@"hahahha" imageSize:100 logoImageSize:30];
    
    [self.view addSubview:imageView];
}

// 生成二维码
- (UIImage *)qrImageForString:(NSString *)string imageSize:(CGFloat)imagesize logoImageSize:(CGFloat)waterImagesize {
    
    CIFilter * filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    [filter setDefaults];
    
    NSData * data = [string dataUsingEncoding:NSUTF8StringEncoding];
    
    [filter setValue:data forKey:@"inputMessage"];
    
    [filter setValue:@"H" forKey:@"inputCorrectionLevel"];
    
    CIImage * outPutImage = [filter outputImage];
    
    return [self  createNonInterpolatedUIImageFormCIImage:outPutImage withSize:imagesize waterImageSize:waterImagesize];
    
    
}

- (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat)size waterImageSize:(CGFloat)waterImagesize {
    
    
    CGRect extent = CGRectIntegral(image.extent);
    
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    
    
    size_t width = CGRectGetWidth(extent) * scale;
    
    size_t height = CGRectGetHeight(extent) * scale;
    
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    
    
    CIContext * context = [CIContext contextWithOptions:nil];
    
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    
    CGContextScaleCTM(bitmapRef,scale,scale);
    
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    
    //保存bitmap到图片
    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef); CGImageRelease(bitmapImage);
    
    // 原图
    UIImage * outputImage = [UIImage imageWithCGImage:scaledImage];
    
    // 给二维码 loge 图
    UIGraphicsBeginImageContextWithOptions(outputImage.size,NO,[[UIScreen mainScreen] scale]);
    
    [outputImage drawInRect:CGRectMake(0,0 , size, size)];
    
    // logo 图
    //    UIImage * waterImage = [UIImage imageNamed:@"图标.png"];
    //
    //    //把logo图画到生成的二维码图片上，注意尺寸不要太大（最大不超过二维码图片的%30），太大会造成扫不出来
    //    [waterImage drawInRect:CGRectMake((size-waterImagesize)/2.0, (size-waterImagesize)/2.0, waterImagesize, waterImagesize)];
    UIImage *newPic = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newPic;
    
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
