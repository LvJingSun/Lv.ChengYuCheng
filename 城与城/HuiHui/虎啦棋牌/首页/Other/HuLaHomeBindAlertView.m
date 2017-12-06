//
//  HuLaHomeBindAlertView.m
//  HuiHui
//
//  Created by mac on 2017/11/8.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "HuLaHomeBindAlertView.h"
#import "LJConst.h"

@interface HuLaHomeBindAlertView () {
    
    UIView *_contentView;
    
    CGFloat viewWidth;
    
    CGFloat viewHeight;
    
}

@end

@implementation HuLaHomeBindAlertView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.frame = CGRectMake(0, 0, _WindowViewWidth, _WindowViewHeight);
        
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
        
        if (_contentView == nil) {
            
            viewWidth = _WindowViewWidth * 0.8;
            
            viewHeight = 177;
            
            _contentView = [[UIView alloc] init];
            
            _contentView.frame = CGRectMake((_WindowViewWidth - viewWidth) * 0.5, (_WindowViewHeight - viewHeight) * 0.5, viewWidth, viewHeight);
            
            _contentView.layer.masksToBounds = YES;
            
            _contentView.layer.cornerRadius = 5;
            
            _contentView.backgroundColor = [UIColor whiteColor];
            
            UILabel *IDtitle = [[UILabel alloc] initWithFrame:CGRectMake(viewWidth * 0.15, 30, viewWidth * 0.25, 25)];
            
            IDtitle.text = @"输入ID";
            
            IDtitle.textColor = [UIColor darkTextColor];
            
            IDtitle.textAlignment = NSTextAlignmentCenter;
            
            IDtitle.font = [UIFont systemFontOfSize:17];
            
            [_contentView addSubview:IDtitle];
            
            UITextField *IDfield = [[UITextField alloc] initWithFrame:CGRectMake(viewWidth * 0.45, 30, viewWidth * 0.4, 25)];
            
            self.IDfield = IDfield;
            
            IDfield.font = [UIFont systemFontOfSize:16];
            
            IDfield.layer.masksToBounds = YES;
            
            IDfield.layer.borderWidth = 1.5;
            
            IDfield.layer.borderColor = FSB_StyleCOLOR.CGColor;
            
            IDfield.layer.cornerRadius = 3;
            
            IDfield.keyboardType = UIKeyboardTypeDecimalPad;
            
            [_contentView addSubview:IDfield];
            
            UILabel *notice = [[UILabel alloc] initWithFrame:CGRectMake(viewWidth * 0.15, CGRectGetMaxY(IDtitle.frame) + 20, viewWidth * 0.7, 25)];
            
            self.noticeLab = notice;
            
            notice.textAlignment = NSTextAlignmentCenter;
            
            notice.textColor = [UIColor darkTextColor];
            
            notice.font = [UIFont systemFontOfSize:17];
            
            notice.text = @"请输入ID进行检测";
            
            [_contentView addSubview:notice];
            
            UILabel *line1 = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(notice.frame) + 25, viewWidth, 2)];
            
            line1.backgroundColor = FSB_StyleCOLOR;
            
            [_contentView addSubview:line1];
            
            UILabel *line2 = [[UILabel alloc] initWithFrame:CGRectMake((viewWidth - 2) * 0.5, CGRectGetMaxY(line1.frame), 2, 50)];
            
            line2.backgroundColor = FSB_StyleCOLOR;
            
            [_contentView addSubview:line2];
            
            UIButton *bindBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(line1.frame), (viewWidth - 2) * 0.5, 50)];
            
            [bindBtn setTitle:@"绑定游戏" forState:0];
            
            [bindBtn setTitleColor:FSB_StyleCOLOR forState:0];
            
            [bindBtn addTarget:self action:@selector(bindClick) forControlEvents:UIControlEventTouchUpInside];
            
            [_contentView addSubview:bindBtn];
            
            UIButton *cancleBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(line2.frame), CGRectGetMaxY(line1.frame), (viewWidth - 2) * 0.5, 50)];
            
            [cancleBtn setTitle:@"取消" forState:0];
            
            [cancleBtn setTitleColor:FSB_StyleCOLOR forState:0];
            
            [cancleBtn addTarget:self action:@selector(disMissView) forControlEvents:UIControlEventTouchUpInside];
            
            [_contentView addSubview:cancleBtn];
            
            [self addSubview:_contentView];
            
        }

        
    }
    
    return self;
    
}

- (void)bindClick {
    
    if (self.bindClickBlock) {
        
        self.bindClickBlock();
        
    }
    
    [self hideKeyBoard];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self hideKeyBoard];
    
}

- (void)hideKeyBoard {
    
    if ([self.IDfield isFirstResponder]) {
        
        [self.IDfield resignFirstResponder];
        
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
    
    [_contentView setFrame:CGRectMake(_WindowViewWidth * 0.5, _WindowViewHeight * 0.5, 0, 0)];
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.alpha = 1.0;
        
        [_contentView setFrame:CGRectMake((_WindowViewWidth - viewWidth) * 0.5, (_WindowViewHeight - viewHeight) * 0.5, viewWidth, viewHeight)];
        
    } completion:nil];
    
}

- (void)dismiss {
    
    [self disMissView];
    
}

//移除从上向底部弹下去的UIView（包含遮罩）
- (void)disMissView
{
    [_contentView setFrame:CGRectMake((_WindowViewWidth - viewWidth) * 0.5, (_WindowViewHeight - viewHeight) * 0.5, viewWidth, viewHeight)];
    
    [UIView animateWithDuration:0.3f
                     animations:^{
                         
         self.alpha = 0.0;
         
         [_contentView setFrame:CGRectMake(_WindowViewWidth * 0.5, _WindowViewHeight * 0.5, 0, 0)];
                         
    } completion:^(BOOL finished){
                         
         [self removeFromSuperview];
        
         [_contentView removeFromSuperview];
                         
    }];    
    
}


@end
