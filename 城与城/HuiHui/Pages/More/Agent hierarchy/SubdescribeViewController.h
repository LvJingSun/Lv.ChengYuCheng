//
//  SubdescribeViewController.h
//  HuiHui
//
//  Created by 冯海强 on 15-1-27.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "BaseViewController.h"
@protocol subHistoryDelegate <NSObject>
-(void)Submitsuccess;

@end
@interface SubdescribeViewController : BaseViewController<UITextViewDelegate>

@property (nonatomic,strong) NSString *toMemberId;
@property (nonatomic, assign) id<subHistoryDelegate> delegate;

@end
