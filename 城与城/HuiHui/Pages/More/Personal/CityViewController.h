//
//  CityViewController.h
//  HuiHui
//
//  Created by mac on 14-1-4.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import "BaseViewController.h"

@interface CityViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>


@property (nonatomic, strong) NSMutableArray  *m_cityList;

@end
