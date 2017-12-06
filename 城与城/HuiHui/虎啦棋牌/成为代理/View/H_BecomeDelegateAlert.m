//
//  H_BecomeDelegateAlert.m
//  HuiHui
//
//  Created by mac on 2017/11/15.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "H_BecomeDelegateAlert.h"
#import "LJConst.h"

@interface H_BecomeDelegateAlert () {
    
    CGFloat viewWidth;
    
    CGFloat viewHeight;
    
    UIView *_contentView;
    
}

@end

@implementation H_BecomeDelegateAlert

- (instancetype)initWithContent:(NSString *)contentText {
    
    if (self = [super init]) {
        
        self.frame = CGRectMake(0, 0, _WindowViewWidth, _WindowViewHeight);
        
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
        
        if (_contentView == nil) {
            
            UIButton *disbtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, _WindowViewWidth, _WindowViewHeight)];
            
            [disbtn addTarget:self action:@selector(disMissView) forControlEvents:UIControlEventTouchUpInside];
            
            [self addSubview:disbtn];
            
            _contentView = [[UIView alloc] init];
            
            viewWidth = _WindowViewWidth * 0.7;
            
            CGSize contentSize = [self sizeWithText:contentText font:[UIFont systemFontOfSize:16] maxSize:CGSizeMake(viewWidth * 0.8, 0)];
            
            viewHeight = contentSize.height + 60;
            
            _contentView.frame = CGRectMake((_WindowViewWidth - viewWidth) * 0.5, (_WindowViewHeight - viewHeight) * 0.5, viewWidth, viewHeight);
            
            _contentView.layer.masksToBounds = YES;
            
            _contentView.layer.cornerRadius = 5;
            
            _contentView.backgroundColor = [UIColor whiteColor];
            
            UILabel *contentLab = [[UILabel alloc] initWithFrame:CGRectMake(viewWidth * 0.1, (viewHeight - contentSize.height) * 0.5, viewWidth * 0.8, contentSize.height)];
            
            contentLab.text = contentText;
            
            contentLab.textColor = [UIColor darkTextColor];
            
            contentLab.font = [UIFont systemFontOfSize:16];
            
            contentLab.textAlignment = NSTextAlignmentCenter;
            
            contentLab.numberOfLines = 0;
            
            [_contentView addSubview:contentLab];
            
            [self addSubview:_contentView];
            
        }
        
    }
    
    return self;
    
}

- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize {
    
    NSDictionary *attrs = @{NSFontAttributeName : font};
    
    return [text boundingRectWithSize:maxSize options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrs context:nil].size;
    
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
