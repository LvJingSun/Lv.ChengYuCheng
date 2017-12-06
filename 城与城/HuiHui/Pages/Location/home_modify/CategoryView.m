//
//  CategoryView.m
//  HuiHui
//
//  Created by mac on 14-7-29.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import "CategoryView.h"

@implementation CategoryView

@synthesize m_catogoryList;

@synthesize m_label;

@synthesize m_view;

@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        m_catogoryList = [[NSMutableArray alloc]initWithCapacity:0];
        
    }
    
    return self;
}

- (id)init{
    
    self = [super init];
    
    if ( self ) {
        
        m_catogoryList = [[NSMutableArray alloc]initWithCapacity:0];
        
        m_label = [[UILabel alloc]initWithFrame:CGRectMake(5, 0, WindowSizeWidth - 10, 26)];
        m_label.backgroundColor = [UIColor colorWithRed:243/255.0 green:248/255.0 blue:252/255.0 alpha:1.0];
        m_label.font = [UIFont systemFontOfSize:14.0f];
        m_label.textColor = [UIColor blackColor];

        
        
        m_view = [[UIView alloc]initWithFrame:CGRectMake(5, 30, WindowSizeWidth - 10, 110)];
        m_view.backgroundColor = [UIColor clearColor];
       
        [self addSubview:m_label];
        
        [self addSubview:m_view];
        
    }
    
    return self;
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)setArray:(NSMutableArray *)array withDic:(NSDictionary *)dic{
    
    if ( self.m_catogoryList.count != 0 ) {
        
        [self.m_catogoryList removeAllObjects];
    }
    
    NSDictionary *all = [NSDictionary dictionaryWithObjectsAndKeys:@"全部", @"name", @"-1", @"code", nil];

    [self.m_catogoryList addObject:all];
    
    [self.m_catogoryList addObjectsFromArray:array];
    
    self.backgroundColor = [UIColor whiteColor];
    
    m_label.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]];
    
    self.m_code = [NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
    
    int width = (WindowSizeWidth - 40)/4;
  
    // 循环添加按钮
    for (int i = 0; i < self.m_catogoryList.count; i ++) {
        
        NSDictionary *l_dic = [self.m_catogoryList objectAtIndex:i];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.titleLabel.font = [UIFont systemFontOfSize:14.0f];

        btn.frame = CGRectMake(i % 4 * (width + 10),  i / 4 * 40, width, 30);
        [btn setTitle:[l_dic objectForKey:@"name"] forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor clearColor];
        
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"bd_14.png"] forState:UIControlStateNormal];
        
        btn.tag = [[l_dic objectForKey:@"code"] intValue];
        [btn addTarget:self action:@selector(categoryClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        m_view.backgroundColor = [UIColor clearColor];
        
        [m_view addSubview:btn];
        
    }
    
    int count = [self.m_catogoryList count] % 4 == 0 ? [self.m_catogoryList count] / 4 : [self.m_catogoryList count] / 4 + 1;
    
    m_view.frame = CGRectMake(5, 30, WindowSizeWidth - 10, count * 40);
    
}

- (void)categoryClicked:(id)sender{
    
    UIButton *btn = (UIButton *)sender;
    
    NSString *string = @"";
    
    if ( btn.tag == - 1 ) {
        
        string = [NSString stringWithFormat:@"%@",self.m_label.text];
        
    }else{
        
        string = [NSString stringWithFormat:@"%@",btn.titleLabel.text];

    }
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:self.m_code,@"codeKey",[NSString stringWithFormat:@"%i",btn.tag],@"classKey",string,@"titleKey", nil];
    
    if ( delegate && [delegate respondsToSelector:@selector(getCategoryClassId:)] ) {
        
        [delegate performSelector:@selector(getCategoryClassId:) withObject:dic];
    }
    
}


@end
