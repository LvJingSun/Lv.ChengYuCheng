//
//  RH_GetMoneyAnimation.m
//  HuiHui
//
//  Created by mac on 2017/8/23.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "RH_GetMoneyAnimation.h"
#import "RedHorseHeader.h"
#import <AudioToolbox/AudioToolbox.h>

@interface RH_GetMoneyAnimation () {

    UIView *_contentView;
    
    CGFloat viewWidth;
    
    CGFloat viewHeight;
    
}

@property (nonatomic, weak) UIImageView *icon1;

@property (nonatomic, weak) UIImageView *icon2;

@property (nonatomic, weak) UIImageView *icon3;

@property (nonatomic, weak) UIImageView *icon4;

@property (nonatomic, weak) UIImageView *icon5;

@property (nonatomic, weak) UIImageView *icon6;

@property (nonatomic, weak) UIImageView *icon7;

@property (nonatomic, weak) UIImageView *icon8;

@property (nonatomic, weak) UIImageView *icon9;

@property (nonatomic, weak) UIImageView *icon10;

@end

@implementation RH_GetMoneyAnimation

static SystemSoundID soundID = 0;

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        
        self.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        
        self.backgroundColor = [UIColor clearColor];
        
        if (_contentView == nil) {
        
            _contentView = [[UIView alloc] init];
            
            viewWidth = ScreenWidth;
            
            viewHeight = ScreenHeight;
            
            _contentView.frame = CGRectMake(0, 0, viewWidth, viewHeight);
            
            _contentView.backgroundColor = [UIColor clearColor];
            
            CGFloat iconW = ScreenWidth * 0.05;
            
            UIImageView *img1 = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth * 0.025, 50, iconW, iconW)];
            
            self.icon1 = img1;
            
            img1.image = [UIImage imageNamed:@"rh_gold.png"];
            
            [_contentView addSubview:img1];
            
            UIImageView *img2 = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth * 0.125, 70, ScreenWidth * 0.05, ScreenWidth * 0.05)];
            
            self.icon2 = img2;
            
            img2.image = [UIImage imageNamed:@"rh_gold.png"];
            
            [_contentView addSubview:img2];
            
            UIImageView *img3 = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth * 0.225, 110, ScreenWidth * 0.05, ScreenWidth * 0.05)];
            
            self.icon3 = img3;
            
            img3.image = [UIImage imageNamed:@"rh_gold.png"];
            
            [_contentView addSubview:img3];
            
            UIImageView *img4 = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth * 0.325, 30, ScreenWidth * 0.05, ScreenWidth * 0.05)];
            
            self.icon4 = img4;
            
            img4.image = [UIImage imageNamed:@"rh_gold.png"];
            
            [_contentView addSubview:img4];
            
            UIImageView *img5 = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth * 0.425, 150, ScreenWidth * 0.05, ScreenWidth * 0.05)];
            
            self.icon5 = img5;
            
            img5.image = [UIImage imageNamed:@"rh_gold.png"];
            
            [_contentView addSubview:img5];
            
            UIImageView *img6 = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth * 0.525, 120, ScreenWidth * 0.05, ScreenWidth * 0.05)];
            
            self.icon6 = img6;
            
            img6.image = [UIImage imageNamed:@"rh_gold.png"];
            
            [_contentView addSubview:img6];
            
            UIImageView *img7 = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth * 0.625, 180, ScreenWidth * 0.05, ScreenWidth * 0.05)];
            
            self.icon7 = img7;
            
            img7.image = [UIImage imageNamed:@"rh_gold.png"];
            
            [_contentView addSubview:img7];
            
            UIImageView *img8 = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth * 0.725, 50, ScreenWidth * 0.05, ScreenWidth * 0.05)];
            
            self.icon8 = img8;
            
            img8.image = [UIImage imageNamed:@"rh_gold.png"];
            
            [_contentView addSubview:img8];
            
            UIImageView *img9 = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth * 0.825, 80, ScreenWidth * 0.05, ScreenWidth * 0.05)];
            
            self.icon9 = img9;
            
            img9.image = [UIImage imageNamed:@"rh_gold.png"];
            
            [_contentView addSubview:img9];
            
            UIImageView *img10 = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth * 0.925, 40, ScreenWidth * 0.05, ScreenWidth * 0.05)];
            
            self.icon10 = img10;
            
            img10.image = [UIImage imageNamed:@"rh_gold.png"];
            
            [_contentView addSubview:img10];
            
            [self addSubview:_contentView];
            
            NSString *str = [[NSBundle mainBundle] pathForResource:@"shake" ofType:@"mp3"];
            
            NSURL *url = [NSURL fileURLWithPath:str];
            
            AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(url), &soundID);
            
            //如果需要在播放完之后执行某些操作，可以调用如下方法注册一个播放完成回调函数
//            AudioServicesAddSystemSoundCompletion(soundID, NULL, NULL, soundCompleteCallback, NULL);
            //2.播放音频
            AudioServicesPlaySystemSound(soundID);//播放音效
            
        }
        
    }
    
    return self;
    
}

//void soundCompleteCallback(SystemSoundID soundID,void * clientData){
//    NSLog(@"播放完成...");
//}

//展示从底部向上弹出的UIView（包含遮罩）
- (void)showInView:(UIView *)view
{
    if (!view)
    {
        return;
    }
    
    [view addSubview:self];
    
    [view addSubview:_contentView];
    
    [_contentView setFrame:CGRectMake(0, 0, viewWidth, viewHeight)];
    
    [UIView animateWithDuration:2.0 animations:^{
        
        [_contentView setFrame:CGRectMake(0, ScreenHeight, viewWidth, viewHeight)];
        
    } completion:^(BOOL finished) {
        
        [self disMissView];
        
    }];
    
}

//移除从上向底部弹下去的UIView（包含遮罩）
- (void)disMissView
{

                         
     [self removeFromSuperview];
     
     [_contentView removeFromSuperview];

    
}

@end
