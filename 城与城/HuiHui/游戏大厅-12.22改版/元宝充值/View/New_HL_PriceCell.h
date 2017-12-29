//
//  New_HL_PriceCell.h
//  HuiHui
//
//  Created by mac on 2017/12/26.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>
@class New_HL_PriceFrame;

@interface New_HL_PriceCell : UICollectionViewCell

@property (nonatomic, strong) New_HL_PriceFrame *frameModel;

@property (nonatomic, copy) dispatch_block_t rechargeBlock;

@end
