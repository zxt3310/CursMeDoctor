//
//  chooseDoctorViewController.h
//  masonryExample
//
//  Created by zhangxintao on 2019/8/8.
//  Copyright © 2019 zhangxintao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DoctorCell.h"
#import "CustomBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@protocol docPaymentDelegate <NSObject>

@optional

- (void) noDoctorBackToChat:(NSDictionary*) json;

@end

@interface chooseDoctorViewController : CustomBaseViewController
@property (weak) id<docPaymentDelegate> backDelegate;
@property NSDictionary *jsonData;
@property NSInteger officeId;
@property NSInteger subOfficeId;

@end

NS_ASSUME_NONNULL_END
