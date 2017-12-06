//
//  HH_MactMenuViewController.h
//  HuiHui
//
//  Created by mac on 15-7-2.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//  首页点单进入的商户列表页面

#import "BaseViewController.h"

#import "GrayPageControl.h"

//#import "BMKMapView.h"

//#import "BMapKit.h"

#import "PullTableView.h"

#import "ImageCache.h"

#import "DBHelper.h"

#import "UITableView+DataSourceBlocks.h"

#import "TableViewWithBlock.h"

#import "LeftCell.h"

#import "MiddleCell.h"

#import "RightCell.h"

#import "BusinessCell.h"


@class TableViewWithBlock;

@interface HH_MactMenuViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,UISearchBarDelegate,CLLocationManagerDelegate,BMKLocationServiceDelegate,BMKMapViewDelegate,BMKGeoCodeSearchDelegate,PullTableViewDelegate,MapDelegate>{
    
    NSInteger pageIndex;
    NSString *selectCity;
    
    ImageCache *imageCache;
    // 记录商户请求的Index
    NSInteger  m_pageIndex;
    
    DBHelper *dbhelp;
    
    //商户
    BOOL B_leftOpened;//类别
    BOOL B_middleOpened;//类别
    BOOL B_leftOpened2;//区域
    BOOL B_middleOpened2;//区域
    BOOL B_rightOpened;
    
    NSString *B_OneID;//一级类别ID；类别一级
    NSString *B_TwoID;//二级类别ID；类别二级
    NSString *B_OneID2;//一级类别ID2；区域//地区的ID
    NSString *B_TwoID2;//二级类别ID2；区域//商圈的ID
    NSString *B_PaixuID;//排序ID
    
    NSString *B_NeedOpenTwo;//是否需要打开第二级；(分类)
    NSString *B_NeedOpenTwo2;//是否需要打开第二级；（地区）
    
}

@property (nonatomic, strong) NSMutableArray        *m_array;

// 记录经纬度的值
@property (nonatomic, strong) NSString              *m_longtiString;

@property (nonatomic, strong) NSString              *m_latiString;
// 商户记录经纬度的值
@property (nonatomic, strong) NSString              *B_m_longtiString;

@property (nonatomic, strong) NSString              *B_m_latiString;

@property (strong, nonatomic) NSMutableArray        *keyItems;

// 记录是否是最后一页
@property (nonatomic,strong) NSString               *m_isLastPage;
//商户
@property (nonatomic,strong) IBOutlet TableViewWithBlock * B_LeftTableview;//类别一级
@property (nonatomic,strong) IBOutlet TableViewWithBlock * B_MiddleTableview;//类别二级
@property (nonatomic,strong) IBOutlet TableViewWithBlock * B_LeftTableview2;//地区一级
@property (nonatomic,strong) IBOutlet TableViewWithBlock * B_MiddleTableview2;//地区二级
@property (nonatomic,strong) IBOutlet TableViewWithBlock * B_RightTableview;//排序

@property(nonatomic,strong) NSMutableArray * B_LeftArray;
@property(nonatomic,strong) NSMutableArray * B_LeftArrayID;
@property(nonatomic,strong) NSMutableArray * B_LeftArray2;
@property(nonatomic,strong) NSMutableArray * B_LeftArrayID2;
@property(nonatomic,strong) NSMutableArray * B_MiddleArray;
@property(nonatomic,strong) NSMutableArray * B_MiddleArrayID;
@property(nonatomic,strong) NSMutableArray * B_MiddleArray2;
@property(nonatomic,strong) NSMutableArray * B_MiddleArrayID2;
@property(nonatomic,strong) NSMutableArray * B_RightArray;


// 修改商品列表的展示形式
@property (nonatomic, strong) NSMutableDictionary *m_keyDic;
// 存放数据
@property (nonatomic, strong) NSMutableArray      *m_list;
// 判断筛选的条件是否是离我最近，如果是理我最近的，则显示分区的形式，如果不是则显示列表的形式
@property (nonatomic, assign) BOOL                isNearestForMe;

// 记录经纬度
@property (nonatomic, strong) NSString            *m_string;




@end

