//
//  HH_EditTopicViewController.m
//  HuiHui
//
//  Created by mac on 14-10-28.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import "HH_EditTopicViewController.h"

@interface HH_EditTopicViewController ()

@end

@implementation HH_EditTopicViewController

@synthesize m_stringType;

@synthesize delegate;

@synthesize m_FieldString;

@synthesize m_ViewString;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setTitle:self.m_stringType];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    [self setRightButtonWithTitle:@"保存" action:@selector(saveString)];
    
    // 判断来自于哪个页面
    if ( [self.m_stringType isEqualToString:@"修改活动主题"] ) {
        
        self.m_topicView.hidden = NO;
        
        self.m_detailView.hidden = YES;
        
    }else{
        
        self.m_topicView.hidden = YES;
        
        self.m_detailView.hidden = NO;
    }
    
    // 设置view的边框
    self.m_topicView.layer.borderWidth = 1.0;
    self.m_topicView.layer.borderColor = [UIColor colorWithRed:209/255.0 green:209/255.0 blue:208/255.0 alpha:1.0].CGColor;
    
    self.m_detailView.layer.borderWidth = 1.0;
    self.m_detailView.layer.borderColor = [UIColor colorWithRed:209/255.0 green:209/255.0 blue:208/255.0 alpha:1.0].CGColor;
    
    
    // 赋值
    self.m_textField.text = [NSString stringWithFormat:@"%@",self.m_FieldString];
    
    self.m_textView.text = [NSString stringWithFormat:@"%@",self.m_ViewString];
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self hideTabBar:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    [self hideTabBar:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)leftClicked{
    
    [self goBack];
}

- (void)saveString{
    
    if ( delegate && [delegate respondsToSelector:@selector(editPartyTopicAndDetail:withType:)] ) {
        
        if ( [self.m_stringType isEqualToString:@"修改活动主题"] ) {
            
            [self.delegate editPartyTopicAndDetail:@"1" withType:@"1"];

        }else{
            
            [self.delegate editPartyTopicAndDetail:@"2" withType:@"2"];
        }
       
        
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    [self hiddenNumPadDone:nil];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    return YES;
}

#pragma mark - UITextViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView{
    
    [self hiddenNumPadDone:nil];
}

@end
