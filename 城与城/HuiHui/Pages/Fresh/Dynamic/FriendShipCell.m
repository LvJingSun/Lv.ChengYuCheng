//
//  FriendShipCell.m
//  HuiHui
//
//  Created by mac on 16/9/29.
//  Copyright © 2016年 MaxLinksTec. All rights reserved.
//

#import "FriendShipCell.h"
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@implementation FriendShipCell

+ (instancetype)FriendShipCellWithTableview:(UITableView *)tableview {

    static NSString *cellID = @"FriendShipCell";
    
    FriendShipCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[FriendShipCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIImageView *iconImageview = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.032, 10, 50, 50)];
        
        self.m_ImgView = iconImageview;
        
        iconImageview.layer.cornerRadius = 5;
        
        [self addSubview:iconImageview];
        
        
        self.height = CGRectGetMaxY(iconImageview.frame) + 10;
        
    }
    
    return self;
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
