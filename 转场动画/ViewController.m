//
//  ViewController.m
//  转场动画
//
//  Created by GeYang on 2017/1/18.
//  Copyright © 2017年 GeYang. All rights reserved.
//

#import "ViewController.h"
#import "GYTransitionAnimator.h"
#import "GYTransitionAnimatorScale.h"
#import "GYTransitionAnimatorLevels.h"
#import "GYTransitionAnimatorArc.h"
#import "SecondViewController.h"

#define HEIGHT [UIScreen mainScreen].bounds.size.height
#define WIDTH  [UIScreen mainScreen].bounds.size.width

@interface ViewController ()<UIViewControllerTransitioningDelegate>
@property (nonatomic, strong) UIImageView *imview;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    for (int i = 0; i < 5; i++) {
        CGRect rect;
        if (i == 0) {
            rect = CGRectMake(0, 64, 100, 140);
        }else if (i == 1){
            rect = CGRectMake(WIDTH - 100, 64, 100, 140);
        }else if (i == 2){
            rect = CGRectMake(0, HEIGHT - 140, 100, 140);
        }else if (i == 3){
            rect = CGRectMake(WIDTH - 100, HEIGHT - 140, 100, 140);
        }else{
            rect = CGRectMake(WIDTH / 2 - 100 / 2, HEIGHT / 2 - 140 / 2 + 32, 100, 140);
        }
        UIImageView *imageview = [[UIImageView alloc]initWithFrame:rect];
        imageview.image = [UIImage imageNamed:@"header.jpg"];
        imageview.userInteractionEnabled = YES;
        imageview.tag = i + 1;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(go:)];
        [imageview addGestureRecognizer: tap];
        [self.view addSubview: imageview];
    }
}
- (void)go:(UIGestureRecognizer *)gue{
    _imview = (UIImageView *)gue.view;
    SecondViewController *second = [[SecondViewController alloc]init];
    second.transitioningDelegate = self;
    [self presentViewController:second animated:YES completion:nil];
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    if ([_style isEqualToString:@"1"]) {
        return [self isPresentToController:YES];
    }else if ([_style isEqualToString:@"2"]){
        return [self isPresentToController2:YES];
    }else if ([_style isEqualToString:@"3"]){
        return [self isPresentToController3:YES];
    }else{
        return [self isPresentToController4:YES];
    }
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    if ([_style isEqualToString:@"1"]) {
        return [self isPresentToController:NO];
    }else if ([_style isEqualToString:@"2"]){
        return [self isPresentToController2:NO];
    }else if ([_style isEqualToString:@"3"]){
        return [self isPresentToController3:NO];
    }else{
        return [self isPresentToController4:NO];
    }
}

//动画1 渐变
- (GYTransitionAnimator *)isPresentToController:(BOOL)present{
    GYTransitionAnimator *animator = [[GYTransitionAnimator alloc]init];
    animator.isPresent = present;
    animator.duration = 0.5;
    return  animator;
}

//动画2 缩放
- (GYTransitionAnimatorScale *)isPresentToController2:(BOOL)present{
    GYTransitionAnimatorScale *animator = [[GYTransitionAnimatorScale alloc]init];
    animator.isPresent = present;
    animator.duration = 0.3;
    animator.currentFrame = _imview.frame;
    return animator;
}

//动画3 层次
- (GYTransitionAnimatorLevels *)isPresentToController3:(BOOL)present{
    GYTransitionAnimatorLevels *animator = [[GYTransitionAnimatorLevels alloc]init];
    animator.isPresent = present;
    animator.duration = 0.3;
    return animator;
}

//动画4 圆扩散
- (GYTransitionAnimatorArc *)isPresentToController4:(BOOL)present{
    GYTransitionAnimatorArc *animator = [[GYTransitionAnimatorArc alloc]init];
    animator.isPresent = present;
    animator.duration = 0.5;
    animator.currentFrame = _imview.frame;
    return animator;
}




@end
