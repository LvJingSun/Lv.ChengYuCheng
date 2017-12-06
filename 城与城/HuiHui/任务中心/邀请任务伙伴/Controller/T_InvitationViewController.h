//
//  T_InvitationViewController.h
//  HuiHui
//
//  Created by mac on 2017/3/23.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "T_TemplateViewController.h"
@class T_NewTask;

@interface T_InvitationViewController : T_TemplateViewController

@property (nonatomic, strong) T_NewTask *taskModel;

//再次邀请朋友需要的任务id
@property (nonatomic, copy) NSString *ReTaskID;

@end
