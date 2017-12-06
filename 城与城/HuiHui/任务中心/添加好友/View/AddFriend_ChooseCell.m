//
//  AddFriend_ChooseCell.m
//  HuiHui
//
//  Created by mac on 2017/3/30.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "AddFriend_ChooseCell.h"

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define TabBGCOLOR [UIColor colorWithRed:244/255. green:244/255. blue:244/255. alpha:1.]
#define LineColor [UIColor colorWithRed:243/255.f green:243/255.f blue:243/255.f alpha:1.0]

@implementation AddFriend_ChooseCell

+ (instancetype)AddFriend_ChooseCellWithTableview:(UITableView *)tableview {

    static NSString *cellID = @"AddFriend_ChooseCell";
    
    AddFriend_ChooseCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[AddFriend_ChooseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
    
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.05, 10, 30, 30)];
        
        self.iconImageview = imageview;
        
        [self addSubview:imageview];
        
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageview.frame) + SCREEN_WIDTH * 0.05, 10, SCREEN_WIDTH * 0.75 - CGRectGetMaxX(imageview.frame), 30)];
        
        self.titleLab = lab;
        
        lab.textColor = [UIColor darkTextColor];
        
        lab.font = [UIFont systemFontOfSize:17];
        
        [self addSubview:lab];
        
        UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageview.frame) + SCREEN_WIDTH * 0.05, CGRectGetMaxY(lab.frame) + 9, SCREEN_WIDTH * 0.95 - CGRectGetMaxX(imageview.frame), 1)];
        
        line.backgroundColor = LineColor;
        
        [self addSubview:line];
        
        self.height = CGRectGetMaxY(line.frame);
        
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
