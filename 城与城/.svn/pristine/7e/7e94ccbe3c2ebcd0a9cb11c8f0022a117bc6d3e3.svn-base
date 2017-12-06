//
//  SceneryStarView.h
//  HuiHui
//
//  Created by mac on 15-1-16.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//  自定义评分星星的view

#import <UIKit/UIKit.h>

@class SceneryStarView;

@protocol StarRatingViewDelegate <NSObject>

@optional

- (void)starRatingView:(SceneryStarView *)view score:(float)score;

@end

@interface SceneryStarView : UIView

- (id)initWithFrame:(CGRect)frame numberOfStar:(int)number;

@property (nonatomic, readonly) int numberOfStar;

@property (nonatomic, weak) id <StarRatingViewDelegate> delegate;

@property (nonatomic, strong) UIView *starBackgroundView;
@property (nonatomic, strong) UIView *starForegroundView;


- (void)changeViewFrame:(float)aValue;


@end
