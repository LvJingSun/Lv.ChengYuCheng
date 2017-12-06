//
//  TuiJian_ShareView.m
//  HuiHui
//
//  Created by mac on 2017/11/20.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "TuiJian_ShareView.h"
#import "LJConst.h"

@interface TuiJian_ShareView () {
    
    CGFloat viewWidth;
    
    CGFloat viewHeight;
    
    UIView *_contentView;
    
}

@end

@implementation TuiJian_ShareView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
        
        if (_contentView == nil) {
            
            UIButton *disbtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
            
            [disbtn addTarget:self action:@selector(disMissView) forControlEvents:UIControlEventTouchUpInside];
            
            [self addSubview:disbtn];
            
            _contentView = [[UIView alloc] init];
            
            viewWidth = frame.size.width;
            
            CGFloat WW = 20;
            
            CGFloat btnWidth = 60;
            
            CGFloat btnHeight = btnWidth;
            
            UIButton *qq = [[UIButton alloc] initWithFrame:CGRectMake(WW, WW, btnWidth, btnHeight)];
            
            [qq setImage:[UIImage imageNamed:@"qq.png"] forState:0];
            
            [qq addTarget:self action:@selector(qqClick) forControlEvents:UIControlEventTouchUpInside];
            
            [_contentView addSubview:qq];
            
            CGFloat MM = (_WindowViewWidth - 2 * WW - 4 * btnWidth) * 0.33333;
            
            CGFloat titleHeight = 15;
            
            UILabel *qqtitle = [[UILabel alloc] initWithFrame:CGRectMake(WW, CGRectGetMaxY(qq.frame) + 3, btnWidth, titleHeight)];
            
            qqtitle.text = @"QQ";
            
            qqtitle.font = [UIFont systemFontOfSize:14];
            
            qqtitle.textAlignment = NSTextAlignmentCenter;
            
            qqtitle.textColor = [UIColor darkTextColor];
            
            [_contentView addSubview:qqtitle];
            
            UIButton *qzone = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(qq.frame) + MM, WW, btnWidth, btnHeight)];
            
            [qzone setImage:[UIImage imageNamed:@"zoon.png"] forState:0];
            
            [qzone addTarget:self action:@selector(qzoneClick) forControlEvents:UIControlEventTouchUpInside];
            
            [_contentView addSubview:qzone];
            
            UILabel *qzonetitle = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(qq.frame) + MM, CGRectGetMaxY(qq.frame) + 3, btnWidth, titleHeight)];
            
            qzonetitle.text = @"QQ空间";
            
            qzonetitle.font = [UIFont systemFontOfSize:14];
            
            qzonetitle.textAlignment = NSTextAlignmentCenter;
            
            qzonetitle.textColor = [UIColor darkTextColor];
            
            [_contentView addSubview:qzonetitle];
            
            UIButton *wx = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(qzone.frame) + MM, WW, btnWidth, btnHeight)];
            
            [wx setImage:[UIImage imageNamed:@"weixin.png"] forState:0];
            
            [wx addTarget:self action:@selector(wxClick) forControlEvents:UIControlEventTouchUpInside];
            
            [_contentView addSubview:wx];
            
            UILabel *wxtitle = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(qzone.frame) + MM, CGRectGetMaxY(qq.frame) + 3, btnWidth, titleHeight)];
            
            wxtitle.text = @"微信";
            
            wxtitle.font = [UIFont systemFontOfSize:14];
            
            wxtitle.textAlignment = NSTextAlignmentCenter;
            
            wxtitle.textColor = [UIColor darkTextColor];
            
            [_contentView addSubview:wxtitle];
            
            UIButton *wxfriends = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(wx.frame) + MM, WW, btnWidth, btnHeight)];
            
            [wxfriends setImage:[UIImage imageNamed:@"friend.png"] forState:0];
            
            [wxfriends addTarget:self action:@selector(wxfriendsClick) forControlEvents:UIControlEventTouchUpInside];
            
            [_contentView addSubview:wxfriends];
            
            UILabel *wxfriendstitle = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(wx.frame) + MM, CGRectGetMaxY(qq.frame) + 3, btnWidth, titleHeight)];
            
            wxfriendstitle.text = @"朋友圈";
            
            wxfriendstitle.font = [UIFont systemFontOfSize:14];
            
            wxfriendstitle.textAlignment = NSTextAlignmentCenter;
            
            wxfriendstitle.textColor = [UIColor darkTextColor];
            
            [_contentView addSubview:wxfriendstitle];
            
            UIButton *cancle = [[UIButton alloc] initWithFrame:CGRectMake(WW, CGRectGetMaxY(qqtitle.frame) + 3, frame.size.width - 2 * WW, 30)];
            
            [cancle setTitle:@"取消" forState:0];
            
            [cancle setTitleColor:[UIColor whiteColor] forState:0];
            
            [cancle setBackgroundColor:FSB_StyleCOLOR];
            
            cancle.titleLabel.font = [UIFont systemFontOfSize:16];
            
            [cancle addTarget:self action:@selector(disMissView) forControlEvents:UIControlEventTouchUpInside];
            
            [_contentView addSubview:cancle];
            
            viewHeight = CGRectGetMaxY(cancle.frame) + 5;
            
            _contentView.frame = CGRectMake(0, _WindowViewHeight - viewHeight, viewWidth, viewHeight);
            
            _contentView.backgroundColor = [UIColor whiteColor];
            
            [self addSubview:_contentView];
            
        }
        
    }
    
    return self;
    
}

- (void)qqClick {
    
    if (self.QQ_Block) {
        
        self.QQ_Block();
        
    }
    
}

- (void)qzoneClick {
    
    if (self.QZone_Block) {
        
        self.QZone_Block();
        
    }
    
}

- (void)wxClick {
    
    if (self.WX_Block) {
        
        self.WX_Block();
        
    }
    
}

- (void)wxfriendsClick {
    
    if (self.WXFriends_Block) {
        
        self.WXFriends_Block();
        
    }
    
}

//展示从底部向上弹出的UIView（包含遮罩）
- (void)showInView:(UIView *)view
{
    if (!view)
    {
        return;
    }
    
    [view addSubview:self];
    
    [view addSubview:_contentView];
    
    [_contentView setFrame:CGRectMake(0, _WindowViewHeight, viewWidth, viewHeight)];
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.alpha = 1.0;
        
        [_contentView setFrame:CGRectMake(0, _WindowViewHeight - viewHeight, viewWidth, viewHeight)];
        
    } completion:nil];
    
}

//移除从上向底部弹下去的UIView（包含遮罩）
- (void)disMissView
{
    [_contentView setFrame:CGRectMake(0, _WindowViewHeight - viewHeight, viewWidth, viewHeight)];
    
    [UIView animateWithDuration:0.3f
                     animations:^{
                         
                         self.alpha = 0.0;
                         
                         [_contentView setFrame:CGRectMake(0, _WindowViewHeight, viewWidth, viewHeight)];
                         
                     } completion:^(BOOL finished){
                         
                         [self removeFromSuperview];
                         
                         [_contentView removeFromSuperview];
                         
                     }];
    
}

@end
