//
//  HH_CustomMenuCell.m
//  HuiHui
//
//  Created by mac on 15-7-15.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "HH_CustomMenuCell.h"

@implementation HH_CustomMenuCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end


@implementation HH_CustomCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end


@implementation HH_CustomBuyedCell

- (void)awakeFromNib {
    // Initialization code
    
     self.m_totalImagV.image = [[UIImage imageNamed:@"login_shuru.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:1];
    
    self.m_usedImagV.image = [[UIImage imageNamed:@"login_shuru.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:1];

    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end


@implementation HH_OrignCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end

@implementation HH_TejiaCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end


