//
//  HL_GameDownLoadModel.h
//  HuiHui
//
//  Created by mac on 2017/12/7.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HL_GameDownLoadModel : NSObject

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *downloadAddress;

@property (nonatomic, copy) NSString *iconUrl;

@property (nonatomic, copy) NSString *gameName;

@property (nonatomic, copy) NSString *downloadCount;

@end
