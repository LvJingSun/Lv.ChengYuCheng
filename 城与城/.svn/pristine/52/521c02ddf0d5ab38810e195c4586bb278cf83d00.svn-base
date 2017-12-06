//
//  MyquanquanViewController.h
//  HuiHui
//
//  Created by mac on 15-3-18.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//  我的券券-我收藏和使用的券券

#import "BaseViewController.h"

#import "PullTableView.h"

@interface MyquanquanViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,PullTableViewDelegate>{
    
    NSInteger  m_pageIndex;
    
    NSInteger  m_indexRow;
    
}


// 标记类型
@property (nonatomic, strong) NSString          *m_type;

// 存放数据的数组
@property (nonatomic, strong) NSMutableArray    *m_voucherList;

- (void)setUserd:(BOOL)aUsered withFavorite:(BOOL)aFavorite;

@end
