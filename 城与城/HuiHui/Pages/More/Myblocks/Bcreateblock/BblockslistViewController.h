//
//  BblockslistViewController.h
//  HuiHui
//
//  Created by 冯海强 on 15-3-30.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "BaseViewController.h"
#import "PullTableView.h"
#import "BcreateblockViewController.h"

@interface BblockslistViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,PullTableViewDelegate,Bcreateblockdelegate>
{
    IBOutlet  PullTableView *m_tableView;
    IBOutlet UILabel *m_emptyLabel;
    
}


@end
