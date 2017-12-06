//
//  HH_TakeOrderViewController.h
//  HuiHui
//
//  Created by mac on 15-6-18.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//  点菜页面

#import "BaseViewController.h"
#import "UITableView+DataSourceBlocks.h"
#import "TableViewWithBlock.h"
#import "HH_MenuTimeViewController.h"
#import "HH_MenuDetailViewController.h"
#import "HH_menuToHomeViewController.h"
#import "HH_customRuleViewController.h"

@class TableViewWithBlock;

@interface HH_TakeOrderViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate,MenuDetailDelegate,HH_toHomeDelegate,MenuCustomRulesDelegate,UITextFieldDelegate>{
    
    BOOL        selectedStepNext;
    
    NSInteger   isSelectedPeople;
    
    NSInteger   SelectedTime;
    
    // 记录销量和价格的点击值
    BOOL        isSale;
    BOOL        isPrice;
    
    BOOL        isChangeSacle;
    BOOL        isChangePrice;
    
    
    NSInteger   m_index;
    
 
}

@property (nonatomic,strong) IBOutlet TableViewWithBlock    *BCMLeftTableview;
@property (nonatomic,strong) IBOutlet TableViewWithBlock    *BCMRightTableview;
@property (weak, nonatomic) IBOutlet UITableView            *m_linelabel;

@property (nonatomic,retain) NSMutableDictionary            *m_flagDic;

// 记录选择了几个菜单品种用于左边tableView的数字记录
@property (nonatomic,strong) NSMutableDictionary            *m_countDic;

// 存放店铺的数组
@property (nonatomic, strong) NSMutableArray                *m_shopList;

@property (nonatomic, strong) HH_MenuTimeViewController     *m_menuTimeController;
// 存放菜单的数组
@property (nonatomic, strong) NSMutableArray                *m_menuList;
// 存放请求数据的shopId
@property (nonatomic, strong) NSString                      *m_shopId;
// 存放总价的数据
@property (nonatomic, assign) float                         m_totalPrice;
// 存放菜单拼接起来的json字符
@property (nonatomic, strong) NSString                      *m_menuId;
// 存放是属于点菜模式还是美容模式的字符  如果等于1则表示是点菜模式进入点菜模式 否则进入美容模式
@property (nonatomic, strong) NSString                      *m_seat;
//C模式：如果ModelType==2则是外卖模式，否则按原来seat判断；
@property (nonatomic, strong) NSString                      *m_ModelType;

// 存放下单成功的orderId
@property (nonatomic, strong) NSString                      *m_orderId;

@property (nonatomic, strong) HH_MenuDetailViewController   *m_menuDetailView;

// 判断是预约的还是送货上门的类型 （1，外卖、2，预定）
@property (nonatomic, strong) NSString                      *m_typeString;

// 用于送货上门时请求数据传递的merchantiID
@property (nonatomic, strong) NSString                      *m_merchantId;

// 存放自定义数据的数组
//@property (nonatomic, strong) NSMutableArray                *m_customList;

// 记录是否支持外卖的字符
@property (nonatomic, strong) NSString                      *IsZCWaiMai;
@property (nonatomic, strong) UITextField                   *m_textField;
 

// 选择菜单后进行下单的数据请求
- (void)orderMenuRequest;

- (void)setDefault:(BOOL)aDefault withSale:(BOOL)aSale withPrice:(BOOL)aPrice;

@property (nonatomic,strong) NSMutableDictionary *XBParamdic;

@end
