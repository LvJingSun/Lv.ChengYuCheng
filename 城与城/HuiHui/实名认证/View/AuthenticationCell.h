//
//  AuthenticationCell.h
//  HuiHui
//
//  Created by mac on 2017/7/21.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AuthenticationFrame;

@interface AuthenticationCell : UITableViewCell

+ (instancetype)AuthenticationCellWithTableview:(UITableView *)tableview;

@property (nonatomic, strong) AuthenticationFrame *frameModel;

@property (nonatomic, copy) dispatch_block_t faceImgBlock;

@property (nonatomic, copy) dispatch_block_t backImgBlock;

@property (nonatomic, copy) dispatch_block_t sureBlock;

@end
