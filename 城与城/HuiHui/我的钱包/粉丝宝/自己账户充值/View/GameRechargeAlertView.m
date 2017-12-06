//
//  GameRechargeAlertView.m
//  HuiHui
//
//  Created by mac on 2017/10/27.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "GameRechargeAlertView.h"
#import "LJConst.h"
#import "RH_RadioView.h"

@interface GameRechargeAlertView () {
    
    UIView *_contentView;
    
    CGFloat viewWidth;
    
    CGFloat viewHeight;
    
    NSString *type;
    
}

@property (nonatomic, weak) RH_RadioView *leftbtn;

@property (nonatomic, weak) RH_RadioView *rightbtn;



@end

@implementation GameRechargeAlertView

- (instancetype)initWithTitle:(NSString *)titletext
                     withLeft:(NSString *)lefttext
                    withRight:(NSString *)righttext
              withFSB_Balance:(NSString *)fsb_balance
              withCAC_Balance:(NSString *)cac_balance
                    withCount:(NSString *)counttext
                     withSure:(NSString *)suretext {
    
    if (self = [super init]) {
        
        type = @"1";
        
        self.frame = CGRectMake(0, 0, _WindowViewWidth, _WindowViewHeight);
        
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
        
        if (_contentView == nil) {
            
            UIButton *disbtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, _WindowViewWidth, _WindowViewHeight)];
            
            [disbtn addTarget:self action:@selector(dismissFromView) forControlEvents:UIControlEventTouchUpInside];
            
            [self addSubview:disbtn];
            
            viewWidth = _WindowViewWidth * 0.8;
            
            viewHeight = 215;
            
            _contentView = [[UIView alloc] initWithFrame:CGRectMake((_WindowViewWidth - viewWidth) * 0.5, (_WindowViewHeight - viewHeight) * 0.5, viewWidth, viewHeight)];
            
            _contentView.layer.masksToBounds = YES;
            
            _contentView.layer.cornerRadius = 20;
            
            _contentView.backgroundColor = [UIColor whiteColor];
            
            CGFloat titleX = 0;
            
            CGFloat titleY = 20;
            
            CGFloat titleW = viewWidth;
            
            CGFloat titleH = 20;
            
            UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(titleX, titleY, titleW, titleH)];
            
            title.text = titletext;
            
            title.textAlignment = NSTextAlignmentCenter;
            
            title.textColor = FSB_StyleCOLOR;
            
            title.font = [UIFont systemFontOfSize:17];
            
            [_contentView addSubview:title];
            
            CGFloat chooseWidth = viewWidth - 50;

            CGFloat leftbtnX = 25;
            
            CGFloat leftbtnY = CGRectGetMaxY(title.frame) + 30;
            
            CGFloat leftbtnW = chooseWidth * 0.5;
            
            CGFloat leftbtnH = 20;

            RH_RadioView *leftbtn = [[RH_RadioView alloc] initWithFrame:CGRectMake(leftbtnX, leftbtnY, leftbtnW, leftbtnH)];
            
            self.leftbtn = leftbtn;
            
            leftbtn.title.text = lefttext;
            
            [leftbtn.btn setImage:[UIImage imageNamed:@"checkblueyes"] forState:0];
            
            [leftbtn.btn addTarget:self action:@selector(leftClick) forControlEvents:UIControlEventTouchUpInside];
            
            [_contentView addSubview:leftbtn];
            
            UILabel *fsb = [[UILabel alloc] initWithFrame:CGRectMake(leftbtnX, CGRectGetMaxY(leftbtn.frame), leftbtnW, 13)];
            
            fsb.textAlignment = NSTextAlignmentCenter;
            
            fsb.textColor = [UIColor redColor];
            
            fsb.font = [UIFont systemFontOfSize:13];
            
            fsb.text = [NSString stringWithFormat:@"(余额：%@)",fsb_balance];
            
            [_contentView addSubview:fsb];
            
            CGFloat rightbtnX = CGRectGetMaxX(leftbtn.frame);
            
            RH_RadioView *rightbtn = [[RH_RadioView alloc] initWithFrame:CGRectMake(rightbtnX, leftbtnY, leftbtnW, leftbtnH)];
            
            self.rightbtn = rightbtn;
            
            [rightbtn.btn setImage:[UIImage imageNamed:@"checkblueno"] forState:0];
            
            rightbtn.title.text = righttext;
            
            [rightbtn.btn addTarget:self action:@selector(rightClick) forControlEvents:UIControlEventTouchUpInside];
            
            [_contentView addSubview:rightbtn];
            
            UILabel *cac = [[UILabel alloc] initWithFrame:CGRectMake(rightbtnX, CGRectGetMaxY(rightbtn.frame), leftbtnW, 13)];
            
            cac.textAlignment = NSTextAlignmentCenter;
            
            cac.textColor = [UIColor redColor];
            
            cac.font = [UIFont systemFontOfSize:13];
            
            cac.text = [NSString stringWithFormat:@"(余额：%@)",cac_balance];
            
            [_contentView addSubview:cac];
            
            UILabel *count = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(fsb.frame) + 20, viewWidth, 30)];
            
            self.countLab = count;
            
            count.textAlignment = NSTextAlignmentCenter;
            
            count.textColor = FSB_StyleCOLOR;
            
            count.font = [UIFont systemFontOfSize:18];
            
//            count.text = [NSString stringWithFormat:@"需花费%@元",counttext];
            
            [_contentView addSubview:count];
            
            UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(count.frame) + 10, viewWidth, 2)];
            
            line.backgroundColor = FSB_LineCOLOR;
            
            [_contentView addSubview:line];
            
            UIButton *sure = [[UIButton alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(line.frame) + 5, viewWidth, 50)];
            
            [sure addTarget:self action:@selector(sureClick) forControlEvents:UIControlEventTouchUpInside];
            
            [sure setTitle:suretext forState:0];
            
            [sure setTitleColor:FSB_StyleCOLOR forState:0];
            
            [_contentView addSubview:sure];
            
            [self addSubview:_contentView];
            
        }
        
    }
    
    return self;
    
}

- (void)sureClick {
    
    if (self.sureBlock) {
        
        self.sureBlock();
        
    }
    
}

- (void)leftClick {
    
    if ([type isEqualToString:@"2"]) {
        
        type = @"1";
        
        [self.leftbtn.btn setImage:[UIImage imageNamed:@"checkblueyes"] forState:0];
        
        [self.rightbtn.btn setImage:[UIImage imageNamed:@"checkblueno"] forState:0];
        
    }
    
    if (self.leftBlock) {
        
        self.leftBlock();
        
    }
    
}

- (void)rightClick {
    
    if ([type isEqualToString:@"1"]) {
        
        type = @"2";
        
        [self.leftbtn.btn setImage:[UIImage imageNamed:@"checkblueno"] forState:0];
        
        [self.rightbtn.btn setImage:[UIImage imageNamed:@"checkblueyes"] forState:0];
        
    }
    
    if (self.rightBlock) {
        
        self.rightBlock();
        
    }
    
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
