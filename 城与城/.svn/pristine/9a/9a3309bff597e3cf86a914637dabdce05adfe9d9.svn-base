//
//  AddCardLevelViewController.h
//  HuiHui
//
//  Created by mac on 15-7-28.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//  新增、编辑会员卡等级

#import "BaseViewController.h"

@interface AddCardLevelViewController : BaseViewController<UITextFieldDelegate,UITextViewDelegate,UIAlertViewDelegate>

@property (nonatomic, strong) NSString              *m_levelId;

// 类型-是新增还是编辑 Add添加,Modify编辑
@property (nonatomic, strong) NSString              *m_typeString;
// 存放传递过来的值
@property (nonatomic, strong) NSMutableDictionary   *m_dic;


// 新增会员卡等级请求数据
- (void)saveLevelRequest;
// 删除会员等级
- (void)deleteLevelRequest;


@end
