//
//  MyFavoriteViewController.h
//  HuiHui
//
//  Created by mac on 14-9-10.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import "BaseViewController.h"

#import "PullTableView.h"


// 编辑与默认两种状态
typedef enum FavoritesViewTypeEnum
{
    FavoritesReadOnly = 0,
    FavoritesEdit
    
}FavoritesViewType;


@interface MyFavoriteViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,PullTableViewDelegate,UIAlertViewDelegate>{
    
    FavoritesViewType           m_viewType;
    
    NSInteger                   m_pageIndex;
    
    NSInteger                   m_selectedIndex;
}

// 存放收藏的产品的数组
@property (nonatomic, strong) NSMutableArray   *m_favoriteList;
// 存放收藏的商户的数组
@property (nonatomic, strong) NSMutableArray   *m_merchantList;

// 标志是产品还是商户的类型字符
@property (nonatomic, strong) NSString          *m_typeString;

// 收藏的商品数据请求
- (void)favoriteSubmit;
// 商户收藏的数据请求数据
- (void)favoriteMerchantSubmit;
// 取消商品收藏
- (void)cancelFavorite:(NSString *)aServiceId;
// 取消商户收藏
- (void)cancelFavoriteMerchant:(NSString *)aShopId;


@end

