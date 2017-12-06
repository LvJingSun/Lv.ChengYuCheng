//
//  CPSTakeOrderTableViewCell.h
//  HuiHui
//
//  Created by fenghq on 15/9/23.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageCache.h"

@class LSPaoMaView;

@interface CPSTakeOrderTableViewCell : UITableViewCell
@property (nonatomic,weak) IBOutlet UIView *startView;
@property (nonatomic,weak) IBOutlet UIView *segmentView;


@end
@interface CPSTakeOrderTableViewCell1 : UITableViewCell
@property (nonatomic,weak) IBOutlet UILabel *NickName;
@property (nonatomic,weak) IBOutlet UILabel *Description;
@property (nonatomic,weak) IBOutlet UILabel *CreateDate;
@property (nonatomic,weak) IBOutlet UILabel *ScoreWLScore;

@property (nonatomic,weak) IBOutlet UIImageView *headImageV;
@property (weak, nonatomic) ImageCache *imageCache;

- (void)setMactLogImagePath:(NSString *)imagePath;

@end
@interface CPSTakeOrderTableViewCell2 : UITableViewCell
@property (nonatomic,weak) IBOutlet UIView *startView;
@property (nonatomic,weak) IBOutlet UILabel *MerchantShopName;
@property (nonatomic,weak) IBOutlet UILabel *Score;
@property (nonatomic,weak) IBOutlet UILabel *SalesQsPricePsPrice;//售量
@property (nonatomic,weak) IBOutlet UIImageView *Logo;
@property (nonatomic,weak) IBOutlet UILabel *Address;
@property (nonatomic,weak) IBOutlet UIButton *phone;
@property (nonatomic,weak) IBOutlet UILabel *Distance;

@property (weak, nonatomic) ImageCache *imageCache;

- (void)setMactLogImagePath:(NSString *)imagePath;

@end
@interface CPSTakeOrderTableViewCell3 : UITableViewCell

@property (nonatomic,weak) IBOutlet UILabel *textCPSLabel;
@property (nonatomic,weak) IBOutlet UIImageView *imageCPSIMV;


@end


@interface CPSTakeOrderTableViewCell4 : UITableViewCell
@property (nonatomic,weak) IBOutlet UIView *segmentView;

@property (nonatomic,weak) IBOutlet UILabel *Score;
@property (nonatomic,weak) IBOutlet UILabel *AvgScore;
@property (nonatomic,weak) IBOutlet UILabel *WLScore;
@property (nonatomic,weak) IBOutlet UIButton *ScoreTypeBtn;


@end