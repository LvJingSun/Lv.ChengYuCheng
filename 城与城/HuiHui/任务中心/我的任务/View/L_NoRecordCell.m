//
//  L_NoRecordCell.m
//  BusinessCenter
//
//  Created by mac on 2017/3/15.
//  Copyright © 2017年 冯海强. All rights reserved.
//

#import "L_NoRecordCell.h"

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#define ShenTextColor [UIColor colorWithRed:48/255. green:48/255. blue:48/255. alpha:1.]
#define TableColor [UIColor colorWithRed:245/255. green:245/255. blue:249/255. alpha:1.]
#define BigFont [UIFont systemFontOfSize:17]

@implementation L_NoRecordCell

+ (instancetype)L_NoRecordCellWithTableview:(UITableView *)tableview {

    static NSString *cellID = @"L_NoRecordCell";
    
    L_NoRecordCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[L_NoRecordCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.backgroundColor = TableColor;
        
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT * 0.3, SCREEN_WIDTH, 30)];
        
        lab.textColor = ShenTextColor;
        
        lab.font = BigFont;
        
        lab.text = @"暂无记录";
        
        lab.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:lab];
        
        self.height = SCREEN_HEIGHT - 64;
        
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
