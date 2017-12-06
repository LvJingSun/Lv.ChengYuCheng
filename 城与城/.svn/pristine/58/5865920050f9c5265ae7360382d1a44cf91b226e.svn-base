//
//  LoginViewController.h
//  HuiHui
//
//  Created by mac on 13-11-19.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//


#import "BaseViewController.h"

#import "UIImageView+AFNetworking.h"

#import "FriendHelper.h"
#import "ImageCache.h"


@interface LoginViewController : BaseViewController<UITextFieldDelegate,TencentSessionDelegate,UIAlertViewDelegate>{
    
    FriendHelper  *friendHelp;
    
    
    TencentOAuth        *_tencentOAuth;
    
    NSMutableArray      *_permissions;
    
    NSString            *_Marth;
    NSString            *_Reqnum;

}
@property (weak, nonatomic) ImageCache *imageCache;


// 判断从哪个页面进入登录  1 表示从tabBar上面的各个viewController; 2 表示从商品详情加入购物车时进入登录页面
@property (nonatomic, strong) NSString  *m_typeString;

@property (weak, nonatomic) IBOutlet UIImageView *Headimage;

@property (weak, nonatomic) IBOutlet UIView *ForgetView;

// 存放登录信息的字典
@property (nonatomic, strong) NSMutableDictionary *m_dic;


// qq登录成功后执行的方法
- (void)qqLoginSuccess;



- (IBAction)login:(id)sender;


// 获取RGB
- (void)loadPageRequest;
// 上传token于服务端
- (void)tokenRequest;

@end
