//
//  MyCardViewController.h
//  HuiHui
//
//  Created by 冯海强 on 14-6-24.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import "BaseViewController.h"
#import "PullTableView.h"
#import "MyCarddetailViewController.h"

@interface MyCardViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,PullTableViewDelegate,CardetailDelegate,UIAlertViewDelegate>
{
    int         m_pageIndex;
    
    // 标记点击了第几行
    NSInteger   m_index;
}

@property (nonatomic,weak) IBOutlet PullTableView   *MC_tableview;

@property (nonatomic,weak) IBOutlet UIView          *MC_simpleview;

// 标志是否置顶的值
@property (nonatomic, strong) NSString              *m_isZD;

-(void)MycardViewcurrentBoolRefish;

@end
