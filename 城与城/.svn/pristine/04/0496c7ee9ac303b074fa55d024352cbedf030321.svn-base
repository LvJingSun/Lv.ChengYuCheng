//
//  ScanRegisterViewController.h
//  baozhifu
//
//  Created by mac on 13-11-28.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import "BaseViewController.h"

@interface ScanRegisterViewController : BaseViewController<UIActionSheetDelegate,UIAlertViewDelegate,TencentSessionDelegate>{
    
    
    TencentOAuth        *_tencentOAuth;
    
    NSMutableArray      *_permissions;
    
    NSString            *_Marth;
    NSString            *_Reqnum;
}


@property (strong, nonatomic) NSMutableDictionary *registInfo;

@property (strong, nonatomic) NSDate *clickDateTime;

// qq登录成功后执行的方法
- (void)qqLoginSuccess;


@end
