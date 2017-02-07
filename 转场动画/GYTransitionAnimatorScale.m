//
//  GYTransitionAnimatorScale.m
//  转场动画
//
//  Created by GeYang on 2017/2/6.
//  Copyright © 2017年 GeYang. All rights reserved.
//

#import "GYTransitionAnimatorScale.h"

@interface GYTransitionAnimatorScale()
@property (nonatomic, strong) UIView *formview;
@property (nonatomic, strong) UIView *toview;
@property (nonatomic, strong) UIView *containerView;
@end

@implementation GYTransitionAnimatorScale

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
    
    /*
     跳转时，将toview缩小至小图片大小，动画放大还原
     返回时，将formview缩放到小图片大小
     注：（A present B, A为fromview，B为toview       B dismiss A, B为fromview A为toview）
     **/
    //跳转前  获取跳转后的view
    UIView *pictureView = _isPresent? _toview : _formview;
    [_containerView bringSubviewToFront: pictureView];//将视图显示在最前面（dismiss不写  则无过渡动画效果）
    
    //获取缩放比例x轴
    CGFloat scaleX = CGRectGetWidth(self.currentFrame) / CGRectGetWidth(pictureView.frame);
    //获取缩放比例y轴
    CGFloat scaleY = CGRectGetHeight(self.currentFrame) / CGRectGetHeight(pictureView.frame);
    //获取小图片的中心
    CGPoint currentCenter = CGPointMake(CGRectGetMidX(self.currentFrame), CGRectGetMidY(self.currentFrame));
    //获取大图片的中心
    CGPoint pictureCenter = CGPointMake(CGRectGetMidX(pictureView.frame), CGRectGetMidY(pictureView.frame));
    
    CGAffineTransform startTransform ;//动画开始前的变形
    CGPoint startCenter;//动画开始前要移动到的位置
    
    CGAffineTransform endtransform;//动画中的变形
    CGPoint endCenter;//动画中要移动到的位置
    
    if (_isPresent) {
        //如果是present
        startTransform = CGAffineTransformMakeScale(scaleX, scaleY);//缩放到小图片的大小
        startCenter = currentCenter;//移动到小图片的中心
        endtransform = CGAffineTransformIdentity;//动画中要求还原成大图片
        endCenter = pictureCenter;//动画中要求移动到大图片的中心
    }else{
        //如果是dismiss
        startTransform = CGAffineTransformIdentity;//要求先还原大图片
        startCenter = pictureCenter;//中心为大图片中心
        endtransform = CGAffineTransformMakeScale(scaleX, scaleY);//缩放成小图片大小
        endCenter = currentCenter;//中心为小图片的中心
    }
    
    //先变形
    pictureView.transform = startTransform;
    //设置中心
    pictureView.center = startCenter;
    //执行动画
    [UIView animateWithDuration:_duration animations:^{
        pictureView.transform = endtransform;//目标变形
        pictureView.center = endCenter;//目标中心
    } completion:^(BOOL finished) {
        BOOL isCancelled = [transitionContext transitionWasCancelled];
        [transitionContext completeTransition:!isCancelled];
    }];
}


@end
