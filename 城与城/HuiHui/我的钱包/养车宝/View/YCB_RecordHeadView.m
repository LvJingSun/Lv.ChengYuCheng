//
//  YCB_RecordHeadView.m
//  HuiHui
//
//  Created by mac on 2017/9/12.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "YCB_RecordHeadView.h"
#import "LJConst.h"

@implementation YCB_RecordHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        UISegmentedControl *segm = [[UISegmentedControl alloc] initWithItems:@[@"全部",@"领取",@"转出"]];
        
        segm.frame = CGRectMake(_WindowViewWidth * 0.05, 10, _WindowViewWidth * 0.9, 40);
        
        UIFont *font = [UIFont boldSystemFontOfSize:17.0f];
        
        NSDictionary *attributes = [NSDictionary dictionaryWithObject:font
                                                               forKey:UITextAttributeFont];
        
        [segm setTitleTextAttributes:attributes forState:0];
        
        segm.tintColor = [UIColor colorWithRed:242/255. green:88/255. blue:52/255. alpha:1.];
        
        segm.selectedSegmentIndex = 0;
        
        [segm addTarget:self action:@selector(segmClick:) forControlEvents:UIControlEventValueChanged];
        
        [self addSubview:segm];
        
        UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(segm.frame) + 9.5, _WindowViewWidth, 0.5)];
        
        line.backgroundColor = [UIColor colorWithRed:235/255. green:235/255. blue:235/255. alpha:1.];
        
        [self addSubview:line];
        
        self.height = CGRectGetMaxY(line.frame);
        
    }
    
    return self;
    
}

- (void)segmClick:(UISegmentedControl *)segm {
    
    self.changeblock(segm.selectedSegmentIndex);
    
}

- (void)returnChangeValue:(SegmChangeBlock)block {
    
    self.changeblock = block;
    
}

@end
