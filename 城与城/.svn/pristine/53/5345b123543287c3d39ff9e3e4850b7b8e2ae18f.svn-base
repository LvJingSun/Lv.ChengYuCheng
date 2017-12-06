//
//  MyPartyViewController.h
//  baozhifu
//
//  Created by mac on 14-3-11.
//  Copyright (c) 2014年 mac. All rights reserved.
//  我发起的聚会列表

#import "BaseViewController.h"
#import "PullTableView.h"

@interface MyPartyViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate,PullTableViewDelegate>{
    
    NSInteger  pageIndex;
}

@property (nonatomic, strong) NSString          *m_statusType;

@property (nonatomic, strong) NSMutableArray   *m_partyList;
// 用于请求参数
@property (nonatomic, strong) NSString         *m_statusString;

// 记录选择是第几行
@property (nonatomic, assign) NSInteger         m_index;


- (void)setPlan:(BOOL)aPlan withAudit:(BOOL)aAudit withConduct:(BOOL)aConduct withEnd:(BOOL)aEnd;

// 请求网络数据
- (void)partyRequestSubmit;
// 删除请求网络
- (void)deleteRequestSubmit:(NSString *)aPartyId withOperation:(NSString *)aOperation;



@end
