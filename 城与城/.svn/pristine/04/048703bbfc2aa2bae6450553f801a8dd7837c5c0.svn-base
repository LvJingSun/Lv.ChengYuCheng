//
//  SC_productViewController.h
//  HuiHui
//
//  Created by mac on 14-11-12.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//列表左右滑动页面

#import "BaseViewController.h"
#import "DBHelper.h"

#import "TableViewWithBlock.h"

#import "PullTableView.h"

#import "SearchRecordsHelper.h"

@class TableViewWithBlock;

@interface SC_productViewController : BaseViewController<UIGestureRecognizerDelegate,UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,PullTableViewDelegate,DPRequestDelegate>{
    
    DBHelper *dbhelp;
    
    
    int      m_index;
    
    
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
    
    NSInteger pageIndex;
    NSString *selectCity;
    
    
    
    // 记录商户请求的Index
    NSInteger  m_pageIndex;
    //大众点评
    NSInteger  DP_pageIndex;//点评页数
    
    
    SearchRecordsHelper  *searchHelper;
    
    // 判断是分类选择的判断还是查看详情
    BOOL      isSelected;
    
    // 用于记录tableView是上滑还是下滑
    CGFloat   oldOffset;
    
    BOOL ended;//结束过了
    
}

// 用于scrollerView滚动时是返回上一级还是第一个位置的判断
@property (nonatomic, assign) BOOL              isFirst;
// 存放分类按钮大小的数组
@property (nonatomic, strong) NSMutableArray    *m_CategoryArray;

// 存放tableView的数组
@property (nonatomic,retain) NSMutableArray     *contentItems;

@property (nonatomic,strong) IBOutlet TableViewWithBlock * MiddleTableview;//类别二级
@property (nonatomic,strong) IBOutlet TableViewWithBlock * LeftTableview2;//地区一级
@property (nonatomic,strong) IBOutlet TableViewWithBlock * MiddleTableview2;//地区二级
@property (nonatomic,strong) IBOutlet TableViewWithBlock * RightTableview;//排序
// 记录经纬度的值
@property (nonatomic, strong) NSString              *m_longtiString;

@property (nonatomic, strong) NSString              *m_latiString;

@property (nonatomic, strong) NSString              *m_order;

@property (nonatomic, strong) NSString              *m_sort;
// 记录是否是最后一页
@property (nonatomic,strong) NSString               *m_isLastPage;

@property(nonatomic,strong) NSMutableArray * LeftArray;
@property(nonatomic,strong) NSMutableArray * LeftArrayID;
@property(nonatomic,strong) NSMutableArray * MiddleArray;
@property(nonatomic,strong) NSMutableArray * MiddleArrayID;
@property(nonatomic,strong) NSMutableArray * LeftArray2;
@property(nonatomic,strong) NSMutableArray * LeftArrayID2;
@property(nonatomic,strong) NSMutableArray * MiddleArray2;
@property(nonatomic,strong) NSMutableArray * MiddleArrayID2;
@property(nonatomic,strong) NSMutableArray * RightArray;

@property (nonatomic, strong) NSString                      *TwoID;// classId

// 记录经纬度
@property (nonatomic, strong) NSString                      *m_string;

// 存放商品的数组
@property (nonatomic, strong) NSMutableArray                *m_productList;

// 存放多个数组的字典
@property (nonatomic, strong) NSMutableDictionary           *m_dic;

//大众点评
@property (nonatomic, strong) NSMutableArray                *DPdealsarray;//产品数组

//  测试
//@property (nonatomic, strong) NSMutableDictionary           *m_testDic;

// 存放未选中的类别的数组
@property (nonatomic, strong) NSMutableArray                *m_classList;

// 记录从首页过来选中的是第一几个类别
@property (nonatomic, assign) int                           m_categoryIndex;


@property (nonatomic) CGFloat upThresholdY; // up distance until fire. default 0 px.
@property (nonatomic) CGFloat downThresholdY; // down distance until fire. default 200 px.



//保证分类只有一个
+ (SC_productViewController *)shareobject;


@end
