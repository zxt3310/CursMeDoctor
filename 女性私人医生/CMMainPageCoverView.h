//
//  CMMainPageCoverView.h
//  女性私人医生
//
//  Created by Zxt on 2020/6/19.
//  Copyright © 2020 Tim. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol PageADCoverDelegate <NSObject>

@optional

-(void)adCoverView:(UIView *) view didTapDepartStart:(NSInteger) departId;

@end

@interface CMMainPageCoverView : UIView

@property (weak) id <PageADCoverDelegate> adDelegate;

- (instancetype)initWithImgUrl:(NSString *)str;
@end

NS_ASSUME_NONNULL_END
