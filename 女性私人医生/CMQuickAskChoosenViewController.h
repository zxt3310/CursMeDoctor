//
//  CMQuickAskChoosenViewController.h
//  女性私人医生
//
//  Created by 张信涛 on 2017/4/10.
//  Copyright © 2017年 Tim. All rights reserved.
//

#import "CustomBaseViewController.h"
#import "CMNewQueryViewController.h"
#import "CMQAProtocolView.h"

@protocol CMQuickAskLocationDeletage <NSObject>

@optional
- (void)chooseOfficeToQuery;

@end

@interface CMQuickAskChoosenAndLocationViewController : CustomBaseViewController <UITableViewDelegate,UITableViewDataSource>
@property  BOOL isQuickAskView;
@property id <CMQuickAskLocationDeletage> CmLocationDelegate;

@property (nonatomic, copy) NSString *currentLocation;
@end
