//
//  MoneyXQCell.m
//  HuiHui
//
//  Created by mac on 2016/12/5.
//  Copyright © 2016年 MaxLinksTec. All rights reserved.
//

#import "MoneyXQCell.h"
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@implementation MoneyXQCell

+ (instancetype)MoneyXQCellWithTableview:(UITableView *)tableview {

    static NSString *cellID = @"MoneyXQCell";
    
    MoneyXQCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[MoneyXQCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UILabel *no = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.05, 20, SCREEN_WIDTH * 0.9, 20)];
        
        self.NOLab = no;
        
        [self addSubview:no];
        
        UILabel *time = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.05, CGRectGetMaxY(no.frame) + 5, SCREEN_WIDTH * 0.9, 20)];
        
        self.timeLab = time;
        
        [self addSubview:time];
        
        UILabel *money = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.05, CGRectGetMaxY(time.frame) + 5, SCREEN_WIDTH * 0.9, 20)];
        
        self.moneyLab = money;
        
        [self addSubview:money];
        
        UILabel *type = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.05, CGRectGetMaxY(money.frame) + 5, SCREEN_WIDTH * 0.9, 20)];
        
        self.typeLab = type;
        
        [self addSubview:type];
        
        UILabel *status = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.05, CGRectGetMaxY(type.frame) + 5, SCREEN_WIDTH * 0.9, 20)];
        
        self.statusLab = status;
        
        [self addSubview:status];
        
        UILabel *line1 = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.05, CGRectGetMaxY(status.frame) + 20, SCREEN_WIDTH * 0.95, 0.5)];
        
        line1.backgroundColor = [UIColor lightGrayColor];
        
        [self addSubview:line1];
        
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.05, CGRectGetMaxY(line1.frame) + 20, SCREEN_WIDTH * 0.95, 20)];
        
        lab.text = @"交易金额:";
        
        [self addSubview:lab];
        
        UILabel *count = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.05, CGRectGetMaxY(lab.frame) + 10, SCREEN_WIDTH * 0.95, 30)];
        
        self.countLab = count;
        
        count.font = [UIFont systemFontOfSize:20];
        
        count.textColor = [UIColor orangeColor];
        
        [self addSubview:count];
        
        UILabel *line2 = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.05, CGRectGetMaxY(count.frame) + 20, SCREEN_WIDTH * 0.95, 0.5)];
        
        line2.backgroundColor = [UIColor lightGrayColor];
        
        [self addSubview:line2];
        
        UILabel *desc = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.05, CGRectGetMaxY(line2.frame) + 20, SCREEN_WIDTH * 0.95, 20)];
        
        self.descLab = desc;
        
        [self addSubview:desc];
        
        self.height = CGRectGetMaxY(desc.frame);
        
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
