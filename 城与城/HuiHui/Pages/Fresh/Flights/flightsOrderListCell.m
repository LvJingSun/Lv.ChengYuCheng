//
//  flightsOrderListCell.m
//  HuiHui
//
//  Created by mac on 15-1-7.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "flightsOrderListCell.h"

@implementation flightsOrderListCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end


@implementation flightsOrderPriceCell

- (void)awakeFromNib {
    // Initialization code
    self.m_imageV.frame = CGRectMake(0, 51, WindowSizeWidth, 0.4);

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
    
}

@end

@implementation flightsOrderRideCell

- (void)awakeFromNib {
    // Initialization code
    
    self.m_imageV.frame = CGRectMake(0, 93, WindowSizeWidth, 0.4);

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
    

}

@end

@implementation flightsOrderContactCell

- (void)awakeFromNib {
    // Initialization code
    
    self.m_imageV.frame = CGRectMake(0, 54, WindowSizeWidth, 0.4);

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end