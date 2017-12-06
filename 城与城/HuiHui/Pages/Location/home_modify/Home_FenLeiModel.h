//
//  Home_FenLeiModel.h
//  HuiHui
//
//  Created by mac on 2017/9/8.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Home_FenLeiModel : NSObject

//@property (nonatomic, copy) NSString *iconUrl;
//
//@property (nonatomic, copy) NSString *iconTitle;
//
//@property (nonatomic, copy) NSString *clickType;



@property (nonatomic, copy) NSString *Type;

@property (nonatomic, copy) NSString *Title;

@property (nonatomic, copy) NSString *Contents;

@property (nonatomic, copy) NSString *PhotoUrl;

@property (nonatomic, copy) NSString *LinkUrl;

- (instancetype)initWithDict:(NSDictionary *)dic;

+ (instancetype)Home_FenLeiModelWithDict:(NSDictionary *)dic;

@end
