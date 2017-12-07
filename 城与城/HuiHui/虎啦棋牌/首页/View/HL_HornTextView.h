//
//  HL_HornTextView.h
//  HuiHui
//
//  Created by mac on 2017/12/7.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HL_HornTextModel;

@interface HL_HornTextView : UIView

@property (strong, nonatomic) HL_HornTextModel *model;

@property (strong, nonatomic) NSArray *textArray;

@end
