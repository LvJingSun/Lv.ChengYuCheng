//
//  NoticeAlertView.m
//  HuiHui
//
//  Created by mac on 2017/11/2.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "NoticeAlertView.h"
#import "LJConst.h"

@interface NoticeAlertView () {
    
    UIImageView *_contentView;
    
    CGFloat viewWidth;
    
    CGFloat viewHeight;
    
}

@end

@implementation NoticeAlertView

- (instancetype)initWithImg:(NSString *)imgName {
    
    if (self = [super init]) {
        
        self.frame = CGRectMake(0, 0, _WindowViewWidth, _WindowViewHeight);
        
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
        
        if (_contentView == nil) {
            
            UIButton *disbtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, _WindowViewWidth, _WindowViewHeight)];
            
            [disbtn addTarget:self action:@selector(dismissFromView) forControlEvents:UIControlEventTouchUpInside];
            
            [self addSubview:disbtn];
            
            viewWidth = _WindowViewWidth * 0.9;
            
            viewHeight = viewWidth * 1.2857;
            
            _contentView = [[UIImageView alloc] initWithFrame:CGRectMake((_WindowViewWidth - viewWidth) * 0.5, (_WindowViewHeight - viewHeight) * 0.5, viewWidth, viewHeight)];
            
            _contentView.image = [UIImage imageNamed:imgName];
            
            [self addSubview:_contentView];
            
            UIButton *close = [[UIButton alloc] initWithFrame:CGRectMake(_WindowViewWidth * 0.95 - 30, (_WindowViewHeight - viewHeight) * 0.5 - 30, 30, 30)];
            
            [close setImage:[UIImage imageNamed:@"closeAlert.png"] forState:0];
            
            [close addTarget:self action:@selector(dismissFromView) forControlEvents:UIControlEventTouchUpInside];
            
            [self addSubview:close];
            
        }
        
    }
    
    return self;
    
}

- (void)showInView:(UIView *)view {
    
    if (!view) {
        
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

- (void)dismissFromView {
    
    [_contentView setFrame:CGRectMake((_WindowViewWidth - viewWidth) * 0.5, (_WindowViewHeight - viewHeight) * 0.5, viewWidth, viewHeight)];
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.alpha = 0.0;
        
        [_contentView setFrame:CGRectMake(_WindowViewWidth * 0.5, _WindowViewHeight * 0.5, 0, 0)];
        
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
        
        [_contentView removeFromSuperview];
        
    }];
    
}

@end
