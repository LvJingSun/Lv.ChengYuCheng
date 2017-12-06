//
//  ShareGameView.m
//  HuiHui
//
//  Created by mac on 2017/6/2.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "ShareGameView.h"
#import "LJConst.h"
#import "ShareBtnView.h"

#define TitleColor [UIColor colorWithRed:0/255. green:0/255. blue:0/255. alpha:1.]
#define iconW 57.f
#define alertW ([UIScreen mainScreen].bounds.size.width) * 0.7
#define heightMargin 30.f

@interface ShareGameView () {

    CGFloat alertH;
    
}

@property (nonatomic, strong) ShareBtnView *QQShareView;

@property (nonatomic, strong) ShareBtnView *WeChatShareView;

@property (nonatomic, strong) ShareBtnView *HuiHuiShareView;

@property (nonatomic, strong) ShareBtnView *QQZoneShareView;

@property (nonatomic, strong) ShareBtnView *WeChatZoneShareView;

@property (nonatomic, strong) ShareBtnView *HuiHuiZoneShareView;

@property (nonatomic, strong) UIButton *cancleBtn;

@property (nonatomic, strong) UIView *backimageView;

@property (nonatomic, strong) UIView *bjView;

@end

@implementation ShareGameView

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        
        
        
    }
    
    return self;
    
}

- (instancetype)initWithCancle:(NSString *)cancleText {

    if (self = [super init]) {
        
        self.layer.cornerRadius = 5.0;
        
        self.backgroundColor = [UIColor whiteColor];
        
        self.QQShareView = [[ShareBtnView alloc] initWithFrame:CGRectMake(0, 0, alertW * 0.33333, 90)];
        
        [self.QQShareView.button setImage:[UIImage imageNamed:@"Share_QQ.png"] forState:0];
        
        self.QQShareView.title.text = @"QQ好友";
        
        [self.QQShareView.button addTarget:self action:@selector(QQClick) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:self.QQShareView];
        
        self.WeChatShareView = [[ShareBtnView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.QQShareView.frame), 0, alertW * 0.33333, 90)];
        
        [self.WeChatShareView.button setImage:[UIImage imageNamed:@"Share_WeChat.png"] forState:0];
        
        self.WeChatShareView.title.text = @"微信好友";
        
        [self.WeChatShareView.button addTarget:self action:@selector(WeChatClick) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:self.WeChatShareView];
        
        self.HuiHuiShareView = [[ShareBtnView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.WeChatShareView.frame), 0, alertW * 0.33333, 90)];
        
        [self.HuiHuiShareView.button setImage:[UIImage imageNamed:@"Share_huihui.png"] forState:0];
        
        self.HuiHuiShareView.title.text = @"城与城好友";
        
        [self.HuiHuiShareView.button addTarget:self action:@selector(HuiHuiClick) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:self.HuiHuiShareView];
        
        self.QQZoneShareView = [[ShareBtnView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.QQShareView.frame), alertW * 0.33333, 90)];
        
        [self.QQZoneShareView.button setImage:[UIImage imageNamed:@"Share_qqZone.png"] forState:0];
        
        self.QQZoneShareView.title.text = @"QQ空间";
        
        [self.QQZoneShareView.button addTarget:self action:@selector(QQZoneClick) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:self.QQZoneShareView];
        
        self.WeChatZoneShareView = [[ShareBtnView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.QQShareView.frame), CGRectGetMaxY(self.WeChatShareView.frame), alertW * 0.33333, 90)];
        
        [self.WeChatZoneShareView.button setImage:[UIImage imageNamed:@"Share_wechatZone.png"] forState:0];
        
        self.WeChatZoneShareView.title.text = @"朋友圈";
        
        [self.WeChatZoneShareView.button addTarget:self action:@selector(WeChatZoneClick) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:self.WeChatZoneShareView];
        
        self.HuiHuiZoneShareView = [[ShareBtnView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.WeChatZoneShareView.frame), CGRectGetMaxY(self.HuiHuiShareView.frame), alertW * 0.33333, 90)];
        
        [self.HuiHuiZoneShareView.button setImage:[UIImage imageNamed:@"Share_huihuiZone.png"] forState:0];
        
        self.HuiHuiZoneShareView.title.text = @"城与城圈子";
        
        [self.HuiHuiZoneShareView.button addTarget:self action:@selector(HuiHuiZoneClick) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:self.HuiHuiZoneShareView];
        
        self.cancleBtn = [[UIButton alloc] initWithFrame:CGRectMake(alertW * 0.05, CGRectGetMaxY(self.HuiHuiZoneShareView.frame) + heightMargin, alertW * 0.9, 40)];
        
        [self.cancleBtn setBackgroundImage:[UIImage imageNamed:@"blue_btn.png"] forState:0];
        
        [self.cancleBtn setTitle:cancleText forState:0];
        
        [self.cancleBtn setTitleColor:[UIColor whiteColor] forState:0];
        
        [self.cancleBtn addTarget:self action:@selector(CancleClick) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:self.cancleBtn];
        
        alertH = CGRectGetMaxY(self.cancleBtn.frame) + 10;
        
    }
    
    return self;
    
}

