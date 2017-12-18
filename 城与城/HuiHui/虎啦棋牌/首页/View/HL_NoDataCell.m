//
//  HL_NoDataCell.m
//  HuiHui
//
//  Created by mac on 2017/12/18.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "HL_NoDataCell.h"
#import "LJConst.h"

@implementation HL_NoDataCell

+ (instancetype)HL_NoDataCellWithTableview:(UITableView *)tableview {
    
    static NSString *cellID = @"HL_NoDataCell";
    
    HL_NoDataCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[HL_NoDataCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        CGFloat X = _WindowViewWidth * 0.05;
        
        CGFloat Y = 10;
        
        CGFloat W = _WindowViewWidth * 0.9;
        
        CGFloat H = 30;
        
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(X, Y, W, H)];
        
        lab.textColor = [UIColor darkGrayColor];
        
        lab.textAlignment = NSTextAlignmentCenter;
        
        lab.font = [UIFont systemFontOfSize:17];
        
        lab.text = @"暂无数据";
        
        [self addSubview:lab];
        
        self.height = CGRectGetMaxY(lab.frame) + Y;
        
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
