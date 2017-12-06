//
//  HistoryserviceViewController.h
//  HuiHui
//
//  Created by 冯海强 on 15-1-27.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "BaseViewController.h"
#import "SubdescribeViewController.h"
#import "PullTableView.h"
@interface HistoryserviceViewController : BaseViewController<subHistoryDelegate,PullTableViewDelegate>

@property (nonatomic,strong) NSString *toMemberId;

@property (nonatomic,strong) NSString *IsChatting;
@property (nonatomic,strong) NSString *IsSender;

@end
