//
//  Ctrip_chosehotelViewController.h
//  HuiHui
//
//  Created by 冯海强 on 14-9-22.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import "BaseViewController.h"

#import "TableViewWithBlock.h"


@class TableViewWithBlock;

@interface Ctrip_chosehotelViewController : BaseViewController


@property (nonatomic,strong) IBOutlet TableViewWithBlock * Ctrip_LeftTableview;//类别一级
@property (nonatomic,strong) IBOutlet TableViewWithBlock * Ctrip_RightTableview;//类别二级

@end
