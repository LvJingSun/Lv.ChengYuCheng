//
//  ApplyInPutCell.h
//  HuiHui
//
//  Created by mac on 2017/6/10.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ApplyInPutFrame;

@protocol Apply_fieldDelegate <NSObject>

- (void)ApplyMoneyFieldChange:(UITextField *)field;

@end

@interface ApplyInPutCell : UITableViewCell

+ (instancetype)ApplyInPutCellWithTableview:(UITableView *)tableview;

@property (nonatomic, strong) ApplyInPutFrame *frameModel;

@property (nonatomic, strong) id<Apply_fieldDelegate> delegate;

@property (nonatomic, copy) dispatch_block_t youfeiBlock;

@property (nonatomic, copy) dispatch_block_t baoxianBlock;

@property (nonatomic, copy) dispatch_block_t baoyangBlock;

//@property (nonatomic, copy) dispatch_block_t luntaiBlock;

@property (nonatomic, copy) dispatch_block_t xiuliBlock;

@property (nonatomic, copy) dispatch_block_t ChooseImgBlock;

@property (nonatomic, copy) dispatch_block_t SureBlock;

@end
