//
//  ModifyNoteViewController.h
//  HuiHui
//
//  Created by 冯海强 on 15-2-4.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "BaseViewController.h"

@protocol ModifyNoteDelegate <NSObject>

- (void)GetSaveRemarkName:(NSString *)RemarkName;

@end

@interface ModifyNoteViewController : BaseViewController
{
     IBOutlet UITextField *Notetextfield;
}

@property (nonatomic, strong) NSString *toMemberId;

@property (nonatomic, strong) NSString *oldNotetext;

@property (nonatomic, assign) id<ModifyNoteDelegate>   delegate;

@end
