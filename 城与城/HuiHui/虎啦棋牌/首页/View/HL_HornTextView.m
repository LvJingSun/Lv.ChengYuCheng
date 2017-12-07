//
//  HL_HornTextView.m
//  HuiHui
//
//  Created by mac on 2017/12/7.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "HL_HornTextView.h"
#import "HL_HornTextModel.h"

@interface HL_HornTextView ()

@property (nonatomic, weak) UILabel *contentLab;

@property (nonatomic, assign) int i;

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation HL_HornTextView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        UILabel *contentLab = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, frame.size.width - 10, frame.size.height)];
        
        contentLab.textColor = [UIColor darkTextColor];
        
        contentLab.font = [UIFont systemFontOfSize:13];
        
        self.contentLab = contentLab;
        
        [self addSubview:contentLab];
        
    }
    
    return self;
    
}

-(void)setModel:(HL_HornTextModel *)model {
    
    _model = model;
    
    self.contentLab.text = model.textStr;
    
}

-(void)setTextArray:(NSArray *)textArray {
    
    _textArray = textArray;
    
    self.i = 0;
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2. target:self selector:@selector(scrollTopView) userInfo:nil repeats:YES];
    
}

- (void)scrollTopView {
    
    if (self.textArray.count > 0) {
        
        self.i ++;
        
        if (self.i >= self.textArray.count) {
            
            self.i = 0;
            
        }
        
        self.model = self.textArray[self.i];
        
        CATransition *trasition = [CATransition animation];
        
        trasition.duration = 0.5f;
        
        trasition.type = @"cube";
        
        trasition.subtype = kCATransitionFromTop;
        
        [self.layer addAnimation:trasition forKey:nil];
        
    }
    
}

@end
