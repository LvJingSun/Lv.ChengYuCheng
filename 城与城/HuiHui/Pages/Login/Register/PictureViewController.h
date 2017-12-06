//
//  PictureViewController.h
//  baozhifu
//
//  Created by mac on 13-11-1.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import "BaseViewController.h"

@interface PictureViewController : BaseViewController<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>


@property (strong, nonatomic) NSMutableDictionary *registInfo;
// 存放图片的字典
@property (strong, nonatomic) NSMutableDictionary *m_imagDic;

// 是否同意注册协议
@property (assign, nonatomic) BOOL                isChecked;

// 判断来自于哪个页面 1表示是普通的注册 2表示公众邀请吗注册
@property (nonatomic, strong) NSString  *m_typeSteing;
 
// 返回按钮触发的事件
- (IBAction)goback:(id)sender;
// 下一步按钮触发的事件
- (IBAction)nextStep:(id)sender;
// 点击按钮选择头像
- (IBAction)m_photoChoose:(id)sender;


@end
