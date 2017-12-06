//
//  RH_ListNoDataCell.m
//  HuiHui
//
//  Created by mac on 2017/6/15.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "RH_ListNoDataCell.h"
#import "RedHorseHeader.h"

@interface RH_ListNoDataCell ()

@property (nonatomic, weak) UILabel *title;

@end

@implementation RH_ListNoDataCell

+ (instancetype)RH_ListNoDataCellWithTableview:(UITableView *)tableview {

    static NSString *cellID = @"RH_ListNoDataCell";
    
    RH_ListNoDataCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[RH_ListNoDataCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.backgroundColor = RH_ViewBGColor;
        
        UILabel *lab = [[UILabel alloc] init];
        
        self.title = lab;
        
        lab.textAlignment = NSTextAlignmentCenter;
        
        lab.font = [UIFont systemFontOfSize:17];
        
        lab.textColor = [UIColor darkGrayColor];
        
        [self addSubview:lab];
        
    }
    
    return self;
    
}

-(void)setTitleText:(NSString *)titleText {

    _titleText = titleText;
    
    [self setRect];
    
    [self setContent];
    
}

- (void)setRect {

    self.title.frame = CGRectMake(0, 100, ScreenWidth, 30);
    
    self.height = CGRectGetMaxY(self.title.frame);
    
}

- (void)setContent {

    self.title.text = self.titleText;
    
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
