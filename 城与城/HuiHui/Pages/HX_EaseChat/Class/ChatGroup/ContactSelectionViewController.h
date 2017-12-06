/************************************************************
  *  * EaseMob CONFIDENTIAL 
  * __________________ 
  * Copyright (C) 2013-2014 EaseMob Technologies. All rights reserved. 
  *  
  * NOTICE: All information contained herein is, and remains 
  * the property of EaseMob Technologies.
  * Dissemination of this information or reproduction of this material 
  * is strictly forbidden unless prior written permission is obtained
  * from EaseMob Technologies.
  */

#import "EMChooseViewController.h"
#import "FriendHelper.h"
#import "ImageCache.h"
#import "CommonUtil.h"
#import "UIImageView+AFNetworking.h"
@interface ContactSelectionViewController : EMChooseViewController
{
    FriendHelper  *friendHelp;

}

@property (strong,nonatomic) ImageCache *imageCache;
//已有选中的成员username，在该页面，这些成员不能被取消选择
- (instancetype)initWithBlockSelectedUsernames:(NSArray *)blockUsernames;

@end
