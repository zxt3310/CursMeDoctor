//
//  doctorModel.h
//  masonryExample
//
//  Created by zhangxintao on 2019/8/8.
//  Copyright © 2019 zhangxintao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface doctorModel : NSObject <YYModel>
@property NSInteger Id;
@property NSInteger did;
@property NSInteger depart1;
@property NSInteger depart2;
@property NSInteger city1;
@property NSInteger city2;
@property float price;
@property NSInteger open_time;
@property NSInteger close_time;
@property NSInteger status;
@property NSString *dateadd;
@property NSString *name;
@property NSString *title;
@property NSString *intro;
@property NSString *pic;
@property NSString *hosp_name;
@property NSInteger hospital_id;
@end

NS_ASSUME_NONNULL_END
