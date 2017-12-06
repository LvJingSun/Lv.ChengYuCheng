//
//  SetYongjinCell.m
//  HuiHui
//
//  Created by mac on 16/5/27.
//  Copyright © 2016年 MaxLinksTec. All rights reserved.
//

#import "SetYongjinCell.h"
#define Size ([UIScreen mainScreen].bounds.size)

@implementation SetYongjinCell

+ (instancetype)SetYongjinCellWithTableView:(UITableView *)tableview {

    static NSString *cellID = @"SetYongjinCell";
    
    SetYongjinCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[SetYongjinCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.countField.delegate = self;
        
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 11, Size.width * 0.3, 21)];
        
        self.levelNameLabel = nameLabel;
        
        nameLabel.textColor = [UIColor scrollViewTexturedBackgroundColor];
        
        nameLabel.font = [UIFont systemFontOfSize:15];
        
        nameLabel.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:nameLabel];
        
        UITextField *field = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(nameLabel.frame), 11, Size.width * 0.5, 21)];
        
        self.countField = field;
        
        field.textAlignment = NSTextAlignmentRight;
        
        field.font = [UIFont systemFontOfSize:15];
        
        [self addSubview:field];
        
        UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(nameLabel.frame), CGRectGetMaxY(field.frame), Size.width * 0.5, 1)];
        
        line.backgroundColor = [UIColor lightGrayColor];
        
        [self addSubview:line];
        
        UILabel *perLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(field.frame), 11, Size.width * 0.2, 21)];
        
        perLabel.textColor = [UIColor scrollViewTexturedBackgroundColor];
        
        perLabel.font = [UIFont systemFontOfSize:15];
        
        perLabel.text = @"%";
        
        perLabel.textAlignment = NSTextAlignmentCenter;
        
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
