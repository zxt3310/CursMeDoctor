//
//  DoctorCell.h
//  masonryExample
//
//  Created by zhangxintao on 2019/8/8.
//  Copyright © 2019 zhangxintao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BEMCheckBox.h"
#import "doctorModel.h"

NS_ASSUME_NONNULL_BEGIN
@class DoctorCell;
@protocol docChooseDelegate <NSObject>

@optional

- (void)cell:(DoctorCell *)cell DidTapCheck:(BEMCheckBox *)check WithDoctor:(doctorModel *)doctor;
@end

@interface DoctorCell : UITableViewCell <ImageDownloadHelperDelegate>
@property BEMCheckBox *check;

@property (weak) id<docChooseDelegate> docDelegate;

@property (nonatomic) doctorModel *doctor;
@end

NS_ASSUME_NONNULL_END
