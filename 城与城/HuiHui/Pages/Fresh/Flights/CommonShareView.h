//
//  CommonShareView.h
//  HuiHui
//
//  Created by mac on 15-5-14.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <TencentOpenAPI/QQApiInterface.h>

#import <TencentOpenAPI/TencentOAuth.h>

#import "BaseViewController.h"

@protocol CommonShareDelegate <NSObject>

- (void)getShare:(NSString *)aType;

@end

@interface CommonShareView : UIView<QQApiInterfaceDelegate,TencentSessionDelegate,UIAlertViewDelegate>{
    
    TencentOAuth                *tencentOAuth;
    
    NSMutableArray              *_downloadImages;
    NSString                    *_shareimageURL;

    
}

// 用于分享的网址字符
@property (nonatomic, strong) NSString      *m_shareString;
// 记录导航栏的标题的字符
@property (nonatomic, strong) NSString      *m_titleString;

@property (nonatomic, strong) NSString      *m_subTitle;

// 设置代理
@property (nonatomic, assign) id<CommonShareDelegate>delegate;

// 跳转时带来的分享的链接和标题
- (void)getSharingUrl:(NSString *)aUrl withTitle:(NSString *)aTitle withSubTitle:(NSString *)aSubTitle;

@end
