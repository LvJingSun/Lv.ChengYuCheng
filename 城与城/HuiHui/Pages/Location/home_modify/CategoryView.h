//
//  CategoryView.h
//  HuiHui
//
//  Created by mac on 14-7-29.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CategoryDelegate <NSObject>

- (void)getCategoryClassId:(NSDictionary *)dic;

@end

@interface CategoryView : UIView

// 存放分类数据的数组
@property (nonatomic, strong) NSMutableArray  *m_catogoryList;

@property (nonatomic, strong) UILabel         *m_label;

@property (nonatomic, strong) UIView          *m_view;

// 记录点击的是某一行的code
@property (nonatomic, strong) NSString        *m_code;
// 设置代理
@property (nonatomic, assign) id<CategoryDelegate>delegate;


- (void)setArray:(NSMutableArray *)array withDic:(NSDictionary *)dic;

@end
