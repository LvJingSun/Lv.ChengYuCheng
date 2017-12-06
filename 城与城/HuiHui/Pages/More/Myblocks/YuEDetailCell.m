//
//  YuEDetailCell.m
//  HuiHui
//
//  Created by mac on 2016/11/7.
//  Copyright © 2016年 MaxLinksTec. All rights reserved.
//

#import "YuEDetailCell.h"

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@implementation YuEDetailCell

+ (instancetype)YuEDetailCellWithTableview:(UITableView *)tableview {

    static NSString *cellID = @"YuEDetailCell";
    
    YuEDetailCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[YuEDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.05, 15, SCREEN_WIDTH * 0.45, 30)];
        
        self.typeLab = lab;
        
        lab.textColor = [UIColor darkGrayColor];
        
        [self addSubview:lab];
        
        UILabel *count = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.5, 15, SCREEN_WIDTH * 0.45, 30)];
        
        self.countLab = count;
        
        count.textAlignment = NSTextAlignmentRight;
        
        [self addSubview:count];
        
        UILabel *time = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.05, CGRectGetMaxY(lab.frame) + 10, SCREEN_WIDTH * 0.9, 20)];
        
        self.timeLab = time;
        
        time.font = [UIFont systemFontOfSize:15];
        
        time.textColor = [UIColor lightGrayColor];
        
        [self addSubview:time];
        
        self.height = CGRectGetMaxY(time.frame) + 15;
        
        UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, self.height - 1, SCREEN_WIDTH, 1)];
        
        line.backgroundColor = [UIColor lightGrayColor];
        
        [self addSubview:line];
        
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
