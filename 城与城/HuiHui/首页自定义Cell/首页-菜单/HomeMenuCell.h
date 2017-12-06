//
//  HomeMenuCell.h
//  HuiHui
//
//  Created by mac on 2017/9/5.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HomeMenuFrame;

@interface HomeMenuCell : UITableViewCell

+ (instancetype)HomeMenuCellWithTableview:(UITableView *)tableview;

@property (nonatomic, strong) HomeMenuFrame *frameModel;

@property (nonatomic, copy) dispatch_block_t meishiBlock;

@property (nonatomic, copy) dispatch_block_t lirenBlock;

@property (nonatomic, copy) dispatch_block_t KTVBlock;

@property (nonatomic, copy) dispatch_block_t yangchebaoBlock;

@property (nonatomic, copy) dispatch_block_t youxiBlock;

@property (nonatomic, copy) dispatch_block_t chepiaoBlock;

@property (nonatomic, copy) dispatch_block_t jipiaoBlock;

@property (nonatomic, copy) dispatch_block_t jiudianBlock;

@property (nonatomic, copy) dispatch_block_t jingdianBlock;

@property (nonatomic, copy) dispatch_block_t gengduoBlock;

@end
