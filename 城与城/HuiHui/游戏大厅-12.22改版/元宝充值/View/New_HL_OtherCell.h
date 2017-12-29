//
//  New_HL_OtherCell.h
//  HuiHui
//
//  Created by mac on 2017/12/26.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>
@class New_HL_OtherFrame;

@protocol OtherPriceFieldDelegate <NSObject>

- (void)OtherPriceFieldChange:(UITextField *)field;

@end

@interface New_HL_OtherCell : UICollectionViewCell

@property (nonatomic, strong) New_HL_OtherFrame *frameModel;

@property (nonatomic, strong) id<OtherPriceFieldDelegate> delegate;

@end
