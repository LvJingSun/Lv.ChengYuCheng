//
//  CustomRuleView.m
//  HuiHui
//
//  Created by mac on 15-7-31.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "CustomRuleView.h"

#import "AppDelegate.h"

#import "CustomButton.h"


@implementation CustomRuleView

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
        
        m_label = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, WindowSizeWidth - 20, 26)];
        m_label.backgroundColor = [UIColor colorWithRed:243/255.0 green:248/255.0 blue:252/255.0 alpha:1.0];
        m_label.font = [UIFont systemFontOfSize:16.0f];
        m_label.textColor = [UIColor blackColor];
        
        
        
        m_view = [[UIView alloc]initWithFrame:CGRectMake(10, 30, WindowSizeWidth - 20, 110)];
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

- (void)setArray:(NSMutableArray *)array withDic:(NSDictionary *)dic withIndex:(int)index{
    
    if ( self.m_catogoryList.count != 0 ) {
        
        [self.m_catogoryList removeAllObjects];
    }
    
    NSLog(@"array = %@,dic = %@",array,dic);
    
    [self.m_catogoryList addObjectsFromArray:array];
    
    self.backgroundColor = [UIColor clearColor];
    
    m_label.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"AttributeName"]];
    
    m_label.tag = index;
    
    self.m_code = [NSString stringWithFormat:@"%@",[dic objectForKey:@"AttributeID"]];
    
    int width = (WindowSizeWidth - 40)/3;
    
    // 循环添加按钮
    for (int i = 0; i < self.m_catogoryList.count; i ++) {
        
        NSDictionary *l_dic = [self.m_catogoryList objectAtIndex:i];
       
        CustomButton *btn = [CustomButton buttonWithType:UIButtonTypeCustom];
        btn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        btn.isSelected = NO;
        btn.frame = CGRectMake(i % 3 * (width + 10),  i / 3 * 40, width, 30);
        [btn setTitle:[l_dic objectForKey:@"Value"] forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor clearColor];
        
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"bd_14.png"] forState:UIControlStateNormal];
        
        btn.tag = [[l_dic objectForKey:@"ValueID"] intValue];
        [btn addTarget:self action:@selector(customClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        m_view.backgroundColor = [UIColor clearColor];
        
        [m_view addSubview:btn];
        
        
        
        
    }
    
    int count = [self.m_catogoryList count] % 3 == 0 ? [self.m_catogoryList count] / 3 : [self.m_catogoryList count] / 3 + 1;
    
    m_view.frame = CGRectMake(5, 30, WindowSizeWidth - 10, count * 40);
    
  
}

- (void)customClicked:(id)sender{
    
    CustomButton *l_btn = (CustomButton *)sender;
 
    for (id object in m_view.subviews) {
        
        if ( [object isKindOfClass:[CustomButton class]] ) {
            
            CustomButton *btn = (CustomButton *)object;
            
            if ( btn.tag == l_btn.tag ) {
                
                if ( btn.isSelected ) {
                    
                    btn.isSelected = NO;
                    
                    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                    [btn setBackgroundImage:[UIImage imageNamed:@"bd_14.png"] forState:UIControlStateNormal];
                    
                    [Appdelegate.m_customRulesDic setObject:@"" forKey:[NSString stringWithFormat:@"%@",m_label.text]];
                    
                   
                    [Appdelegate.m_customNameDic setObject:@"" forKey:[NSString stringWithFormat:@"%@",m_label.text]];

                    
                }else{
                    
                    btn.isSelected = YES;
                    
                    [btn setTitleColor:[UIColor colorWithRed:72/255.f green:162/255.f blue:245/255.f alpha:1.0] forState:UIControlStateNormal];
                    [btn setBackgroundImage:[UIImage imageNamed:@"bd_13.png"] forState:UIControlStateNormal];
                    
                    [Appdelegate.m_customRulesDic setObject:[NSString stringWithFormat:@"%i",l_btn.tag] forKey:[NSString stringWithFormat:@"%@",m_label.text]];

                    
                    
                    [Appdelegate.m_customNameDic setObject:[NSString stringWithFormat:@"%@",l_btn.titleLabel.text] forKey:[NSString stringWithFormat:@"%@",m_label.text]];

                    

                }
                

                
            }else{
                
                btn.isSelected = NO;

                [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                [btn setBackgroundImage:[UIImage imageNamed:@"bd_14.png"] forState:UIControlStateNormal];
                
            }
            
        }
        
    }

    
}


@end
