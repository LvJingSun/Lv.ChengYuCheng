//
//  XWAlterview.m
//  new
//
//  Created by chinat2t on 14-11-6.
//  Copyright (c) 2014年 chinat2t. All rights reserved.
//

#import "XWAlterview.h"

#define AlertTextColor [UIColor colorWithRed:65/255. green:148/255. blue:97/255. alpha:1.]
// 设置警告框的长和宽

#define Alertwidth 240.0f
//        设置按钮距离底部的边距

//icon的宽度
#define IconWidth 80.0f
//间隔长度
#define Margin 15.0f
//标题字体大小
#define TitleTextFont [UIFont systemFontOfSize:17.f]
//标题字体颜色
#define TitleTextColor [UIColor colorWithRed:50/255. green:50/255. blue:50/255. alpha:1.]
//内容字体大小
#define ContentTextFont [UIFont systemFontOfSize:15.f]
//内容字体颜色
#define ContentTextColor [UIColor colorWithRed:50/255. green:50/255. blue:50/255. alpha:1.]
//线的颜色
#define LineColor [UIColor colorWithRed:237/255. green:237/255. blue:237/255. alpha:1.]
//线的宽度
#define LineWidth 1.0f
//按钮的高度
#define BtnHeight 40.0f
//按钮字体的颜色
#define BtnTextColor [UIColor colorWithRed:2/255. green:141/255. blue:227/255. alpha:1.]
//按钮字体大小
#define BtnTextFont [UIFont systemFontOfSize:16.f]


@interface XWAlterview ()
{
    BOOL _leftLeave;
    
    CGFloat viewHeight;
}

@property (nonatomic, strong) UILabel *alertTitleLabel;
@property (nonatomic, strong) UILabel *alertContentLabel;
@property (nonatomic, strong) UIButton *leftbtn;
@property (nonatomic, strong) UIButton *rightbtn;
@property (nonatomic, strong) UIView *backimageView;
@property (nonatomic, strong) UIView *bjView;

@property (nonatomic, strong) UIImageView *iconImageview;
@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UILabel *contentLab;
@property (nonatomic, strong) UIButton *cancleBtn;
@property (nonatomic, strong) UIButton *sureBtn;

@end

@implementation XWAlterview

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {

    }
    
    return self;
    
}

- (id)initWithIcon:(NSString *)iconImage
           Content:(NSString *)contentText
             Title:(NSString *)titleText
            Cancle:(NSString *)cancleText
              Sure:(NSString *)sureText {
    
    if (self = [super init]) {
        
        self.layer.cornerRadius = 5.0;
        
        self.backgroundColor = [UIColor colorWithRed:255/255. green:255/255. blue:255/255. alpha:1.];
        
        self.iconImageview = [[UIImageView alloc] initWithFrame:CGRectMake((Alertwidth - IconWidth) * 0.5, Margin, IconWidth, IconWidth)];
        
        self.iconImageview.layer.masksToBounds = YES;
        
        self.iconImageview.layer.cornerRadius = IconWidth * 0.5;
        
        [self addSubview:self.iconImageview];
        
        self.iconImageview.image = [UIImage imageNamed:iconImage];
        
        self.titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.iconImageview.frame) + Margin, Alertwidth, 20)];
        
        self.titleLab.font = TitleTextFont;
        
        self.titleLab.textColor = TitleTextColor;
        
        self.titleLab.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:self.titleLab];
        
        self.titleLab.text = titleText;
        
        CGSize contentSize = [self sizeWithText:contentText font:ContentTextFont maxSize:CGSizeMake(Alertwidth * 0.8, 0)];
        
        self.contentLab = [[UILabel alloc] initWithFrame:CGRectMake(Alertwidth * 0.1, CGRectGetMaxY(self.titleLab.frame) + Margin, Alertwidth * 0.8, contentSize.height)];
        
        self.contentLab.font = ContentTextFont;
        
        self.contentLab.textColor = ContentTextColor;
        
        self.contentLab.numberOfLines = 0;
        
        [self addSubview:self.contentLab];
        
        self.contentLab.text = contentText;
        
        UILabel *line1 = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.contentLab.frame) + Margin, Alertwidth, LineWidth)];
        
        line1.backgroundColor = LineColor;
        
        [self addSubview:line1];
        
        UILabel *line2 = [[UILabel alloc] initWithFrame:CGRectMake((Alertwidth - LineWidth) * 0.5, CGRectGetMaxY(line1.frame), LineWidth, BtnHeight)];
        
        line2.backgroundColor = LineColor;
        
        [self addSubview:line2];
        
        self.cancleBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(line1.frame), (Alertwidth - LineWidth) * 0.5, BtnHeight)];
        
        [self.cancleBtn setTitle:cancleText forState:0];
        
        [self.cancleBtn setTitleColor:BtnTextColor forState:0];
        
        self.cancleBtn.titleLabel.font = BtnTextFont;
        
        [self addSubview:self.cancleBtn];
        
        [self.cancleBtn addTarget:self action:@selector(CancleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        self.sureBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(line2.frame), CGRectGetMaxY(line1.frame), (Alertwidth - LineWidth) * 0.5, BtnHeight)];
        
        [self.sureBtn setTitle:sureText forState:0];
        
        [self.sureBtn setTitleColor:BtnTextColor forState:0];
        
        self.sureBtn.titleLabel.font = BtnTextFont;
        
        [self addSubview:self.sureBtn];
        
        [self.sureBtn addTarget:self action:@selector(SureBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        viewHeight = CGRectGetMaxY(self.sureBtn.frame);
        
    }
    
    return self;
    
}

