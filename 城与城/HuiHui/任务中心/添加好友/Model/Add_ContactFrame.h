//
//  Add_ContactFrame.h
//  HuiHui
//
//  Created by mac on 2017/3/31.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Add_ContactModel;

@interface Add_ContactFrame : NSObject

@property (nonatomic, assign) CGRect iconF;

@property (nonatomic, assign) CGRect nameF;

@property (nonatomic, assign) CGRect nickF;

@property (nonatomic, assign) CGRect phoneF;

@property (nonatomic, assign) CGRect addF;

@property (nonatomic, assign) CGRect lineF;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, strong) Add_ContactModel *add_contact;

@end
