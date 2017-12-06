//
//  H_MyTeamFrame.h
//  HuiHui
//
//  Created by mac on 2017/11/3.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>
@class H_MyTeamModel;

@interface H_MyTeamFrame : NSObject

@property (nonatomic, assign) CGRect nameF;

@property (nonatomic, assign) CGRect levelF;

@property (nonatomic, assign) CGRect delegateF;

@property (nonatomic, assign) CGRect memberF;

@property (nonatomic, assign) CGRect lineF;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, strong) H_MyTeamModel *model;

@end