- (id)initWithIcon:(NSString *)iconImage
           Content:(NSString *)contentText
             Title:(NSString *)titleText
              Sure:(NSString *)sureText {
    
    if (self = [super init]) {
        
        self.layer.cornerRadius = 5.0;
        
        self.backgroundColor = [UIColor colorWithRed:255/255. green:255/255. blue:255/255. alpha:1.];
        
        self.iconImageview = [[UIImageView alloc] initWithFrame:CGRectMake((Alertwidth - IconWidth) * 0.5, Margin, IconWidth, IconWidth)];
        
        self.iconImageview.layer.masksToBounds = YES;
        
        self.iconImageview.layer.cornerRadius = IconWidth * 0.5;
        
        [self addSubview:self.iconImageview];
        
        self.iconImageview.image = [UIImage imageNamed:iconImage];
        
        self.titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.iconImageview.frame) + Margin, Alertwidth, 20)];
        
        self.titleLab.font = TitleTextFont;
        
        self.titleLab.textColor = TitleTextColor;
        
        self.titleLab.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:self.titleLab];
        
        self.titleLab.text = titleText;
        
        CGSize contentSize = [self sizeWithText:contentText font:ContentTextFont maxSize:CGSizeMake(Alertwidth * 0.8, 0)];
        
        self.contentLab = [[UILabel alloc] initWithFrame:CGRectMake(Alertwidth * 0.1, CGRectGetMaxY(self.titleLab.frame) + Margin, Alertwidth * 0.8, contentSize.height)];
        
        self.contentLab.font = ContentTextFont;
        
        self.contentLab.textColor = ContentTextColor;
        
        self.contentLab.numberOfLines = 0;
        
        [self addSubview:self.contentLab];
        
        self.contentLab.text = contentText;
        
        UILabel *line1 = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.contentLab.frame) + Margin, Alertwidth, LineWidth)];
        
        line1.backgroundColor = LineColor;
        
        [self addSubview:line1];
        
        self.sureBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(line1.frame), Alertwidth, BtnHeight)];
        
        [self.sureBtn setTitle:sureText forState:0];
        
        [self.sureBtn setTitleColor:BtnTextColor forState:0];
        
        self.sureBtn.titleLabel.font = BtnTextFont;
        
        [self addSubview:self.sureBtn];
        
        [self.sureBtn addTarget:self action:@selector(SureBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        viewHeight = CGRectGetMaxY(self.sureBtn.frame);
        
        //        self.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
        
    }
    
    return self;
    
}

- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize {
    
    NSDictionary *attrs = @{NSFontAttributeName : font};
    
    return [text boundingRectWithSize:maxSize options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrs context:nil].size;
    
}

- (void)CancleBtnClick:(id)sender {
    
    if (self.leftBlock) {
        
        self.leftBlock();
        
    }
    
    [self dismissAlert];
    
}

- (void)SureBtnClick:(id)sender {
    
    if (self.rightBlock) {
        
        self.rightBlock();
        
    }
    
    [self dismissAlert];
    
}

- (void)show {
    
    //获取第一响应视图视图
    UIViewController *topVC = [self appRootViewController];
    
    UIView *bjview = [[UIView alloc] initWithFrame:topVC.view.bounds];
    
    self.bjView = bjview;
    
    bjview.backgroundColor = [UIColor colorWithRed:0/255. green:0/255. blue:0/255. alpha:0.7];
    
    self.frame = CGRectMake((CGRectGetWidth(topVC.view.bounds) - Alertwidth) * 0.5, (CGRectGetHeight(topVC.view.bounds) - viewHeight) * 0.5, Alertwidth, viewHeight);
    
    self.alpha=1.f;
    
    [topVC.view addSubview:bjview];
    
    [topVC.view addSubview:self];
    
}

- (void)dismissAlert {
    
    [self.bjView removeFromSuperview];
    
    [self removeFromSuperview];
    
    if (self.dismissBlock) {
        
        self.dismissBlock();
        
    }
    
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
    
    CGRect afterFrame = CGRectMake((CGRectGetWidth(topVC.view.bounds) - Alertwidth) * 0.5, (CGRectGetHeight(topVC.view.bounds) - viewHeight) * 0.5, Alertwidth, viewHeight);
    
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
    CGRect afterFrame = CGRectMake((CGRectGetWidth(topVC.view.bounds) - Alertwidth) * 0.5, (CGRectGetHeight(topVC.view.bounds) - viewHeight) * 0.5, Alertwidth, viewHeight);
    [UIView animateWithDuration:0.3f delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.frame = afterFrame;
        self.alpha=1.f;
    } completion:^(BOOL finished) {
    }];
    [super willMoveToSuperview:newSuperview];
}

@end


// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com 
