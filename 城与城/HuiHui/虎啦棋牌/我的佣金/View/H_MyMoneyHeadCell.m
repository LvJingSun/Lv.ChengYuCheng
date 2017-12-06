//
//  H_MyMoneyHeadCell.m
//  HuiHui
//
//  Created by mac on 2017/11/7.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "H_MyMoneyHeadCell.h"
#import "LJConst.h"

@interface H_MyMoneyHeadCell ()

@property (nonatomic, weak) UISegmentedControl *segmContr;

@end

@implementation H_MyMoneyHeadCell

+ (instancetype)H_MyMoneyHeadCellWithTableview:(UITableView *)tableview {
    
    static NSString *cellID = @"H_MyMoneyHeadCell";
    
    H_MyMoneyHeadCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[H_MyMoneyHeadCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.backgroundColor = [UIColor whiteColor];
        
        UIView *bg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _WindowViewWidth, 50)];
        
        bg.backgroundColor = FSB_ViewBGCOLOR;
        
        [self addSubview:bg];
        
        CGFloat segmH = 40;
        
        CGFloat segmW = _WindowViewWidth * 0.5;
        
        UISegmentedControl *segmContr = [[UISegmentedControl alloc] initWithItems:@[@"今日提成",@"近三月提成"]];
        
        self.segmContr = segmContr;
        
        segmContr.frame = CGRectMake((_WindowViewWidth - segmW) * 0.5, (50 - segmH) * 0.5, segmW, segmH);
        
        UIFont *font = [UIFont boldSystemFontOfSize:17.0f];
        
        NSDictionary *attributes = [NSDictionary dictionaryWithObject:font
                                                               forKey:NSFontAttributeName];
        
        [segmContr setTitleTextAttributes:attributes forState:0];
        
        segmContr.tintColor = FSB_StyleCOLOR;
        
        [segmContr addTarget:self action:@selector(segmClick:) forControlEvents:UIControlEventValueChanged];
        
        [bg addSubview:segmContr];
        
        CGFloat Width = _WindowViewWidth * 0.25;
        
        CGFloat nameX = 0;
        
        CGFloat nameY = CGRectGetMaxY(bg.frame);
        
        CGFloat nameW = Width;
        
        CGFloat nameH = 50;
        
        UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(nameX, nameY, nameW, nameH)];
        
        name.textColor = FSB_StyleCOLOR;
        
        name.textAlignment = NSTextAlignmentCenter;
        
        name.font = [UIFont systemFontOfSize:17];
        
        name.text = @"用户昵称";
        
        [self addSubview:name];
        
        UILabel *level = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(name.frame), nameY, nameW, nameH)];
        
        level.text = @"游戏ID";
        
        level.textColor = FSB_StyleCOLOR;
        
        level.textAlignment = NSTextAlignmentCenter;
        
        level.font = [UIFont systemFontOfSize:17];
        
        [self addSubview:level];
        
        UILabel *delegate = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(level.frame), nameY, nameW, nameH)];
        
        delegate.text = @"提成金额";
        
        delegate.textColor = FSB_StyleCOLOR;
        
        delegate.textAlignment = NSTextAlignmentCenter;
        
        delegate.font = [UIFont systemFontOfSize:17];
        
        [self addSubview:delegate];
        
        UILabel *member = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(delegate.frame), nameY, nameW, nameH)];
        
        member.text = @"来源";
        
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

-(void)setSelectIndex:(NSString *)selectIndex {
    
    _selectIndex = selectIndex;
    
    if ([selectIndex isEqualToString:@"1"]) {
        
        self.segmContr.selectedSegmentIndex = 0;
        
    }else if ([selectIndex isEqualToString:@"2"]) {
        
        self.segmContr.selectedSegmentIndex = 1;
        
    }
    
}

- (void)segmClick:(UISegmentedControl *)segm {
    
    self.changeBlock(segm.selectedSegmentIndex);
    
}

- (void)returnChangeValue:(SegmValueChangeBlock)block {
    
    self.changeBlock = block;
    
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
