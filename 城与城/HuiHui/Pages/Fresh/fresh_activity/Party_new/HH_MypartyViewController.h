//
//  HH_MypartyViewController.h
//  HuiHui
//
//  Created by mac on 14-10-23.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//  关于我的活动-管理

#import "BaseViewController.h"



typedef enum {
    
    kOrganizeType = 0,
    kJoinedType = 1
    
} kPartyType;

@interface HH_MypartyViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>

// 记录是哪个类型
@property (nonatomic) kPartyType          m_typeString;




@end
