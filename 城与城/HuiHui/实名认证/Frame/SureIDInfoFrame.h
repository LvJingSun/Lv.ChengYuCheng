//
//  SureIDInfoFrame.h
//  HuiHui
//
//  Created by mac on 2017/7/21.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>
@class AuthenticationModel;

@interface SureIDInfoFrame : NSObject

@property (nonatomic, assign) CGRect nameTitleF;

@property (nonatomic, assign) CGRect nameF;

@property (nonatomic, assign) CGRect numTitleF;

@property (nonatomic, assign) CGRect numF;

@property (nonatomic, assign) CGRect dateTitleF;

@property (nonatomic, assign) CGRect dateF;

@property (nonatomic, assign) CGRect lineF;

@property (nonatomic, assign) CGRect faceTitleF;

@property (nonatomic, assign) CGRect faceF;

@property (nonatomic, assign) CGRect backTitleF;

@property (nonatomic, assign) CGRect backF;

@property (nonatomic, assign) CGRect sureBGF;

@property (nonatomic, assign) CGRect sureF;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, strong) AuthenticationModel *authModel;

@end
