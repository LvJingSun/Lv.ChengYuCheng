//
//  HL_ScrollHornFrame.h
//  HuiHui
//
//  Created by mac on 2017/12/7.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HL_ScrollHornModel;

@interface HL_ScrollHornFrame : NSObject

@property (nonatomic, assign) CGRect hornImgF;

@property (nonatomic, assign) CGRect hornTextF;

@property (nonatomic, assign) CGRect lineF;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, strong) HL_ScrollHornModel *scrollHornModel;

@end
