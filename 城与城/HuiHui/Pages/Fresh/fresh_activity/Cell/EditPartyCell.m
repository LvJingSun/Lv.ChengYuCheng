//
//  EditPartyCell.m
//  HuiHui
//
//  Created by mac on 14-10-24.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import "EditPartyCell.h"

@implementation EditPartyCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end


@implementation EditPartyTopicCell

- (void)awakeFromNib
{
    // Initialization code
    
    // 设置view的边框
    self.m_backView.layer.borderWidth = 1.0;
    self.m_backView.layer.borderColor = [UIColor colorWithRed:209/255.0 green:209/255.0 blue:208/255.0 alpha:1.0].CGColor;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end

@implementation EditPartyMapCell

- (void)awakeFromNib
{
    // Initialization code
    
    // 设置view的边框
    self.m_backView.layer.borderWidth = 1.0;
    self.m_backView.layer.borderColor = [UIColor colorWithRed:209/255.0 green:209/255.0 blue:208/255.0 alpha:1.0].CGColor;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end

