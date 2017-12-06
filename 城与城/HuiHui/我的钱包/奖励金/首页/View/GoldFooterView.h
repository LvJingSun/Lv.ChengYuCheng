//
//  GoldFooterView.h
//  HuiHui
//
//  Created by mac on 2017/9/11.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GoldFooterView : UIView

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, copy) dispatch_block_t getInBlock;

@property (nonatomic, copy) dispatch_block_t getOutBlock;

@end
