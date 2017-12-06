//
//  TongchenghotelorderViewController.h
//  HuiHui
//
//  Created by 冯海强 on 15-3-19.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "BaseViewController.h"
#import "PullTableView.h"
#import "TongchenghoteldetailorderViewController.h"

@interface TongchenghotelorderViewController : BaseViewController<UITableViewDelegate, UITableViewDataSource, PullTableViewDelegate,TongchengDeletage>

{
    NSString * Ctrip_WAITPAY;//未支付
    NSString * Ctrip_OldIN;//已经入住过
    NSInteger pageIndex;

}

// 记录是哪个类型（待付款，已入住）
@property (nonatomic, strong) NSString          *m_typeString;
// 存放服务器返回的数据数组
@property (nonatomic, strong) NSMutableArray    *m_productList;

@end
