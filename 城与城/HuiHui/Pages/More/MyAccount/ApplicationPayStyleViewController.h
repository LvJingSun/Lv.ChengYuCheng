//
//  ApplicationPayStyleViewController.h
//  HuiHui
//
//  Created by mac on 15-5-27.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//  立即申请后选择付款的支付方式

#import "BaseViewController.h"

#import "UITableView+DataSourceBlocks.h"

#import "TableViewWithBlock.h"

@class TableViewWithBlock;

@interface ApplicationPayStyleViewController : BaseViewController{
    
    BOOL rightOpened;
    
    
}


@property (weak, nonatomic) IBOutlet TableViewWithBlock *m_tableView;

// 存放数组
@property (nonatomic, strong) NSMutableArray        *m_array;

// 记录是银联支付还是微信支付
@property (nonatomic, strong) NSString              *m_type;

@end
