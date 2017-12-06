//
//  SceneryStarView.m
//  HuiHui
//
//  Created by mac on 15-1-16.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "SceneryStarView.h"

@interface SceneryStarView ()



@end

@implementation SceneryStarView

- (id)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame numberOfStar:5];
}

- (id)initWithFrame:(CGRect)frame numberOfStar:(int)number
{
    self = [super initWithFrame:frame];
    if (self) {
        _numberOfStar = number;
        
        self.starBackgroundView = [self buidlStarViewWithImageName:@"star2.png"];
        self.starForegroundView = [self buidlStarViewWithImageName:@"star1.png"];
      
        [self addSubview:self.starBackgroundView];
        [self addSubview:self.starForegroundView];
    }
    return self;
}

- (UIView *)buidlStarViewWithImageName:(NSString *)imageName
{
    CGRect frame = self.bounds;
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.clipsToBounds = YES;
    for (int i = 0; i < self.numberOfStar; i ++)
    {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
        imageView.frame = CGRectMake(i * frame.size.width / self.numberOfStar, 0, frame.size.width / self.numberOfStar, frame.size.height);
        [view addSubview:imageView];
    }
    return view;
}

- (void)changeViewFrame:(float)aValue{
    // 计算评分所占的比例-从而计算宽度
    float wide = 0.00f;
    wide = aValue / 10 * self.frame.size.width;
    
    self.starForegroundView.frame = CGRectMake(0, 0, wide , self.frame.size.height);
    
}

@end
