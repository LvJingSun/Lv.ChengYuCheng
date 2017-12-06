//
//  HH_MenuDetailViewController.h
//  HuiHui
//
//  Created by mac on 15-7-16.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//  菜单详情

#import "BaseViewController.h"

@protocol MenuDetailDelegate <NSObject>

//- (void)menuDetailgetIndex:(NSDictionary *)aDic;

- (void)menuDetailgetIndex:(UIButton *)button;

//- (void)minuMenuClicked:(NSDictionary *)aDic;

- (void)minuMenuClicked:(UIButton *)button;


@end

@interface HH_MenuDetailViewController : BaseViewController<UIScrollViewDelegate>


@property (nonatomic, assign) id<MenuDetailDelegate>delegate;

@property (nonatomic, strong) NSMutableArray        *m_menuList;

// 记录选择的是第几个
@property (nonatomic, assign) NSInteger             m_index;
// 记录值的字典
@property (nonatomic, strong)  NSMutableDictionary  *m_dic;

// 临时存放选择的个数的数组
@property (nonatomic, strong) NSMutableArray        *m_countList;
// 记录是送货上门还是预约的 （1，外卖、2，预定）
@property (nonatomic, strong) NSString              *m_type;

@end
