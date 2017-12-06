//
//  LJTimeCell.m
//  HuiHui
//
//  Created by mac on 16/5/30.
//  Copyright © 2016年 MaxLinksTec. All rights reserved.
//

#import "LJTimeCell.h"
#define Size ([UIScreen mainScreen].bounds.size)

@implementation LJTimeCell

+ (instancetype)LJTimeCellWithTableView:(UITableView *)tableview {

    static NSString *cellID = @"LJTimeCell";
    
    LJTimeCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[LJTimeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 11, Size.width * 0.3, 21)];
        
        self.title = nameLabel;
        
        nameLabel.text = @"项目时长：";
        
        nameLabel.textColor = [UIColor scrollViewTexturedBackgroundColor];
        
        nameLabel.font = [UIFont systemFontOfSize:15];
        
        nameLabel.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:nameLabel];
        
        UITextField *field = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(nameLabel.frame), 11, Size.width * 0.5, 21)];
        
        self.timeField = field;
        
        field.textAlignment = NSTextAlignmentRight;
        
        field.font = [UIFont systemFontOfSize:15];
        
        [self addSubview:field];
        
        UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(nameLabel.frame), CGRectGetMaxY(field.frame), Size.width * 0.5, 1)];
        
        line.backgroundColor = [UIColor lightGrayColor];
        
        [self addSubview:line];
        
        UILabel *perLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(field.frame), 11, Size.width * 0.2, 21)];
        
        perLabel.textColor = [UIColor scrollViewTexturedBackgroundColor];
        
        perLabel.textAlignment = NSTextAlignmentCenter;
        
        perLabel.font = [UIFont systemFontOfSize:14];
        
        perLabel.text = @"分钟";
        
        [self addSubview:perLabel];
        
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
