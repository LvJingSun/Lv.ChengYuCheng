//
//  BusinesserlistViewController.h
//  Receive
//
//  Created by 冯海强 on 13-12-26.
//  Copyright (c) 2013年 冯海强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PullTableView.h"
#import "BaseViewController.h"
#import "BprodetailViewController.h"

@interface BusinesserlistViewController : BaseViewController<UITableViewDelegate, UITableViewDataSource,PullTableViewDelegate,CopyDelegate,UIActionSheetDelegate>
{
    int page;  // 用于分页请求的参数
    
    NSString *status;//没有入驻商户时，入驻商户没有过签约时（发布产品）
    
    NSString *copy;//复制返回时，直接开发中；
    
    int index;

}

@property (weak, nonatomic) IBOutlet PullTableView *B_ListTable;


@property (strong, nonatomic) NSMutableArray *Businesserarray;//商户列表

@property (nonatomic,weak) NSString *PorB;//产品还是商户

@property (strong, nonatomic) NSString *itemType;//类型
@property (weak, nonatomic) IBOutlet UIView *m_PtopView;//产品分类
@property (weak, nonatomic) IBOutlet UIView *m_BtopView;//商户分类


@end
