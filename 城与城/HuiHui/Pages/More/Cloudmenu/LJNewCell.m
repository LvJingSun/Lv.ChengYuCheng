//
//  LJNewCell.m
//  HuiHui
//
//  Created by mac on 16/5/27.
//  Copyright © 2016年 MaxLinksTec. All rights reserved.
//

#import "LJNewCell.h"
#define Size ([UIScreen mainScreen].bounds.size)

@implementation LJNewCell

+ (instancetype)LJNewCellWithTableview:(UITableView *)tableview {

    static NSString *cellID = @"LJNewCell";
    
    LJNewCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[LJNewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(8, 11, Size.width * 0.7, 21)];
        
        self.titleLabel = label;
        
        label.text = @"设置佣金";
        
        label.textColor = [UIColor scrollViewTexturedBackgroundColor];
        
        label.font = [UIFont systemFontOfSize:17];
        
        [self addSubview:label];
        
        self.height = 44;
        
        UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, 43, Size.width, 1)];
        
        line.backgroundColor = [UIColor colorWithRed:200/255. green:199/255. blue:204/255. alpha:1.];
        
        [self addSubview:line];
        
        UISwitch *ljswitch = [[UISwitch alloc] initWithFrame:CGRectMake(Size.width * 0.85, 6, 51, 31)];
        
        self.LJswitch = ljswitch;
        
        [self addSubview:ljswitch];
        
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
