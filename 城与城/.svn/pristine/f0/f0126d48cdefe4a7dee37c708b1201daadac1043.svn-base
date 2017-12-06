//
//  HH_CustomMenuViewController.h
//  HuiHui
//
//  Created by mac on 15-7-14.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//  自定义菜单的页面

#import "BaseViewController.h"

//#import "UITableView+DataSourceBlocks.h"
//#import "TableViewWithBlock.h"
#import "HH_shopListViewController.h"
//@class TableViewWithBlock;

//@protocol Bcreateblockdelegate <NSObject>
//
//-(void)BcretablockOver;
//
//@end

@protocol HH_CustomDelegate <NSObject>

- (void)getCustomMenuName:(NSString *)aString;

@end


@interface HH_CustomMenuViewController : BaseViewController<UIActionSheetDelegate,HHShopListListDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UITextViewDelegate>
{
    NSString *menunamestring;
    NSString *pricestring;
    NSString *shopnamestring;
    NSString *shopIDstring;
    
    NSString *m_totalString;
    NSString *m_usedString;
    
    // 标记点击的是第几个
    int clickedIndex;
    
    // 标记删除的值
    int deleteIndex;
    
}

//@property (nonatomic,strong) IBOutlet TableViewWithBlock * ABCMTableview;
//@property(nonatomic,assign)id <Bcreateblockdelegate> Bcreatedelegate;

// 用于请求网络的参数
@property (nonatomic, strong) NSString              *m_menuClassId;

// 记录是编辑菜单还是新增菜单  1表示新增  2表示编辑
@property (nonatomic, strong) NSString              *m_type;

// 存放编辑菜单时的数据
@property (nonatomic, strong) NSMutableDictionary   *m_dic;
// 判断编辑菜单时是否更换了图片 0:文件不变；1:文件改变
@property (nonatomic, strong) NSString              *m_isChange;

// 判断是否是展开还是闭合的集合
@property (nonatomic, strong) NSMutableSet          *m_SectionsSet;

// 字典
//@property (nonatomic, strong) NSMutableDictionary   *m_addDic;

@property (nonatomic, strong) NSMutableArray        *m_menuList;

@property (nonatomic, assign) id<HH_CustomDelegate>delegate;


// 添加菜单的数据请求
- (void)requestMenuSubmit;

+ (HH_CustomMenuViewController *)shareobject;


@end
