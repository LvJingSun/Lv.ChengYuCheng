//
//  CityListViewController.h
//  HuiHui
//
//  Created by mac on 13-11-28.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//

#import "BaseViewController.h"

@protocol CityListDelegate <NSObject>


- (void)getCityName:(NSMutableDictionary *)aCityName;

@end

@interface CityListViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>

// 存储城市列表的数据
@property (nonatomic, strong) NSMutableArray *m_cityList;

@property (nonatomic, strong) NSMutableArray *m_cityListid;

@property (nonatomic, assign) id<CityListDelegate>delegate;
// 存放搜索的数据数组
@property (nonatomic, strong) NSMutableArray *m_searchArray;

@property (nonatomic, assign) BOOL m_isSearching;

@end
