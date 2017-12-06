//
//  RealAccountViewController.h
//  baozhifu
//
//  Created by mac on 13-7-22.
//  Copyright (c) 2013年 mac. All rights reserved.
//  实名认证页面

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface RealAccountViewController : BaseViewController<UIActionSheetDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate,UITextFieldDelegate>

@property (assign, nonatomic) NSInteger tagIndex;

@end
