//
//  AuthenticationFrame.h
//  HuiHui
//
//  Created by mac on 2017/7/21.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>
@class AuthenticationModel;

@interface AuthenticationFrame : NSObject

@property (nonatomic, assign) CGRect faceTitleF;

@property (nonatomic, assign) CGRect faceImgF;

@property (nonatomic, assign) CGRect backTitleF;

@property (nonatomic, assign) CGRect backImgF;

@property (nonatomic, assign) CGRect sureF;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, strong) AuthenticationModel *authenModel;

@end
