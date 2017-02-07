//
//  GYTransitionAnimatorArc.h
//  转场动画
//
//  Created by GeYang on 2017/2/6.
//  Copyright © 2017年 GeYang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define HEIGHT [UIScreen mainScreen].bounds.size.height
#define WIDTH  [UIScreen mainScreen].bounds.size.width

@interface GYTransitionAnimatorArc : NSObject <UIViewControllerAnimatedTransitioning>
@property (nonatomic, assign) BOOL isPresent;//判断是否跳转
@property (nonatomic, assign) CGRect currentFrame;//当前图片的位置
@property (nonatomic, assign) CGFloat duration;//当前持续时间
@end
