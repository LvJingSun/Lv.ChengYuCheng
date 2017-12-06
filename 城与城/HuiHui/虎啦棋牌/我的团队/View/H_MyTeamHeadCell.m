//
//  H_MyTeamHeadCell.m
//  HuiHui
//
//  Created by mac on 2017/11/7.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "H_MyTeamHeadCell.h"
#import "LJConst.h"

@implementation H_MyTeamHeadCell

+ (instancetype)H_MyTeamHeadCellWithTableview:(UITableView *)tableview {
    
    static NSString *cellID = @"H_MyTeamHeadCell";
    
    H_MyTeamHeadCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[H_MyTeamHeadCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.backgroundColor = [UIColor whiteColor];
        
        CGFloat Width = _WindowViewWidth * 0.25;
        
        CGFloat nameX = 0;
        
        CGFloat nameY = 0;
        
        CGFloat nameW = Width;
        
        CGFloat nameH = 50;
        
        UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(nameX, nameY, nameW, nameH)];
        
        name.textColor = FSB_StyleCOLOR;
        
        name.textAlignment = NSTextAlignmentCenter;
        
        name.font = [UIFont systemFontOfSize:17];
        
        name.text = @"会员名";
        
        [self addSubview:name];
        
        UILabel *level = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(name.frame), nameY, nameW, nameH)];
        
        level.text = @"代理级别";
        
        level.textColor = FSB_StyleCOLOR;
        
        level.textAlignment = NSTextAlignmentCenter;
        
        level.font = [UIFont systemFontOfSize:17];
        
        [self addSubview:level];
        
        UILabel *delegate = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(level.frame), nameY, nameW, nameH)];
        
        delegate.text = @"代理人数";
        
        delegate.textColor = FSB_StyleCOLOR;
        
        delegate.textAlignment = NSTextAlignmentCenter;
        
        delegate.font = [UIFont systemFontOfSize:17];
        
        [self addSubview:delegate];
        
        UILabel *member = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(delegate.frame), nameY, nameW, nameH)];
        
        member.text = @"会员人数";
        
        member.textColor = FSB_StyleCOLOR;
        
        member.textAlignment = NSTextAlignmentCenter;
        
        member.font = [UIFont systemFontOfSize:17];
        
        [self addSubview:member];
        
        UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(name.frame), _WindowViewWidth, 1)];
        
        line.backgroundColor = FSB_ViewBGCOLOR;
        
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
