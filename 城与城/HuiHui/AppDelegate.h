//
//  AppDelegate.h
//  HuiHui
//
//  Created by mac on 13-11-19.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>

//#import "BMKMapManager.h"

#import <Security/Security.h>

#import "WXApi.h"

#import <AddressBook/AddressBook.h>

#import "DPAPI.h"

#import "RootViewController.h"

#import <TencentOpenAPI/TencentOAuth.h>

#import "ApplyViewController.h"


#define Appdelegate  ((AppDelegate*)[[UIApplication sharedApplication] delegate])

#define DEVICETOKEN @"dvicetoken"


@interface AppDelegate : UIResponder <UIApplicationDelegate,UINavigationControllerDelegate,WXApiDelegate,IChatManagerDelegate,DPRequestDelegate>{
    
    BMKMapManager               *_mapManager;  // 地图
    
    BOOL                        _hasRegister;
    
    EMConnectionState _connectionState;
    
}

@property (strong, nonatomic) RootViewController *mainController;

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UINavigationController *nav;

// 用于判断是否从购物车直接到本地的BOOL判断
@property (nonatomic, assign) BOOL   isSelectgoShopping;

// 判断是否修改了背景颜色
//@property (nonatomic, assign) BOOL   isSelectBackgroundColor;

@property (strong, nonatomic) NSMutableDictionary *emotionJsonsKeyIsCode;
@property (strong, nonatomic) NSMutableDictionary *emotionJsonsKeyIsText;

@property (nonatomic, assign) BOOL                  isModifyImage;

// 用于记录空间里是否修改了封面和用户名和头像等，根据值来进行重新请求数据
@property (nonatomic, assign) BOOL                  isChangeCover;

@property (nonatomic, assign) BOOL                  isChange;

// 用于判断来自于转发对方的内容再转发给对方
@property (nonatomic, assign) BOOL                  isForward;
// 用于判断转发的事文字还是图片
@property (nonatomic, strong) NSString              *isImageOrText;

// 记录本地通知的显示数字
@property (nonatomic, assign) NSInteger             m_badgeNumber;


@property (nonatomic) ABAddressBookRef              addressBook;

// 记录从通讯录好友进入邀请的页面
@property (nonatomic,assign) BOOL                   isTongxunlu;
// 记录别人加我的数据是否有变化
@property (nonatomic,assign) BOOL                   isMemberCountChange;

// 百度push用到的值
@property (strong, nonatomic) NSString *appId;
@property (strong, nonatomic) NSString *channelId;
@property (strong, nonatomic) NSString *userId;


// 群聊用到的

@property (strong, nonatomic) id                    HHcreateGroupResult;
@property (strong, nonatomic) NSString              *HHcreateRoomName;
@property (strong, nonatomic) NSMutableArray        *HHinitRoomUsers;
@property (strong, nonatomic) NSString              *HHcreateingGroupJid;
@property (strong, nonatomic) NSMutableArray        *gChatGroups;

// 群聊的所有人的信息
@property (strong, nonatomic) NSString              *AllMessageOfGroup;


@property (strong, nonatomic) NSString              *GroupMembers;


// 添加到数据库中时的值记录
@property (nonatomic,assign) BOOL                   isAddToBase;
// 用于判断是否是第一次进入app请求获得群列表消息
@property (nonatomic,assign) BOOL                   isFirstGroup;


// 存放聊天记录的数组
@property (strong, nonatomic) NSMutableArray        *m_groupList;

// 记录删除群聊的第几个内容
@property (nonatomic,assign) BOOL                   m_groupIndex;
// 记录根据userId删除数据库中对应的值
@property (nonatomic,strong) NSString               *m_groupUserId;

// 用于记录新建群时再次发送一条hello的消息
@property (nonatomic, assign) BOOL                  isHello;

// 记录push通知的类型
@property (nonatomic, strong) NSString              *m_messageType;

// 用于记录滚动分类里面只第一次进入的时候请求数据（保证那个类只有一个）
@property (nonatomic, assign)BOOL                   m_isCategory;
////===记录导航滑动截图的存放==
//@property (nonatomic, strong) NSMutableArray        *screenShotsList;


// 存放临时菜单自定义数据的字典
@property (nonatomic, strong) NSMutableDictionary   *m_customRulesDic;
// 存放菜单自定义参数名称的字典
@property (nonatomic, strong) NSMutableDictionary   *m_customNameDic;



// 版本检测的请求
- (void)versionRequest;

// 判断网络不好
- (BOOL)isConnectionAvailable;


//大众点评
@property (readonly, nonatomic) DPAPI *dpapi;
@property (strong, nonatomic) NSString *appKey;
@property (strong, nonatomic) NSString *appSecret;

+ (AppDelegate *)instance;

@property (strong, nonatomic) NSString *IsUpdate;//是否强制更新：IsUpdate 0：否；1：是


@end
