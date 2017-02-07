//
//  GYTransitionAnimatorArc.m
//  转场动画
//
//  Created by GeYang on 2017/2/6.
//  Copyright © 2017年 GeYang. All rights reserved.
//

#import "GYTransitionAnimatorArc.h"

@interface GYTransitionAnimatorArc()<CAAnimationDelegate>
@property (nonatomic, strong) UIView *formview;
@property (nonatomic, strong) UIView *toview;
@property (nonatomic, strong) UIView *containerView;
@end

@implementation GYTransitionAnimatorArc
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
    
    //设置圆心
    CGPoint start = CGPointMake(_currentFrame.origin.x + _currentFrame.size.width / 2, _currentFrame.origin.y + _currentFrame.size.height / 2);
    //设置圆最大直径
    CGFloat maxRadius = sqrt(pow(HEIGHT, 2) + pow(WIDTH, 2));
    //设置圆最小直径
    CGFloat minRadius = 1;
    
    UIBezierPath *startCycle;
    UIBezierPath *endCycle;
    
    if (_isPresent) {
        startCycle = [UIBezierPath bezierPathWithArcCenter:start radius:minRadius startAngle:0 endAngle:M_PI * 2 clockwise:YES];
        endCycle = [UIBezierPath bezierPathWithArcCenter:start radius:maxRadius startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    }else{
        startCycle = [UIBezierPath bezierPathWithArcCenter:start radius:maxRadius startAngle:0 endAngle:M_PI * 2 clockwise:YES];
        endCycle = [UIBezierPath bezierPathWithArcCenter:start radius:minRadius startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    }
    
    CAShapeLayer *masklayer = [CAShapeLayer layer];
    masklayer.path = endCycle.CGPath;
    if (_isPresent) {
        _toview.layer.mask = masklayer;
    }else{
        [_containerView addSubview: _formview];
        _formview.layer.mask = masklayer;
    }
    CABasicAnimation *maskbasic = [CABasicAnimation animationWithKeyPath:@"path"];
    maskbasic.fromValue = (__bridge id _Nullable)(startCycle.CGPath);
    maskbasic.toValue = (__bridge id _Nullable)(endCycle.CGPath);
    maskbasic.duration = _duration;
    maskbasic.delegate = self;
    [maskbasic setValue:transitionContext forKey:@"transitionContext"];
    [masklayer addAnimation:maskbasic forKey:@""];
}

//动画结束后 才可以完全切换 不然有黑背景
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    id<UIViewControllerContextTransitioning> transitionContext = [anim valueForKey:@"transitionContext"];
    BOOL isCancelled = [transitionContext transitionWasCancelled];
    [transitionContext completeTransition:!isCancelled];
}






@end
