//
//  SceneryFilterViewController.h
//  HuiHui
//
//  Created by mac on 15-1-14.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//  景点门票筛选的页面

#import "BaseViewController.h"

@protocol SceneryDelegate <NSObject>

- (void)filterChoose:(NSMutableDictionary *)aDic;

@end

@interface SceneryFilterViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>{
    
    NSInteger sectionIndex;
    
}

// 存放数据的数组
@property (nonatomic, strong) NSMutableArray        *m_list;
// 判断是否是展开还是闭合的集合
@property (nonatomic, strong) NSMutableSet          *m_SectionsSet;
// 存放选择筛选条件的内容
@property (nonatomic, strong) NSMutableDictionary   *m_dic;

@property (nonatomic, assign) id<SceneryDelegate>   delegate;


// 存放景点级别的数组
@property (nonatomic, strong) NSMutableArray        *m_levelList;
// 存放景点价格的数组
@property (nonatomic, strong) NSMutableArray        *m_priceList;
// 存放行政区的数组
@property (nonatomic, strong) NSMutableArray        *m_countryList;


//保证空间只有一个
+ (SceneryFilterViewController*)shareobject;

@end
