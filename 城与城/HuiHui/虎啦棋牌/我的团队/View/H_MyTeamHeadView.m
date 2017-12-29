//
//  H_MyTeamHeadView.m
//  HuiHui
//
//  Created by mac on 2017/12/27.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "H_MyTeamHeadView.h"
#import "LJConst.h"
#import "H_MyTeamCountView.h"

@interface H_MyTeamHeadView ()

@property (nonatomic, weak) UILabel *huiyuanmingLab;

@property (nonatomic, weak) UILabel *jibieLab;

@property (nonatomic, weak) UILabel *renshuLab;

@property (nonatomic, weak) UILabel *shouyiLab;

@end

@implementation H_MyTeamHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = FSB_ViewBGCOLOR;
        
        CGFloat margin = 1;
        
        CGFloat onex = 0;
        
        CGFloat oney = 0;
        
        CGFloat onew = (_WindowViewWidth - margin) * 0.5;
        
        CGFloat oneh = 80;
        
        H_MyTeamCountView *view1 = [[H_MyTeamCountView alloc] initWithFrame:CGRectMake(onex, oney, onew, oneh)];
        
        self.oneView = view1;
        
        view1.titleLab.text = @"全部推荐(人数)";
        
        [self addSubview:view1];
        
        UIButton *onebtn = [[UIButton alloc] initWithFrame:CGRectMake(onex, oney, onew, oneh)];
        
        [onebtn addTarget:self action:@selector(oneClick) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:onebtn];
        
        CGFloat twox = CGRectGetMaxX(view1.frame) + margin;
        
        CGFloat twoY = oney;
        
        CGFloat twoW = onew;
        
        CGFloat twoh = oneh;
        
        H_MyTeamCountView *view2 = [[H_MyTeamCountView alloc] initWithFrame:CGRectMake(twox, twoY, twoW, twoh)];
        
        self.twoView = view2;
        
        view2.titleLab.text = @"直接推荐(人数)";
        
        [self addSubview:view2];
        
        UIButton *twobtn = [[UIButton alloc] initWithFrame:CGRectMake(twox, twoY, twoW, twoh)];
        
        [twobtn addTarget:self action:@selector(twoClick) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:twobtn];
        
        CGFloat threex = onex;
        
        CGFloat threey = CGRectGetMaxY(view1.frame) + margin;
        
        CGFloat threeW = onew;
        
        CGFloat threeh = oneh;
        
        H_MyTeamCountView *view3 = [[H_MyTeamCountView alloc] initWithFrame:CGRectMake(threex, threey, threeW, threeh)];
        
        self.threeView = view3;
        
        view3.titleLab.text = @"间接推荐(人数)";
        
        [self addSubview:view3];
        
        UIButton *threebtn = [[UIButton alloc] initWithFrame:CGRectMake(threex, threey, threeW, threeh)];
        
        [threebtn addTarget:self action:@selector(threeClick) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:threebtn];
        
        CGFloat fourx = twox;
        
        CGFloat foury = threey;
        
        CGFloat fourw = onew;
        
        CGFloat fourh = oneh;
        
        H_MyTeamCountView *view4 = [[H_MyTeamCountView alloc] initWithFrame:CGRectMake(fourx, foury, fourw, fourh)];
        
        self.fourView = view4;
        
        view4.titleLab.text = @"三级推荐(人数)";
        
        [self addSubview:view4];
        
        UIButton *fourbtn = [[UIButton alloc] initWithFrame:CGRectMake(fourx, foury, fourw, fourh)];
        
        [fourbtn addTarget:self action:@selector(fourClick) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:fourbtn];
        
        CGFloat Width = _WindowViewWidth * 0.25;
        
        CGFloat nameX = 0;
        
        CGFloat nameY = CGRectGetMaxY(view4.frame);
        
        CGFloat nameW = Width;
        
        CGFloat nameH = 50;
        
        UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(nameX, nameY, nameW, nameH)];
        
        self.huiyuanmingLab = name;
        
        name.textColor = [UIColor whiteColor];
        
        name.backgroundColor = FSB_StyleCOLOR;
        
        name.textAlignment = NSTextAlignmentCenter;
        
        name.font = [UIFont systemFontOfSize:17];
        
        name.text = @"会员名";
        
        [self addSubview:name];
        
        CGFloat jibieX = CGRectGetMaxX(name.frame);
        
        UILabel *level = [[UILabel alloc] initWithFrame:CGRectMake(jibieX, nameY, nameW, nameH)];
        
        self.jibieLab = level;
        
        level.text = @"代理级别";
        
        level.textColor = [UIColor whiteColor];
        
        level.backgroundColor = FSB_StyleCOLOR;
        
        level.textAlignment = NSTextAlignmentCenter;
        
        level.font = [UIFont systemFontOfSize:17];
        
        [self addSubview:level];
        
        CGFloat renshuX = CGRectGetMaxX(level.frame);
        
        UILabel *delegate = [[UILabel alloc] initWithFrame:CGRectMake(renshuX, nameY, nameW, nameH)];
        
        self.renshuLab = delegate;
        
        delegate.text = @"代理人数";
        
        delegate.textColor = [UIColor whiteColor];
        
        delegate.backgroundColor = FSB_StyleCOLOR;
        
        delegate.textAlignment = NSTextAlignmentCenter;
        
        delegate.font = [UIFont systemFontOfSize:17];
        
        [self addSubview:delegate];
        
        CGFloat shouyiX = CGRectGetMaxX(delegate.frame);
        
        UILabel *member = [[UILabel alloc] initWithFrame:CGRectMake(shouyiX, nameY, nameW, nameH)];
        
        self.shouyiLab = member;
        
        member.text = @"总收益";
        
        member.textColor = [UIColor whiteColor];
        
        member.backgroundColor = FSB_StyleCOLOR;
        
        member.textAlignment = NSTextAlignmentCenter;
        
        member.font = [UIFont systemFontOfSize:17];
        
        [self addSubview:member];
        
        self.height = CGRectGetMaxY(member.frame);
        
    }
    
    return self;
    
}

- (void)oneClick {
    
    if (self.oneBlock) {
        
        self.oneBlock();
        
    }
    
}

- (void)twoClick {
    
    if (self.twoBlock) {
        
        self.twoBlock();
        
    }
    
}

- (void)threeClick {
    
    if (self.threeBlock) {
        
        self.threeBlock();
        
    }
    
}

- (void)fourClick {
    
    if (self.fourBlock) {
        
        self.fourBlock();
        
    }
    
}

@end
