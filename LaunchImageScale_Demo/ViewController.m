//
//  ViewController.m
//  LaunchImageScale_Demo
//
//  Created by admin on 16/8/11.
//  Copyright © 2016年 AlezJi. All rights reserved.
//
//http://www.jianshu.com/p/58109c63b93e
//启动页面渐变放大动画效果




//注意在Launch Image Source 设置成Launch Image


#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    UIWindow * keyWindow = [[UIApplication sharedApplication]keyWindow] ;

    UIImageView *welcomeImgView = [[UIImageView alloc]initWithFrame:keyWindow.bounds];
    [welcomeImgView setImage:[UIImage imageNamed:[self getLaunchImageName]]];
    welcomeImgView.alpha = 0.99;

    
    //把背景图放在最上层
    [keyWindow addSubview:welcomeImgView];
    [keyWindow bringSubviewToFront:welcomeImgView];

    
    [UIView animateWithDuration:3.0f delay:0.0f options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        CGRect frame = welcomeImgView.frame;
        frame.size.width = keyWindow.bounds.size.width*1.3;
        frame.size.height = keyWindow.bounds.size.height*1.3;
        welcomeImgView.frame = frame;
        welcomeImgView.center = keyWindow.center;
        welcomeImgView.alpha = 0;
        
    } completion:^(BOOL finished) {
        [welcomeImgView removeFromSuperview];
        
    }];
    
}
- (NSString *)getLaunchImageName {
    //  CGSize viewSize = [[UIApplication sharedApplication]keyWindow].bounds.size;
    CGSize viewSize = [UIScreen mainScreen].bounds.size;
    // 竖屏
    NSString *viewOrientation = @"Portrait";
    NSString *launchImageName = nil;
    NSArray* imagesDict = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"UILaunchImages"];
    for (NSDictionary* dict in imagesDict) {
        CGSize imageSize = CGSizeFromString(dict[@"UILaunchImageSize"]);
        if (CGSizeEqualToSize(imageSize, viewSize) && [viewOrientation isEqualToString:dict[@"UILaunchImageOrientation"]]) {
            launchImageName = dict[@"UILaunchImageName"];
        }
    }
    return launchImageName;
}

@end
