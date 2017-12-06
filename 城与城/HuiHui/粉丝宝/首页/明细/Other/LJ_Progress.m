//
//  LJ_Progress.m
//  HuiHui
//
//  Created by mac on 2017/5/16.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "LJ_Progress.h"
#import "LJConst.h"

@interface LJ_Progress ()

@property (nonatomic, retain) UIView *bgView;

@property (nonatomic, retain) UIView *progressView;

@property (nonatomic, assign) CGFloat currentProgress;

@end

@implementation LJ_Progress

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor clearColor];
        
       // _bgView = [[UIView alloc] init];
        
        //_bgView.backgroundColor = [UIColor blackColor];
        
       // [self addSubview:_bgView];
        
        _progressView = [[UIView alloc] init];
        
        _progressView.backgroundColor = FSB_DetailedProgressCOLOR;
        
        _progressView.layer.masksToBounds = YES;
        
        [self addSubview:_progressView];
        
    }
    
    return self;
    
}

- (void)setProgress:(CGFloat)progressValue {

    _currentProgress = progressValue;
    
    [self changeProgressView];
    
}

- (void)changeProgressView {
    
    //_bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];

    _progressView.frame = CGRectMake(0, 0, self.frame.size.width * _currentProgress, self.frame.size.height);
    
  //  _progressView.layer.cornerRadius = self.frame.size.height * 0.5;
    
}

@end
