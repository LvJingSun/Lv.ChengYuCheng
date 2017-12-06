//
//  Add_SearchCell.m
//  HuiHui
//
//  Created by mac on 2017/3/30.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "Add_SearchCell.h"

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define TabBGCOLOR [UIColor colorWithRed:244/255. green:244/255. blue:244/255. alpha:1.]
#define LineColor [UIColor colorWithRed:243/255.f green:243/255.f blue:243/255.f alpha:1.0]
#define SearchTextCOLOR [UIColor colorWithRed:169/255. green:169/255. blue:169/255. alpha:1.]

@implementation Add_SearchCell

+ (instancetype)Add_SearchCellWithTableview:(UITableView *)tableview {

    static NSString *cellID = @"Add_SearchCell";
    
    Add_SearchCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[Add_SearchCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UILabel *line1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
        
        line1.backgroundColor = LineColor;
        
        [self addSubview:line1];
        
        UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.05, 15, 20, 20)];
        
        imageview.image = [UIImage imageNamed:@"AddFriend_Search.png"];
        
        [self addSubview:imageview];
        
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageview.frame) + SCREEN_WIDTH * 0.05, 10, SCREEN_WIDTH * 0.95 - CGRectGetMaxX(imageview.frame) - SCREEN_WIDTH * 0.05, 30)];
        
        lab.textColor = SearchTextCOLOR;
        
        lab.font = [UIFont systemFontOfSize:16];
        
        lab.text = @"姓名/手机号";
        
        [self addSubview:lab];
        
        self.height = CGRectGetMaxY(lab.frame) + 10;
        
        UILabel *line2 = [[UILabel alloc] initWithFrame:CGRectMake(0, self.height - 1, SCREEN_WIDTH, 1)];
        
        line2.backgroundColor = LineColor;
        
        [self addSubview:line2];
        
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
