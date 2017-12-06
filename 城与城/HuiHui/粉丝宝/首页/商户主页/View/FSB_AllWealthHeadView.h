//
//  FSB_AllWealthHeadView.h
//  HuiHui
//
//  Created by mac on 2017/5/18.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FSB_ALLWealthFrame;

@protocol FSB_AllWealthHeadViewDelegate <NSObject>

//昨日收益点击
- (void)YesterdayProfitButtonClicked;

//总额度点击
- (void)AllQuotaButtonClicked;

//累计收益点击
- (void)CumulativeProfitButtonClicked;

//累计消费点击
- (void)CumulativeConsumptionButtonClicked;

@end

@interface FSB_AllWealthHeadView : UIView

@property (nonatomic, weak) UILabel *YesterdayProfitLabel;

@property (nonatomic, weak) UILabel *AllQuotaLabel;

@property (nonatomic, weak) UILabel *CumulativeProfitLabel;

@property (nonatomic, weak) UILabel *CumulativeConsumptionLabel;

@property (nonatomic, strong) id<FSB_AllWealthHeadViewDelegate> delegate;

@property (nonatomic, assign) CGFloat height;

@end
