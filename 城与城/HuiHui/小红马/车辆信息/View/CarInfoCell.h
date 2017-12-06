//
//  CarInfoCell.h
//  HuiHui
//
//  Created by mac on 2017/6/8.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CarInfoFrame;

@protocol CarInfo_FieldDelegate <NSObject>

- (void)PlateFieldChange:(UITextField *)field;

- (void)BuyMoneyFieldChange:(UITextField *)field;

- (void)EngineNumberFieldChange:(UITextField *)field;

- (void)MileageFieldChange:(UITextField *)field;

@end

@interface CarInfoCell : UITableViewCell

+ (instancetype)CarInfoCellWithTableview:(UITableView *)tableview;

@property (nonatomic, strong) CarInfoFrame *frameModel;

@property (nonatomic, strong) id<CarInfo_FieldDelegate> delegate;

@property (nonatomic, copy) dispatch_block_t ChooseBlock;

@property (nonatomic, copy) dispatch_block_t timeBlock;

@property (nonatomic, copy) dispatch_block_t InvoiceBlock;

@property (nonatomic, copy) dispatch_block_t SureBlock;

@end
