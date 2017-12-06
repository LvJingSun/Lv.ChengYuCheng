//
//  StatusUtility.m
//  HuiHui
//
//  Created by mac on 13-10-11.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//

#import "StatusUtility.h"

#import "CustomNavigationBar.h"

#define isIOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0 ? YES : NO)


@implementation StatusUtility

static StatusUtility  *m_statusUtility;


+(StatusUtility*)currentStatusUtility
{
    if (m_statusUtility == nil) {
        
        m_statusUtility = [[StatusUtility alloc] init];
    }
    return m_statusUtility;
}

- (UINavigationController *)customizedNavigationController{
    
    UINavigationController *navController = [[UINavigationController alloc]initWithNibName:nil bundle:nil];
    
    // Ensure the UINavigationBar is created so that it can be archived. If we do not access the
    // navigation bar then it will not be allocated, and thus, it will not be archived by the
    // NSKeyedArchvier.
    
    [navController navigationBar];
    
    // Archive the navigation controller.
    NSMutableData *data = [NSMutableData data];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:navController forKey:@"root"];
    [archiver finishEncoding];
   
    // Unarchive the navigation controller and ensure that our UINavigationBar subclass is used.
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    [unarchiver setClass:[CustomNavigationBar class] forClassName:@"UINavigationBar"];
    UINavigationController *customizedNavController = [unarchiver decodeObjectForKey:@"root"];
    [unarchiver finishDecoding];
    
    // Modify the navigation bar to have a background image.
    CustomNavigationBar *navBar = (CustomNavigationBar *)[customizedNavController navigationBar];
    
    [navBar setTintColor:[UIColor colorWithRed:1 green:0.95 blue:0.93 alpha:1.0]];
    
//    if ( isIOS7 ) {
//        
//        [navBar setBackgroundImage:[UIImage imageNamed:@"head_bg2.png"] forBarMetrics:UIBarMetricsDefault];
//
//    }else{
//        
//        [navBar setBackgroundImage:[UIImage imageNamed:@"head_bg.png"] forBarMetrics:UIBarMetricsDefault];
//
//    }
    //    [navBar setCusTomBackgroundImage:[UIImage imageNamed:@"nav_bg.png"] forBarMetrics:UIBarMetricsDefault]
    //    [navBar setBackgroundImage:[UIImage imageNamed:@"navigation-bar-bg-landscape.png"] forBarMetrics:UIBarMetricsLandscapePhone];
    
    return customizedNavController;
 
}

@end
