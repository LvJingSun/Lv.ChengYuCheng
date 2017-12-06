//
//  GameScrollCell.m
//  HuiHui
//
//  Created by mac on 2017/5/17.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "GameScrollCell.h"
#import "LJConst.h"
#import "FSB_ScrollView.h"
#import "GameScrollModel.h"
#import "GameScrollFrame.h"

@interface GameScrollCell ()<FFScrollViewDelegate>

@property (nonatomic, strong) FSB_ScrollView *scrollview;

@property (nonatomic, weak) UILabel *lineLab;

@end

@implementation GameScrollCell

+ (instancetype)GameScrollCellWithTableview:(UITableView *)tableview {

    static NSString *cellID = @"GameScrollCell";
    
    GameScrollCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[GameScrollCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UILabel *label = [[UILabel alloc] init];
        
        self.lineLab = label;
        
        label.backgroundColor = FSB_ViewBGCOLOR;
        
        [self addSubview:label];
        
    }
    
    return self;
    
}

-(void)setFrameModel:(GameScrollFrame *)frameModel {

    _frameModel = frameModel;
    
    [self setRect];
    
}

- (void)setRect {
    
    self.scrollview = [[FSB_ScrollView alloc] initPageViewWithFrame:self.frameModel.scrollF views:self.frameModel.scrollmodel.source];
    
    self.scrollview.pageViewDelegate = self;
    
    self.scrollview.pageControl.pageIndicatorTintColor = [UIColor grayColor];
    
    self.scrollview.pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    
    [self addSubview:self.scrollview];
    
    self.lineLab.frame = self.frameModel.lineF;
    
}

- (void)scrollViewDidClickedAtPage:(NSInteger)pageNumber {

    if ([self.delegate respondsToSelector:@selector(scrollImageClick:)]) {
        
        [self.delegate scrollImageClick:pageNumber];
        
    }
    
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
