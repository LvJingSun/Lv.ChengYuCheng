//
//  GameRechargeAlertView.h
//  HuiHui
//
//  Created by mac on 2017/10/27.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameRechargeAlertView : UIView

- (instancetype)initWithTitle:(NSString *)titletext
                     withLeft:(NSString *)lefttext
                    withRight:(NSString *)righttext
              withFSB_Balance:(NSString *)fsb_balance
              withCAC_Balance:(NSString *)cac_balance
                    withCount:(NSString *)counttext
                     withSure:(NSString *)suretext;

- (void)showInView:(UIView *)view;

- (void)dismissFromView;

@property (nonatomic, copy) dispatch_block_t leftBlock;
@property (nonatomic, copy) dispatch_block_t rightBlock;
@property (nonatomic, copy) dispatch_block_t sureBlock;
//点击左右按钮都会触发该消失的block
@property (nonatomic, copy) dispatch_block_t dismissBlock;

@property (nonatomic, weak) UILabel *countLab;



@end
