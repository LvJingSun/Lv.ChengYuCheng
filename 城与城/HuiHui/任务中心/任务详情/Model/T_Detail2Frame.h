//
//  T_Detail2Frame.h
//  HuiHui
//
//  Created by mac on 2017/3/22.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>
//@class T_TaskMember;
@class TH_TaskMemberModel;

@interface T_Detail2Frame : NSObject

@property (nonatomic, assign) CGRect iconF;

@property (nonatomic, assign) CGRect nameF;

@property (nonatomic, assign) CGRect statusF;

@property (nonatomic, assign) CGRect countF;

@property (nonatomic, assign) CGFloat height;

//@property (nonatomic, strong) T_TaskMember *memberModel;

@property (nonatomic, strong) TH_TaskMemberModel *th_memberModel;

@end
