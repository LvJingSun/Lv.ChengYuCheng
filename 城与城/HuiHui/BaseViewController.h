//
//  BaseViewController.h
//  HuiHui
//
//  Created by mac on 13-10-8.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Configuration.h"

#import <QuartzCore/QuartzCore.h>

#import "AppHttpClient.h"

#import "AppDelegate.h"

#import <TencentOpenAPI/TencentOAuth.h>

#import <TencentOpenAPI/QQApiInterface.h>

//#import "BMapKit.h"

#import "CommonUtil.h"

#import "payRequsestHandler.h"



// QQ分享的AppId
#define TencentQzoneAppId @"101026359"


#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)



#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size)) : NO)


#define iPhone6plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(1125, 2001), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size)) : NO)



#define isIOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0 ? YES : NO)

#define isIOS5 ([[[UIDevice currentDevice] systemVersion] floatValue] < 6.0 ? YES : NO)


#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]  

#define HANZI_START 19968
#define HANZI_COUNT 20902

//#define WindowSize [[UIScreen mainScreen] bounds]

@interface BaseViewController : UIViewController<UITextFieldDelegate,UIGestureRecognizerDelegate> {
    
    BOOL keyboardShow;
    
    CGFloat                 startBackViewX;

}


@property(strong, nonatomic) UIButton               *doneInKeyboardButton;
@property(assign, nonatomic) BOOL                   needHiddenDone;

@property(weak, nonatomic) IBOutlet UIScrollView    *rootScrollView;

@property(weak, nonatomic) UITextField              *activeField;

@property(weak, nonatomic) UILabel              *HHBase_emptyLabel;

// 动画的三个数组
@property (nonatomic, strong) NSArray               *m_values;

@property (nonatomic, strong) NSArray               *m_keyTimes;

@property (nonatomic, strong) NSArray               *m_Funtions;

// 默认为特效开启
@property (nonatomic, assign) BOOL canDragBack;

- (IBAction)showNumPadDone:(id)sender;

- (IBAction)hiddenNumPadDone:(id)sender;

- (void)setUpForDismissKeyboard;

// 返回上一级
- (void)goBack;

// 设置view的大小-tabBar隐藏的情况下
- (void) hideTabBar:(BOOL) hidden;

// 设置自定义显示的提示框
- (void)alertWithMessage:(NSString *)message;

- (UIAlertView *)alertWithMessage:(NSString *)message tag:(NSUInteger)tag delegate:(id)delegate;

- (UIAlertView *)alertWithTitle:(NSString *)Title Message:(NSString *)message cancelBtn:(NSString*)cancelBtn otherBtn:(NSString*)otherBtn tag:(NSUInteger)tag delegate:(id)delegate;

- (void)setTitle:(NSString *)title;

- (void)setNavigationTitleViewTitleText:(NSString *)titleText titleColor:(UIColor *)titleColor;

-(UILabel*)getNavigationTitleViewTitleText:(NSString *)titleText titleColor:(UIColor *)titleColor;
// 设置导航栏左按钮图片
- (void)setLeftButtonWithNormalImage:(NSString *)aImageName action:(SEL)action;
// 设置导航栏右按钮图片
- (void)setRightButtonWithNormalImage:(NSString *)aImageName action:(SEL)action;
// 设置导航栏右按钮触发的事件
- (void)setRightButtonWithNormalImage:(NSString *)aImageName withTitle:(NSString *)aTitle action:(SEL)action;
// 设置导航栏左按钮触发的事件
- (void)setLeftButtonWithNormalImage:(NSString *)aImageName withTitle:(NSString *)aTitle action:(SEL)action;

- (void)setRightButtonWithTitle:(NSString *)aTitle action:(SEL)action;
- (void)setLeftButtonWithTitle:(NSString *)aTitle action:(SEL)action;
- (UIBarButtonItem *)SetNavigationBarRightImage:(NSString *)aImageName andaction:(SEL)Saction;

// 用于设置webView的上拉下拉的背景-设置为白色的
- (void) hideGradientBackground:(UIView*)theView;

// 判断网络不好
- (BOOL)isConnectionAvailable;

// 判断手机号码是否正确的格式
- (BOOL)isMobileNumber:(NSString *)mobileNum;

// 判断邮箱的正确性
- (BOOL)isValidateEmail:(NSString *)email;
// 日期转换成字符的格式
- (NSDate *)dateFromString:(NSString *)dateStr;
// 字符转换成日期的格式
- (NSString *)stringFromDate:(NSDate *)date;
// 根据字符计算出字符的长度
- (float)textLength:(NSString *)text;
- (BOOL)isHaveChineseCharacters:(NSString *)_text;
- (BOOL)isChineseCharacters_utf8:(NSInteger)characterAtIndex;


// 用于“我的”里面红点的计算，tabBar上面的值为字典里多个值的求和来判断，如果请求下来的值和数据库里的值之和相等的话，则表示不显示红点，如果不相等的话则显示红点
- (int)sumOfSixValueWithDic:(NSDictionary *)aDic;

// 根据当前的日期获得日历上的当前日期-并根据日历上的数字返回星期几的方法
- (NSString *)getCurrentDate;
//通过数字返回星期几
- (NSString *)getWeekStringFromInteger:(int)week;
// 获取一年中总共有多少天
- (int)getNumberOfDaysOneYear;
// 获取当月有多少天
- (int)getNumberOfDaysCurrentMonth;

// 根据日期获得是星期几
- (NSString *)getDate:(NSString *)aDate;

// 根据日期获取星期几
- (NSString *)getWeekday:(NSDate*)date;

// 将NSDate日期转换成字符
- (NSString *)stringWithDateFromScenery:(NSDate *)aDate;

// 将字符转换成NSDate日期
- (NSDate *)dateWithstringFromScenery:(NSString *)aString;
//- (NSAttributedString *)attributedString:(NSArray *__autoreleasing *)outURLs
//                               URLRanges:(NSArray *__autoreleasing *)outURLRanges
//                           nicknamearray:(NSMutableArray *)array;

// qq登录
//- (void)qqLogin;
//// qq登录成功后执行的方法
//- (void)qqloginSuccess:(APIResponse *)response;

//隐藏多余分栏线
- (void)setExtraCellLineHidden: (UITableView *)tableView;

- (NSString *)getLocalImagePath;
- (void)saveImage:(UIImage *)image;

//在iOS5 .1上防止文件被备份
//Documents 目录：您应该将所有de应用程序数据文件写入到这个目录下。这个目录用于存储用户数据或其它应该定期备份的信息。NSDocumentDirectory
//Caches 目录：用于存放应用程序专用的支持文件，保存应用程序再次启动过程中需要的信息。NSCachesDirectory

@end
