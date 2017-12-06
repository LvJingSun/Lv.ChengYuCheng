//
//  SceneryListViewController.h
//  HuiHui
//
//  Created by mac on 15-1-13.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//  景点列表页面

#import "BaseViewController.h"

#import "PullTableView.h"

#import "SceneryFilterViewController.h"


typedef enum
{
    SceneryGoodType = 0,
    SceneryLevelType = 1,
    SceneryMorenType = 2,
    ScenerySaleType = 3,
    SceneryJuliType
    
} SceneryType;

@interface SceneryListViewController : BaseViewController<PullTableViewDelegate,UITableViewDataSource,UITableViewDelegate,SceneryDelegate,UITextFieldDelegate>{
    
    int  m_pageIndex;
    
}

// 存放数据的数组
@property (nonatomic, strong) NSMutableArray    *m_sceneryList;

// 搜索类型
@property (nonatomic, assign) SceneryType       m_type;
// 记录显示图片的url字符
@property (nonatomic, strong) NSString          *m_imageUrl;

// 存放搜索的值
@property (nonatomic, strong) NSString          *m_keyWord;

// 记录景区级别的字符-用于请求数据
@property (nonatomic, strong) NSString          *m_levelString;
// 记录景区价格的字符-用于请求数据
@property (nonatomic, strong) NSString          *m_priceString;
// 记录行政区的id的字符-用于请求数据
@property (nonatomic, strong) NSString          *m_countryId;

// 用于请求数据的城市id
@property (nonatomic, strong) NSString          *m_cityId;
// 判断是由前面一个附近进入还是其他的搜索
@property (nonatomic, strong) NSString          *m_stringType;



- (void)setmore:(BOOL)aMoren withSale:(BOOL)aSale withGood:(BOOL)aGood withNear:(BOOL)aNear;

@end
