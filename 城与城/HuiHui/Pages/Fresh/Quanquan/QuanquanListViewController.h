//
//  QuanquanListViewController.h
//  HuiHui
//
//  Created by mac on 15-3-18.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//  券券列表页面

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

#import "HH_cityListViewController.h"


@class TableViewWithBlock;

@interface QuanquanListViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,UISearchBarDelegate,PullTableViewDelegate,DPRequestDelegate,HHCityListDelegate,UIAlertViewDelegate>{
    
//    NSInteger pageIndex;
    NSString *selectCity;
    
    ImageCache *imageCache;
    
    // 记录商户请求的Index
    NSInteger  m_pageIndex;
    
    DBHelper *dbhelp;
    
    //产品
    BOOL leftOpened;//类别
    BOOL middleOpened;//类别
    BOOL leftOpened2;//区域
    BOOL middleOpened2;//区域
    BOOL rightOpened;
    
    NSString *OneID;//一级类别ID；类别一级
    //    NSString *TwoID;//二级类别ID；类别二级
    NSString *OneID2;//一级类别ID2；区域//地区的ID
    NSString *TwoID2;//二级类别ID2；区域//商圈的ID
    NSString *PaixuID;//排序ID
    
    NSString *NeedOpenTwo;//是否需要打开第二级；(分类)
    NSString *NeedOpenTwo2;//是否需要打开第二级；（地区）
    
    // 记录是第几行-用于添加收藏
    NSInteger   m_indexSection;
    
    // 记录是第几行-用于删除收藏
    NSInteger   m_indexRow;
    
    BOOL        isFirstRequest;
    
}

@property (nonatomic, strong) NSString          *TwoID;// classId

// 用于传值显示在分类的按钮上
@property (nonatomic, strong) NSString          *m_titleString;

@property (nonatomic, strong) NSMutableArray        *m_array;

// 记录经纬度的值
@property (nonatomic, strong) NSString              *m_longtiString;

@property (nonatomic, strong) NSString              *m_latiString;

@property (nonatomic, strong) NSMutableArray        *m_productList;

@property (strong, nonatomic) NSMutableArray        *keyItems;

@property (nonatomic, strong) NSString              *m_order;

@property (nonatomic, strong) NSString              *m_sort;
// 记录是否是最后一页
@property (nonatomic,strong) NSString               *m_isLastPage;
//产品
@property (nonatomic,strong) IBOutlet TableViewWithBlock * LeftTableview;//类别一级
@property (nonatomic,strong) IBOutlet TableViewWithBlock * MiddleTableview;//类别二级
@property (nonatomic,strong) IBOutlet TableViewWithBlock * LeftTableview2;//地区一级
@property (nonatomic,strong) IBOutlet TableViewWithBlock * MiddleTableview2;//地区二级
@property (nonatomic,strong) IBOutlet TableViewWithBlock * RightTableview;//排序

@property(nonatomic,strong) NSMutableArray * LeftArray;
@property(nonatomic,strong) NSMutableArray * LeftArrayID;
@property(nonatomic,strong) NSMutableArray * MiddleArray;
@property(nonatomic,strong) NSMutableArray * MiddleArrayID;
@property(nonatomic,strong) NSMutableArray * LeftArray2;
@property(nonatomic,strong) NSMutableArray * LeftArrayID2;
@property(nonatomic,strong) NSMutableArray * MiddleArray2;
@property(nonatomic,strong) NSMutableArray * MiddleArrayID2;
@property(nonatomic,strong) NSMutableArray * RightArray;
// 修改商品列表的展示形式
//@property (nonatomic, strong) NSMutableDictionary   *m_keyDic;
// 存放数据
@property (nonatomic, strong) NSMutableArray        *m_list;
// 判断筛选的条件是否是离我最近，如果是理我最近的，则显示分区的形式，如果不是则显示列表的形式
//@property (nonatomic, assign) BOOL                  isNearestForMe;
// 记录经纬度
@property (nonatomic, strong) NSString              *m_string;

@property (nonatomic, strong) NSMutableDictionary   *m_keyDic;


// 记录商户logo的图片的值
//@property (nonatomic, strong) NSString              *m_imageString;
// 临时存放商户的图片
@property (nonatomic, strong) UIImageView           *m_imgV;

// 存放其他优惠券数据的数组
@property (nonatomic, strong) NSMutableArray        *m_couponList;




@end
