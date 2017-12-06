//
//  EMChatDaliBubbleView.m
//  HuiHui
//
//  Created by 冯海强 on 15-1-28.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "EMChatGameBubbleView.h"

#import "Reachability.h"
#import "AppHttpClient.h"
#import "SVProgressHUD.h"
#import "RedHorseHeader.h"
NSString *const kRouterEventGameBubbleTapEventName = @"kRouterEventGameBubbleTapEventName";

@implementation EMChatGameBubbleView


- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        UIView *bg = [[UIView alloc] init];
        
        self.bgView = bg;
        
        bg.backgroundColor = [UIColor whiteColor];
        
        bg.layer.masksToBounds = YES;
        
        bg.layer.cornerRadius = 8;
        
        [self addSubview:bg];

        UILabel *title = [[UILabel alloc] init];
        
        self.titleLab = title;
        
        title.textColor = [UIColor blackColor];
        
        title.font = [UIFont systemFontOfSize:16];
        
        [bg addSubview:title];
        
        UIImageView *icon = [[UIImageView alloc] init];
        
        self.iconImg = icon;
        
        icon.backgroundColor = [UIColor lightGrayColor];
        
        icon.layer.masksToBounds = YES;
        
        icon.layer.cornerRadius = 5;
        
        [bg addSubview:icon];
        
        GameResultLab *result = [[GameResultLab alloc] init];
        
        self.resultLab = result;
        
        result.textColor = [UIColor colorWithRed:159/255. green:159/255. blue:159/255. alpha:1.];
        
        result.font = [UIFont systemFontOfSize:14];
        
        result.numberOfLines = 0;
        
        [result setVerticalAlignment:VerticalAlignmentTop];
        
        [bg addSubview:result];

    }
    
    return self;
}

-(CGSize)sizeThatFits:(CGSize)size
{
    return CGSizeMake(ScreenWidth * 0.6, 100);
}

-(void)layoutSubviews {
    
    [super layoutSubviews];

}

#pragma mark - setter
- (void)setModel:(MessageModel *)model {
    
    [super setModel:model];
    
    [self setRect];
    
    [self setContent];

}

- (void)setRect {
    
    CGFloat bgX = 0;
    
    CGFloat bgY = 0;
    
    CGFloat bgW = ScreenWidth * 0.6;
    
    CGFloat titleX = 10;
    
    CGFloat titleY = 10;
    
    CGFloat titleW = bgW - 20;
    
    CGFloat titleH = 20;
    
    self.titleLab.frame = CGRectMake(titleX, titleY, titleW, titleH);
    
    CGFloat iconX = titleX;
    
    CGFloat iconY = titleX + titleH + 10;
    
    CGFloat iconW = 50;
    
    CGFloat iconH = iconW;
    
    CGFloat bgH = iconY + iconH + 10;
    
    self.bgView.frame = CGRectMake(bgX, bgY, bgW, bgH);
    
    self.iconImg.frame = CGRectMake(iconX, iconY, iconW, iconH);
    
    CGFloat labX = iconX + iconW + 5;
    
    CGFloat labY = iconY;
    
    CGFloat labW = bgW - labX - 20;
    
    CGFloat labH = iconH;
    
    self.resultLab.frame = CGRectMake(labX, labY, labW, labH);
    
}

- (void)setContent {
    
    MessageModel *model = self.model;
    
    [self.iconImg setImageWithURL:[NSURL URLWithString:model.PROphotoURl] placeholderImage:[UIImage imageNamed:@"RH_马.png"]];
    
    self.resultLab.text = model.PROtitle;
    
    self.titleLab.text = model.ACTtitle;
    
}


#pragma mark - public
-(void)bubbleViewPressed:(id)sender {
    
    [self routerEventWithName:kRouterEventGameBubbleTapEventName userInfo:@{KMESSAGEKEY:self.model}];
    
} 

+(CGFloat)heightForBubbleWithObject:(MessageModel *)object {
    
    return 105;
    
}

@end
