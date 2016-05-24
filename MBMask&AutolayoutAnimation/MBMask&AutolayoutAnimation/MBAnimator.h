//
//  MBAnimator.h
//  MBMask&AutolayoutAnimation
//
//  Created by 牛逸飞 on 16/5/24.
//  Copyright © 2016年 MikeBoom. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface MBAnimator : NSObject

+ (void)titleLabelAnimationWithLabel:(UILabel *)label;

+ (void)mobileImageViewAnimationWithImageView:(UIImageView *)imageView;

+ (void)textFieldBottomLineAnimationWithConstraint:(NSLayoutConstraint *)constraint andView:(UIView *)view;

+ (void)maskAnimationWithView:(UIView *)view andBeginTime:(NSTimeInterval)beginTime;

+ (void)maskAnimationWithButton:(UIButton *)button andProgress:(CGFloat)progress;

@end
