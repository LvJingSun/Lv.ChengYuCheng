//
//  AreaViewController.h
//  HuiHui
//
//  Created by mac on 13-12-4.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//

#import "BaseViewController.h"

#import "AreaDB.h"

@protocol AreaListDelegate <NSObject>


- (void)getAreaName:(NSString *)aCityName;

@end

@interface AreaViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>{
    
     AreaDB *dbhelp;
}

// 存储城市列表的数据
@property (nonatomic, strong) NSMutableArray *m_cityList;

@property (nonatomic, assign) id<AreaListDelegate>delegate;
// 存放搜索的数据数组
@property (nonatomic, strong) NSMutableArray *m_searchArray;

@property (nonatomic, assign) BOOL m_isSearching;


// 请求地区数据
- (void)requestAreaSubmit;


@end
