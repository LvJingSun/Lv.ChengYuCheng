//
//  HH_LoginPhoneViewController.h
//  HuiHui
//
//  Created by mac on 14-11-6.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//  登录时 绑定手机号的页面

#import "BaseViewController.h"
#import "ZBarSDK.h"

static SystemSoundID shake_sound_male_id = 0;

@interface HH_LoginPhoneViewController : BaseViewController<UIAlertViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,ZBarReaderDelegate>
{
    
    UIActivityIndicatorView* activity;
    UILabel     *activityLabel;
    BOOL ISscaning;//正在扫；
}

@property (nonatomic, unsafe_unretained) ZBarReaderViewController *mWidgetController;


// 判断发送验证码的时间
@property (strong, nonatomic) NSDate            *clickDateTime;

// 从相册选择二维码图片
@property (nonatomic, assign) BOOL                  isChooseScanImage;

@property (nonatomic, strong) UIImageView *readline;

@end
