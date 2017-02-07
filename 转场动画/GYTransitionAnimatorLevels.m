//
//  GYTransitionAnimatorLevels.m
//  转场动画
//
//  Created by GeYang on 2017/2/6.
//  Copyright © 2017年 GeYang. All rights reserved.
//

#import "GYTransitionAnimatorLevels.h"

@interface GYTransitionAnimatorLevels()
@property (nonatomic, strong) UIView *formview;
@property (nonatomic, strong) UIView *toview;
@property (nonatomic, strong) UIView *containerView;
@end

@implementation GYTransitionAnimatorLevels

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return _duration;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    _containerView = [transitionContext containerView];
    _formview = fromVC.view;
    _toview = toVC.view;
    if ([transitionContext respondsToSelector:@selector(viewForKey:)]) {
        _formview = [transitionContext viewForKey:UITransitionContextFromViewKey];
        _toview = [transitionContext viewForKey:UITransitionContextToViewKey];
    }
    [_containerView addSubview: _toview];
    
    if (_isPresent) {
        _toview.frame = CGRectMake(0, HEIGHT, WIDTH, HEIGHT);
        [UIView animateWithDuration:_duration animations:^{
            _formview.transform = CGAffineTransformMakeScale(0.95, 0.95);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:_duration animations:^{
                _toview.frame = CGRectMake(0, 0, WIDTH, HEIGHT);
            } completion:^(BOOL finished) {
                _formview.transform = CGAffineTransformIdentity;
                BOOL isCancelled = [transitionContext transitionWasCancelled];
                [transitionContext completeTransition:!isCancelled];
            }];
        }];
    }else{
        [_containerView addSubview: _formview];
        _toview.transform = _toview.transform = CGAffineTransformMakeScale(0.95, 0.95);
        _formview.frame = CGRectMake(0, 0, HEIGHT, WIDTH);
        [UIView animateWithDuration:_duration animations:^{
            _formview.frame = CGRectMake(0, HEIGHT, WIDTH, HEIGHT);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:_duration animations:^{
                _toview.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
                BOOL isCancelled = [transitionContext transitionWasCancelled];
                [transitionContext completeTransition:!isCancelled];
            }];
            
            
        }];
    }
}

















@end
