//
//  Sharetofriend.h
//  HuiHui
//
//  Created by 冯海强 on 14-12-18.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import "EMChooseViewController.h"
#import "FriendHelper.h"
#import "ImageCache.h"
#import "CommonUtil.h"
#import "UIImageView+AFNetworking.h"
#import "GroupListViewController.h"


@interface Sharetofriend : UITableViewController<UITableViewDataSource,UITableViewDelegate>
{
    FriendHelper  *friendHelp;
    
    NSIndexPath *chosepath;
    
}
@property (strong,nonatomic) ImageCache *imageCache;
@property (strong, nonatomic) NSMutableDictionary *TextDIC;
@property (strong, nonatomic) NSString *m_FromDPId;

@property (strong, nonatomic) NSMutableArray *dataSource;

@property (strong, nonatomic) GroupListViewController *groupController;

// 请求数据用的商品id
@property (nonatomic, strong) NSString         *m_productId;
// 请求数据时得商户id
@property (nonatomic, strong) NSString         *m_merchantShopId;



@end
