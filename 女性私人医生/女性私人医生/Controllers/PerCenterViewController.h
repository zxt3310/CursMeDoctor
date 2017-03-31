//
//  PerCenterViewController.h
//  CureMe
//
//  Created by Tim on 12-8-16.
//  Copyright (c) 2012年 Tim. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTableBaseViewController.h"
#import "CMStringEditCell.h"

@class PerCenterLoginCell;
@class CMQAViewController;

@interface PerCenterViewController : CustomTableBaseViewController

{
    CMQAViewController *questionViewController;
    bool hasShownLoginViewController;
}

- (IBAction)back:(id)sender;

- (void)login;
- (void)regist;
- (bool)logOff;

@end