- (void)QQClick {

    if (self.QQBlock) {
        
        self.QQBlock();
        
    }
    
    [self dismissAlert];
    
}

- (void)QQZoneClick {
    
    if (self.QQZoneBlock) {
        
        self.QQZoneBlock();
        
    }
    
    [self dismissAlert];
    
}

- (void)WeChatClick {
    
    if (self.WeChatBlock) {
        
        self.WeChatBlock();
        
    }
    
    [self dismissAlert];
    
}

- (void)WeChatZoneClick {
    
    if (self.WeChatZoneBlock) {
        
        self.WeChatZoneBlock();
        
    }
    
    [self dismissAlert];
    
}

- (void)HuiHuiClick {
    
    if (self.HuiHuiBlock) {
        
        self.HuiHuiBlock();
        
    }
    
    [self dismissAlert];
    
}

- (void)HuiHuiZoneClick {
    
    if (self.HuiHuiZoneBlock) {
        
        self.HuiHuiZoneBlock();
        
    }
    
    [self dismissAlert];
    
}

- (void)CancleClick {
    
    if (self.CancleBlock) {
        
        self.CancleBlock();
        
    }
    
    [self dismissAlert];
    
}

- (void)dismissAlert {

    [self.bjView removeFromSuperview];
    
    [self removeFromSuperview];
    
}

- (void)show {

    //获取第一响应视图视图
    UIViewController *topVC = [self appRootViewController];
    
    UIView *bjview = [[UIView alloc] initWithFrame:topVC.view.bounds];
    
    self.bjView = bjview;
    
    bjview.backgroundColor = [UIColor colorWithRed:0/255. green:0/255. blue:0/255. alpha:0.7];
    
    self.frame = CGRectMake((CGRectGetWidth(topVC.view.bounds) - alertW) * 0.5, (CGRectGetHeight(topVC.view.bounds) - alertH) * 0.5, alertW, alertH);
    
    self.alpha = 1.f;
    
    [topVC.view addSubview:bjview];
    
    [topVC.view addSubview:self];
    
}

- (UIViewController *)appRootViewController {
    
    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    UIViewController *topVC = appRootVC;
    
    while (topVC.presentedViewController) {
        
        topVC = topVC.presentedViewController;
        
    }
    
    return topVC;
    
}

- (void)removeFromSuperview {
    
    [self.backimageView removeFromSuperview];
    
    self.backimageView = nil;
    
    UIViewController *topVC = [self appRootViewController];
    
    CGRect afterFrame = CGRectMake((CGRectGetWidth(topVC.view.bounds) - alertW) * 0.5, (CGRectGetHeight(topVC.view.bounds) - alertH) * 0.5, alertW, alertH);
    
    [UIView animateWithDuration:0.3f delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        self.frame = afterFrame;
        
        self.alpha=1.f;
        
    } completion:^(BOOL finished) {
        
        [super removeFromSuperview];
        
    }];
    
}
//添加新视图时调用（在一个子视图将要被添加到另一个视图的时候发送此消息）
- (void)willMoveToSuperview:(UIView *)newSuperview
{
    if (newSuperview == nil) {
        return;
    }
    //     获取根控制器
    UIViewController *topVC = [self appRootViewController];
    
    if (!self.backimageView) {
        self.backimageView = [[UIView alloc] initWithFrame:topVC.view.bounds];
        self.backimageView.backgroundColor = [UIColor clearColor];
        self.backimageView.alpha = 0.7f;
        self.backimageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    }
    //    加载背景背景图,防止重复点击
    [topVC.view addSubview:self.backimageView];
    CGRect afterFrame = CGRectMake((CGRectGetWidth(topVC.view.bounds) - alertW) * 0.5, (CGRectGetHeight(topVC.view.bounds) - alertH) * 0.5, alertW, alertH);
    [UIView animateWithDuration:0.3f delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.frame = afterFrame;
        self.alpha=1.f;
    } completion:^(BOOL finished) {
    }];
    [super willMoveToSuperview:newSuperview];
}

@end
