//
//  CustomRuleView.h
//  HuiHui
//
//  Created by mac on 15-7-31.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CustomRuleDelegate <NSObject>

- (void)getCustomRule:(NSDictionary *)dic;

@end

@interface CustomRuleView : UIView

// 存放分类数据的数组
@property (nonatomic, strong) NSMutableArray  *m_catogoryList;

@property (nonatomic, strong) UILabel         *m_label;

@property (nonatomic, strong) UIView          *m_view;

// 记录点击的是某一行的code
@property (nonatomic, strong) NSString        *m_code;
// 设置代理
@property (nonatomic, assign) id<CustomRuleDelegate>delegate;



- (void)setArray:(NSMutableArray *)array withDic:(NSDictionary *)dic withIndex:(int)index;

@end
