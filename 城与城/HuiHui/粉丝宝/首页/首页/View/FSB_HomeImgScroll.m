//
//  FSB_HomeImgScroll.m
//  HuiHui
//
//  Created by mac on 2017/7/11.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "FSB_HomeImgScroll.h"
#import "LJConst.h"
#import "FFScrollView.h"

@interface FSB_HomeImgScroll ()<FFScrollViewDelegate> {
    
    UIView *_contentView;
    
    UIButton *dismissBtn;
    
    CGFloat viewWidth;
    
    CGFloat viewHeight;
    
    CGFloat alertCenterX;
    
}

// 轮播数组
//@property (nonatomic, strong) NSArray *sourceArray;

@end

@implementation FSB_HomeImgScroll

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        
        self.frame = CGRectMake(0, 0, _WindowViewWidth, _WindowViewHeight);
        
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.9];
        
        if (_contentView == nil) {
        
            _contentView = [[UIView alloc] init];
            
            viewWidth = _WindowViewWidth;
            
            viewHeight = _WindowViewWidth;
            
            _contentView.frame = CGRectMake(0, (_WindowViewHeight - viewHeight) * 0.5, viewWidth, viewHeight);
            
            _contentView.backgroundColor = [UIColor whiteColor];
            
            [self addSubview:_contentView];
            
        }
        
    }
    
    return self;
    
}

-(void)setSourceArray:(NSArray *)sourceArray {

    _sourceArray = sourceArray;
    
    [self setScrollView];
    
}

-(void)setCountDown:(int)countDown {

    _countDown = countDown;
    
    [NSTimer scheduledTimerWithTimeInterval:(float)countDown target:self selector:@selector(TimeDownToAppearClose) userInfo:nil repeats:NO];
    
}

//倒计时显示关闭按钮
- (void)TimeDownToAppearClose {

    UIButton *disbtn = [[UIButton alloc] initWithFrame:CGRectMake(_WindowViewWidth * 0.95 - 24, (_WindowViewHeight - viewHeight) * 0.5 - 34, 24, 24)];
    
    dismissBtn = disbtn;
    
    [disbtn setImage:[UIImage imageNamed:@"closea.png"] forState:0];
    
    [disbtn addTarget:self action:@selector(disMissView) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:disbtn];
    
}

- (void)setScrollView {

    FFScrollView *scroll = [[FFScrollView alloc]initPageViewWithFrame:CGRectMake(20, 20, _WindowViewWidth - 40, viewHeight - 40) views:self.sourceArray];
    
    scroll.pageViewDelegate = self;
    
    scroll.pageControl.pageIndicatorTintColor = [UIColor grayColor];
    
    scroll.pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:255/255. green:47/255. blue:46/255. alpha:1.];
    
    [_contentView addSubview:scroll];
    
}

- (void)scrollViewDidClickedAtPage:(NSInteger)pageNumber {

    if ([self.delegate respondsToSelector:@selector(HomeScrollDidSelected:)]) {
        
        [self.delegate HomeScrollDidSelected:pageNumber];
        
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
        
        [_contentView setFrame:CGRectMake(0, (_WindowViewHeight - viewHeight) * 0.5, viewWidth, viewHeight)];
        
    } completion:nil];
    
}

//移除从上向底部弹下去的UIView（包含遮罩）
- (void)disMissView
{
    [_contentView setFrame:CGRectMake(0, (_WindowViewHeight - viewHeight) * 0.5, viewWidth, viewHeight)];
    
    [UIView animateWithDuration:0.3f
                     animations:^{
                         
         self.alpha = 0.0;
         
         [_contentView setFrame:CGRectMake(0, _WindowViewHeight, viewWidth, viewHeight)];
                         
    } completion:^(BOOL finished){
                         
         [self removeFromSuperview];
         
         [_contentView removeFromSuperview];
        
    }];
    
    if (self.dismissBlock) {
        
        self.dismissBlock();
        
    }
    
}


@end
