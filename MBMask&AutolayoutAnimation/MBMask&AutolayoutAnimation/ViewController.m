//
//  ViewController.m
//  MBMask&AutolayoutAnimation
//
//  Created by 牛逸飞 on 16/5/24.
//  Copyright © 2016年 MikeBoom. All rights reserved.
//

#import "ViewController.h"
#import "MBAnimator.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *topTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *bottomTitleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *mobileImageView;
@property (weak, nonatomic) IBOutlet UIImageView *mobileBottomLineImageView;
@property (weak, nonatomic) IBOutlet UITextField *mobileNumberTextField;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomLineConstraint;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UILabel *topTipsLabel;
@property (weak, nonatomic) IBOutlet UIView *bottomTipsView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.topTitleLabel.transform = CGAffineTransformMakeTranslation(0, -200);
    self.bottomTitleLabel.transform = CGAffineTransformMakeTranslation(0, -200);
    
    _mobileImageView.transform = CGAffineTransformMakeTranslation(-200, 0);
    
    _bottomLineConstraint.constant = 0;
    
    // 为登录button添加遮罩
    [MBAnimator maskAnimationWithButton:self.loginButton andProgress:0.0];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // 执行动画
    [MBAnimator titleLabelAnimationWithLabel:self.topTitleLabel];
    [MBAnimator titleLabelAnimationWithLabel:self.bottomTitleLabel];
    
    [MBAnimator mobileImageViewAnimationWithImageView:_mobileImageView];

    [MBAnimator textFieldBottomLineAnimationWithConstraint:self.bottomLineConstraint andView:self.view];
    
    [MBAnimator maskAnimationWithView:_topTipsLabel andBeginTime:0];
    [MBAnimator maskAnimationWithView:_bottomTipsView andBeginTime:1.5];

}

/**
 *  输入手机号码textField的监听方法
 *
 *  @param sender 监听的textField
 */
- (IBAction)performButtonMaskAnimationWithTextField:(UITextField *)sender {
    NSInteger length = sender.text.length;
    
    // 1.计算用户输入手机号的进度
    CGFloat progress = length / 11.0;
    
    // 2.执行动画
    [MBAnimator maskAnimationWithButton:self.loginButton andProgress:progress];
    
    // 3.用户输入手机号码为11位时登录按钮才可用
    if (length < 11) {
        sender.enabled = YES;
        self.loginButton.enabled = NO;
    } else if (length == 11){
        self.loginButton.enabled = YES;
    }
}

/**
 *  触摸屏幕结束编辑退出键盘
 */
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

@end
