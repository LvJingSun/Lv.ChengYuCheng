//
//  AddBCMenuViewController.h
//  HuiHui
//
//  Created by 冯海强 on 15-5-21.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "BaseViewController.h"
#import "UITableView+DataSourceBlocks.h"
#import "TableViewWithBlock.h"
#import "HH_shopListViewController.h"
#import "HH_CustomMenuViewController.h"


@class TableViewWithBlock;
@protocol Bcreateblockdelegate <NSObject>

-(void)BcretablockOver;

@end

@interface AddBCMenuViewController : BaseViewController<UIActionSheetDelegate,HHShopListListDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UITableViewDataSource,UITableViewDelegate,HH_CustomDelegate>
{
    NSString *menunamestring;
    NSString *pricestring;
    NSString *shopnamestring;
    NSString *shopIDstring;
    
    NSString *dabaofeiString;
    NSString *description;
    
    
    // 可用份数和总份数
    NSString *usedCount;
    NSString *totalUsedCount;
    //使用频率几天几份
    NSString *PinlvDay;

}

@property (nonatomic,strong) IBOutlet UITableView * ABCMTableview;
@property(nonatomic,assign)id <Bcreateblockdelegate> Bcreatedelegate;

// 用于请求网络的参数
@property (nonatomic, strong) NSString              *m_menuClassId;

// 记录是编辑菜单还是新增菜单  1表示新增  2表示编辑
@property (nonatomic, strong) NSString              *m_type;

// 存放编辑菜单时的数据
@property (nonatomic, strong) NSMutableDictionary   *m_dic;
// 判断编辑菜单时是否更换了图片 0:文件不变；1:文件改变
@property (nonatomic, strong) NSString              *m_isChange;
// 存放按钮是否选中的状态
@property (nonatomic, strong) NSMutableDictionary   *m_selectDic;



// 记录选择的是支持还是不支持  1表示否定 0表示肯定
// 1.是否限购
@property (nonatomic, assign) int              m_buy;
// 2.支持会员卡活动
@property (nonatomic, assign) int              m_card;
// 3.是否对用户公开
@property (nonatomic, assign) int              m_opend;
// 4.是否限制频率
@property (nonatomic, assign) int              m_pinlv;
// 5.是否推荐到特价区
@property (nonatomic, assign) int              m_tejia;

@property (nonatomic, copy) NSString *isFuWu;

@property (nonatomic, copy) NSString *shijian;

@property (nonatomic, strong) NSArray *biliArray;




// 存放会员等级的数组
@property (nonatomic, strong) NSMutableArray         *m_starList;

// 记录高度的值
@property (nonatomic, assign) CGFloat                m_height;

// 存放选中的值的记录字典
@property (nonatomic, strong) NSMutableDictionary   *m_openedDic;


// 存放对部分用户公开的数组
@property (nonatomic, strong) NSMutableArray        *m_accountList;

// 存放支持会员卡活动时多个会员卡的价格的字典
@property (nonatomic, strong) NSMutableDictionary   *m_cardDic;
// 临时存放的字典，用于比较会员卡的值是否改变
@property (nonatomic, strong) NSMutableDictionary   *m_cardDic1;

// 存储自定义参数的字符
@property (nonatomic, strong) NSString              *m_customMenuName;






// 添加菜单的数据请求
- (void)requestMenuSubmit;

// 请求会员卡等级的接口
- (void)levelRequest;
\

@end
