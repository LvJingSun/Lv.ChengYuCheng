//
//  WwebpreviewViewController.h
//  HuiHui
//
//  Created by 冯海强 on 14-7-3.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import "BaseViewController.h"

@interface WwebpreviewViewController : BaseViewController<QQApiInterfaceDelegate,TencentSessionDelegate>

{
    TencentOAuth                *tencentOAuth;

}

@property (nonatomic,strong)NSString * WXURL;
@property (nonatomic,strong)NSString * WXimagepath;

@property (weak, nonatomic) IBOutlet UIButton *HuiHui;

@end
