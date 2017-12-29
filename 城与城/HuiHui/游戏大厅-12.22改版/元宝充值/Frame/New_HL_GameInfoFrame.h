//
//  New_HL_GameInfoFrame.h
//  HuiHui
//
//  Created by mac on 2017/12/26.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>
@class New_HL_GameInfoModel;

@interface New_HL_GameInfoFrame : NSObject

@property (nonatomic, assign) CGRect line1F;

@property (nonatomic, assign) CGRect gameIDF;

@property (nonatomic, assign) CGRect line2F;

@property (nonatomic, assign) CGRect countF;

@property (nonatomic, assign) CGRect line3F;

@property (nonatomic, assign) CGSize size;

@property (nonatomic, strong) New_HL_GameInfoModel *model;

@end
