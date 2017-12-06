//
//  ProductListViewController.h
//  baozhifu
//
//  Created by mac on 13-12-17.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import "BaseViewController.h"

#import "PullTableView.h"

@interface ProductListViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,PullTableViewDelegate>{
    
    // 用于分页请求的参数
    NSInteger pageIndex;
    
}


// 存放商品的数组
@property (nonatomic, strong) NSMutableArray *m_productArray;


// 用于请求的merchantId
@property (nonatomic, strong) NSString *m_merchantId;

// 存储商户店铺的id用于商品详情请求参数
@property (nonatomic, strong) NSString *m_merchantShopId;

// 请求数据
- (void)requestMerchantList;


@end
