//
//  CommentViewController.h
//  HuiHui
//
//  Created by mac on 13-11-22.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//  评价页面

#import "BaseViewController.h"

#import "PullTableView.h"

@interface CommentViewController : BaseViewController<PullTableViewDelegate,UITableViewDataSource,UITableViewDelegate>{
    
    // 用于分页请求的参数
    NSInteger pageIndex;
    
}

@property (nonatomic, strong) NSMutableArray *m_commentArray;


@property (nonatomic, strong) NSMutableArray *m_starArray;

// 判断是商户的评价还是商品的评价 1表示商品评价  2表示商户评价
@property (nonatomic, strong) NSString    *m_typeString;

// 请求参数用的商品id
@property (nonatomic, strong) NSString       *m_serviceId;

// 请求商品评价的数据
- (void)requestCommentList;

// 请求商户评价的数据
- (void)requestMerchantComment;


@end
