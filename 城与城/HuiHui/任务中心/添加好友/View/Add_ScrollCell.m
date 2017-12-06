//
//  Add_ScrollCell.m
//  HuiHui
//
//  Created by mac on 2017/3/30.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "Add_ScrollCell.h"

#define SearchTextCOLOR [UIColor colorWithRed:169/255. green:169/255. blue:169/255. alpha:1.]
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define LineColor [UIColor colorWithRed:243/255.f green:243/255.f blue:243/255.f alpha:1.0]

@implementation Add_ScrollCell

+ (instancetype)Add_ScrollCellWithTableview:(UITableView *)tableview {

    static NSString *cellID = @"Add_ScrollCell";
    
    Add_ScrollCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[Add_ScrollCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.05, 10, SCREEN_WIDTH * 0.45, 30)];
        
        lab.textColor = [UIColor darkTextColor];
        
        lab.font = [UIFont systemFontOfSize:17];
        
        lab.text = @"推荐任务伙伴";
        
        [self addSubview:lab];
        
        UILabel *moreLab = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.5, 15, SCREEN_WIDTH * 0.4, 20)];
        
        moreLab.textColor = SearchTextCOLOR;
        
        moreLab.font = [UIFont systemFontOfSize:15];
        
        moreLab.text = @"查看更多";
        
        moreLab.textAlignment = NSTextAlignmentRight;
        
        [self addSubview:moreLab];
        
        UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.05, CGRectGetMaxY(lab.frame) + 9, SCREEN_WIDTH * 0.95, 1)];
        
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
