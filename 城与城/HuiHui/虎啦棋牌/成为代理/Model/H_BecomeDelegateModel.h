//
//  H_BecomeDelegateModel.h
//  HuiHui
//
//  Created by mac on 2017/11/3.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface H_BecomeDelegateModel : NSObject

@property (nonatomic, copy) NSString *CategoryId;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *price;

@property (nonatomic, copy) NSString *OriginalPrice; //原价

@property (nonatomic, copy) NSString *btnStatus;

@property (nonatomic, copy) NSString *Remark;

@property (nonatomic, copy) NSString *CanMatching;

@property (nonatomic, copy) NSString *MatchingPrice; //差价

@end
