//
//  RepairMaintainModel.h
//  HuiHui
//
//  Created by mac on 2017/6/7.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RepairMaintainModel : NSObject

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *count;

@property (nonatomic, copy) NSString *status;

@property (nonatomic, copy) NSString *content;

@property (nonatomic, copy) NSString *time;

- (instancetype)initWithDict:(NSDictionary *)dic;

+ (instancetype)RepairMaintainModelWithDict:(NSDictionary *)dic;

@end
