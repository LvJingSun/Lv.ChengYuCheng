//
//  MenuBtnModel.h
//  HuiHui
//
//  Created by mac on 2017/9/5.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MenuBtnModel : NSObject

//@property (nonatomic, copy) NSString *imageName;
//
//@property (nonatomic, copy) NSString *title;
//
//// 跳转类型
//@property (nonatomic, copy) NSString *homeBtnType;
//
//// url
//@property (nonatomic, copy) NSString *homeBtnUrl;



@property (nonatomic, copy) NSString *Type;

@property (nonatomic, copy) NSString *Title;

@property (nonatomic, copy) NSString *Contents;

@property (nonatomic, copy) NSString *PhotoUrl;

@property (nonatomic, copy) NSString *LinkUrl;

+ (instancetype)homeBtnModelWithDict:(NSDictionary *)dic;

- (instancetype)initWithDict:(NSDictionary *)dic;

@end
