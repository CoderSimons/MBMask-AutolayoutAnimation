//
//  MBAnimator.m
//  MBMask&AutolayoutAnimation
//
//  Created by 牛逸飞 on 16/5/24.
//  Copyright © 2016年 MikeBoom. All rights reserved.
//

#import "MBAnimator.h"

static CGFloat const kBottomLineWidth = 275.0;

@interface MBAnimator ()
@end

@implementation MBAnimator

/**
 *  label的动画: 垂直方向平移
 */
+ (void)titleLabelAnimationWithLabel:(UILabel *)label {
    
    [UIView animateWithDuration:2 animations:^{
        label.transform = CGAffineTransformIdentity;
    }];
}
/**
 *  手机图标的动画: 水平方向平移
 */
+ (void)mobileImageViewAnimationWithImageView:(UIImageView *)imageView {
    [UIView animateWithDuration:2 animations:^{
        imageView.transform = CGAffineTransformIdentity;
    }];
}

/**
 *  约束动画: 输入手机的textField底部细线的动画, 长度从0逐渐从中间向两边伸长
 *
 *  @param constraint 执行动画的约束
 *  @param view       执行约束动画必须 更新 (执行动画的约束的控件的父控件) 的 布局
 */
+ (void)textFieldBottomLineAnimationWithConstraint:(NSLayoutConstraint *)constraint andView:(UIView *)view {
    constraint.constant = kBottomLineWidth;
    [UIView animateWithDuration:2 animations:^{
        [view layoutIfNeeded];
    }];
}

/**
 *  普通的遮罩动画: 为要展示动画的控件配置一个遮罩图层,对该图层设置动画,让该图层从一个path变成另一个Path
 *
 *  @param view      需要遮罩的控件
 *  @param beginTime 遮罩动画的开始时间
 */
+ (void)maskAnimationWithView:(UIView *)view andBeginTime:(NSTimeInterval)beginTime {
    // 1.创建遮罩layer的path, 从动画前到动画后两种边框path
    CGPathRef beginPath = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, 0, CGRectGetHeight(view.frame))].CGPath;
    CGPathRef endPath = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, CGRectGetWidth(view.frame), CGRectGetHeight(view.frame))].CGPath;
    
    // 2.创建遮罩layer, 并初始化遮罩层的边框路径和填充色
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = beginPath;
    maskLayer.fillColor = [UIColor whiteColor].CGColor;

    // 3.为图层创建动画
    CABasicAnimation *maskAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    maskAnimation.duration = 1.5;
    maskAnimation.beginTime = CACurrentMediaTime() + beginTime;
    maskAnimation.fromValue = (__bridge id _Nullable)(maskLayer.path);
    maskAnimation.toValue = (__bridge id _Nullable)(endPath);
    maskAnimation.removedOnCompletion = NO;
    maskAnimation.fillMode = kCAFillModeForwards;
    [maskLayer addAnimation:maskAnimation forKey:nil];
    
    // 4.设置需执行动画控件的遮罩图层
    view.layer.mask = maskLayer;
};

/**
 *  程序刚启动时给button添加遮罩, 再根据用户输入的手机号进度为button执行相应的动画
 *
 *  @param button   为button执行动画
 *  @param progress 用户输入手机号的进度, 由此来确定遮罩path的大小
 */
+ (void)maskAnimationWithButton:(UIButton *)button andProgress:(CGFloat)progress {
    // 程序一启动, 我就应该给button加上遮罩, 第一次只是加遮罩, 还不用执行动画
    static CAShapeLayer *maskLayer = nil;
    if (!maskLayer) {
        maskLayer = [CAShapeLayer layer];
        maskLayer.fillColor = [UIColor whiteColor].CGColor;
        maskLayer.path = (__bridge CGPathRef)([UIBezierPath bezierPathWithRect:CGRectMake(0, 0, CGRectGetWidth(button.frame) * progress, CGRectGetHeight(button.frame))]);
        button.layer.mask = maskLayer;
    } else {
        
        // 1.根据传入的progress为图层更新path
        CGPathRef updatePath = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, CGRectGetWidth(button.frame) * progress, CGRectGetHeight(button.frame))].CGPath;
        
        // 2.为图层创建动画
        CABasicAnimation *buttonMaskAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
        buttonMaskAnimation.duration = 0.25;
        buttonMaskAnimation.fromValue = (__bridge id)maskLayer.path;
        buttonMaskAnimation.toValue = (__bridge id)updatePath;
        buttonMaskAnimation.removedOnCompletion = NO;
        buttonMaskAnimation.fillMode = kCAFillModeForwards;
        [maskLayer addAnimation:buttonMaskAnimation forKey:nil];
        
        // 3.记录遮罩图层的最新路径
        maskLayer.path = updatePath;
    }
}

@end
