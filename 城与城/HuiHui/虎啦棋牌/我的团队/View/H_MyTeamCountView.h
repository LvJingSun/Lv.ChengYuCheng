//
//  H_MyTeamCountView.h
//  HuiHui
//
//  Created by mac on 2017/12/7.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface H_MyTeamCountView : UIView

@property (nonatomic, weak) UILabel *titleLab;

@property (nonatomic, weak) UILabel *contentLab;

@property (nonatomic, copy) dispatch_block_t clickBlock;

@end
