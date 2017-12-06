//
//  HuaHuaViewCell.m
//  HuiHui
//
//  Created by mac on 16/7/31.
//  Copyright © 2016年 MaxLinksTec. All rights reserved.
//

#import "HuaHuaViewCell.h"

#define WIDTH [UIScreen mainScreen].bounds.size.width

#define HEIGHT [UIScreen mainScreen].bounds.size.height

@implementation HuaHuaViewCell

+ (instancetype)HuaHuaViewCellWithTableview:(UITableView *)tableview {

    static NSString *cellID = @"HuaHuaViewCell";
    
    HuaHuaViewCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[HuaHuaViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UILabel *countLab = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH * 0.032, 15, WIDTH * 0.468, 30)];
        
        self.countLab = countLab;
        
        countLab.font = [UIFont systemFontOfSize:22];
        
        [self addSubview:countLab];
        
        UILabel *nameLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(countLab.frame), 5, WIDTH * 0.468, 25)];
        
        self.nameLab = nameLab;
        
        nameLab.font = [UIFont systemFontOfSize:17];
        
        nameLab.textColor = [UIColor darkGrayColor];
        
        nameLab.textAlignment = NSTextAlignmentRight;
        
        [self addSubview:nameLab];
        
        UILabel *timeLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(countLab.frame), CGRectGetMaxY(nameLab.frame) + 5, WIDTH * 0.468, 25)];
        
        self.timeLab = timeLab;
        
        timeLab.font = [UIFont systemFontOfSize:15];
        
        timeLab.textColor = [UIColor lightGrayColor];
        
        timeLab.textAlignment = NSTextAlignmentRight;
        
        [self addSubview:timeLab];
        
        self.height = CGRectGetMaxY(countLab.frame) + 15;
        
        UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH * 0.032, self.height - 0.5, WIDTH * 0.968, 0.5)];
        
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
