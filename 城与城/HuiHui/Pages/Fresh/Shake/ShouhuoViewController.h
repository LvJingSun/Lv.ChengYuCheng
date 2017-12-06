//
//  ShouhuoViewController.h
//  HuiHuiApp
//
//  Created by mac on 13-10-16.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//  我的收获控制器

#import "BaseViewController.h"

@interface ShouhuoViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>
 
@property (weak, nonatomic) IBOutlet UITableView *m_tableView;

// 图标
@property (nonatomic, strong) UIImageView *m_iconImg;
// 用于判断选择的是升序还是降序
@property (nonatomic, strong) NSString    *m_selectString;


@end
