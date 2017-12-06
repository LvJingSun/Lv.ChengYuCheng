//
//  AuthenticationModel.h
//  HuiHui
//
//  Created by mac on 2017/7/21.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AuthenticationModel : NSObject

//身份证正面照片
@property (nonatomic, strong) UIImage *faceImg;

//身份证反面照片
@property (nonatomic, strong) UIImage *backImg;

//姓名
@property (nonatomic, copy) NSString *name;

//国籍
@property (nonatomic, copy) NSString *nationality;

//身份证号
@property (nonatomic, copy) NSString *num;

//性别
@property (nonatomic, copy) NSString *sex;

//地址
@property (nonatomic, copy) NSString *address;

//出生日期
@property (nonatomic, copy) NSString *birth;

//机构
@property (nonatomic, copy) NSString *issue;

//开始日期
@property (nonatomic, copy) NSString *start_date;

//结束日期
@property (nonatomic, copy) NSString *end_date;

- (instancetype)initWithDict:(NSDictionary *)dic;

+ (instancetype)AuthenticationModelWithDict:(NSDictionary *)dic;

@end
