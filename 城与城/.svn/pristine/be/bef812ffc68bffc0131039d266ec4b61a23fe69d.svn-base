//
//  HH_customRuleViewController.h
//  HuiHui
//
//  Created by mac on 15-7-31.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//  自定义参数的选择页面

#import "BaseViewController.h"

#import "CustomRuleView.h"

@protocol MenuCustomRulesDelegate <NSObject>

- (void)addMenugetIndex:(NSDictionary *)aDic withCountDic:(NSMutableDictionary *)countDic;

- (void)minuMenugetIndex:(NSDictionary *)aDic;

@end



@interface HH_customRuleViewController : BaseViewController<CustomRuleDelegate> 

// 存放自定义数据的数组
@property (nonatomic, strong) NSMutableArray    *m_customList;

// 存放菜单的名称的字符
@property (nonatomic, strong) NSString          *m_menuString;

// 记录选择的是第几个
@property (nonatomic, assign) NSInteger         m_index;

@property (nonatomic, strong) NSMutableDictionary    *m_countDic;
// 用于记录类别的个数的第几个
@property (nonatomic, assign) NSInteger         m_sectionIndex;

// 记录未选择的时候的值，默认为0，如果为0的时候添加值后所对应的值加1
@property (nonatomic, assign) int               m_amount;


@property (nonatomic, assign) id<MenuCustomRulesDelegate>delegate;

@end
