//
//  GYTransitionAnimator.m
//  转场动画
//
//  Created by GeYang on 2017/1/18.
//  Copyright © 2017年 GeYang. All rights reserved.
//

#import "GYTransitionAnimator.h" 

#define HEIGHT [UIScreen mainScreen].bounds.size.height
#define WIDTH  [UIScreen mainScreen].bounds.size.width

@interface GYTransitionAnimator()<CAAnimationDelegate>
@property (nonatomic, strong) UIView *formview;
@property (nonatomic, strong) UIView *toview;
@property (nonatomic, strong) UIView *containerView;
@end

@implementation GYTransitionAnimator

//设置整个动画的实现时间
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return _duration;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    _formview = fromVC.view;
    _toview = toVC.view;
    if ([transitionContext respondsToSelector:@selector(viewForKey:)]) {
        _formview = [transitionContext viewForKey:UITransitionContextFromViewKey];
        _toview = [transitionContext viewForKey:UITransitionContextToViewKey];
    }
    [containerView addSubview: _toview];
    _containerView = containerView;
    
    //执行动画

    [self animationOne:_duration andContext:transitionContext];
}



//透明
- (void)animationOne:(NSTimeInterval)transitionDuration andContext:(id<UIViewControllerContextTransitioning>)transitionContext{
    //动画效果
    _formview.alpha = 1.0;
    _toview.alpha = 0.0;
    [UIView animateWithDuration:transitionDuration animations:^{
        _formview.alpha = 0.0;
        _toview.alpha = 1.0;
    } completion:^(BOOL finished) {
        _formview.alpha = 1.0;
        BOOL isCancelled = [transitionContext transitionWasCancelled];
        [transitionContext completeTransition:!isCancelled];
    }];
}
























@end
