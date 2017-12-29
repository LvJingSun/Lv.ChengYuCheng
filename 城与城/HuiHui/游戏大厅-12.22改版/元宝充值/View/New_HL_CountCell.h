//
//  New_HL_CountCell.h
//  HuiHui
//
//  Created by mac on 2017/12/26.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NEW_HL_CountFrame;

@interface New_HL_CountCell : UICollectionViewCell

@property (nonatomic, strong) NEW_HL_CountFrame *frameModel;

@property (nonatomic, copy) dispatch_block_t countBlock;

@end
