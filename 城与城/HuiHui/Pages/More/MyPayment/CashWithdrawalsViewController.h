//
//  CashWithdrawalsViewController.h
//  baozhifu
//
//  Created by mac on 13-11-5.
//  Copyright (c) 2013年 mac. All rights reserved.
//  提现记录的页面

#import "BaseViewController.h"

#import "PullTableView.h"


@interface CashWithdrawalsViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource,PullTableViewDelegate>{
    
     NSInteger pageIndex;
}

@property (strong, nonatomic) NSMutableArray *m_recordsArr;
// 可提现的金额
@property (strong, nonatomic) NSString   *m_IncomeString;


// 请求数据
- (void)loadData;

@end
