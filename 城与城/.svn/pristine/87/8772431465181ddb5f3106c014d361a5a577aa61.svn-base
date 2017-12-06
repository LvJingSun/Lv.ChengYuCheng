//
//  ApplicationPayViewController.h
//  HuiHui
//
//  Created by mac on 15-5-25.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//  申请二维码微信支付

#import "BaseViewController.h"

#import "UITableView+DataSourceBlocks.h"

#import "TableViewWithBlock.h"


@class TableViewWithBlock;


@interface ApplicationPayViewController : BaseViewController{
    
    BOOL rightOpened;

    
}


@property (weak, nonatomic) IBOutlet TableViewWithBlock *m_tableView;

// 存放数组
@property (nonatomic, strong) NSMutableArray        *m_array;
// 记录选择的是哪种代理类型
@property (nonatomic, strong) NSString              *m_type;

// 存放价钱的字符
@property (nonatomic, strong) NSString              *m_price;

// 请求接口获得订单id
- (void)orderNoRequest;


@end
