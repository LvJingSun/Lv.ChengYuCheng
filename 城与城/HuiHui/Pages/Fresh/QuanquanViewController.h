//
//  QuanquanViewController.h
//  HuiHui
//
//  Created by mac on 15-2-11.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//  券券总动员

#import "BaseViewController.h"

#import "UITableView+DataSourceBlocks.h"

#import "TableViewWithBlock.h"

#import "LeftCell.h"

#import "MiddleCell.h"

#import "RightCell.h"

#import "PullTableView.h"

#import "DBHelper.h"

@interface QuanquanViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,PullTableViewDelegate>{

    BOOL fenleiOpened;
    BOOL areaOpened;

    BOOL areaOpened1;

    BOOL areaOpened2;

    BOOL priceOpened;

    BOOL rightOpened;
    
    NSInteger  m_pageIndex;
    
    
    DBHelper *dbhelp;

    NSString *cityId;
    NSString *areaId;
    NSString *districtId;
    
    NSString *NeedOpenTwo2;//是否需要打开第二三级；（地区）

}

// 存放数据的数组
@property (nonatomic, strong) NSMutableArray     *m_couponList;

@property (nonatomic, strong) NSMutableArray     *RightArray;

@property (nonatomic, strong) NSMutableArray     *m_fenleiList;

@property (nonatomic, strong) NSMutableArray     *m_areaList;

@property (nonatomic, strong) NSMutableArray     *m_area1List;

@property (nonatomic, strong) NSMutableArray     *m_area2List;

@property (nonatomic, strong) NSMutableArray     *m_priceList;


@property (weak, nonatomic) IBOutlet TableViewWithBlock *m_fenleiTableView;

@property (weak, nonatomic) IBOutlet TableViewWithBlock *m_areaTableView;

@property (weak, nonatomic) IBOutlet TableViewWithBlock *m_area1TableView;

@property (weak, nonatomic) IBOutlet TableViewWithBlock *m_area2TableView;

@property (weak, nonatomic) IBOutlet TableViewWithBlock *m_priceTableView;

@property (nonatomic,strong) IBOutlet TableViewWithBlock *m_distanceTableView;

@property (nonatomic, strong) NSString *m_feileiId;

@property (nonatomic, strong) NSString *m_priceId;

@property (nonatomic, strong) NSString *m_distanceId;



// 请求券券列表数据
- (void)quanquanRequestSubmit;
// 请求券券分类的数据
- (void)quanquanCategoryRequest;

@end
