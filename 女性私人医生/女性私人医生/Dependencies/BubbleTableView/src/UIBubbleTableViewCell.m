//
//  UIBubbleTableViewCell.m
//
//  Created by Alex Barinov
//  StexGroup, LLC
//  http://www.stexgroup.com
//
//  Project home page: http://alexbarinov.github.com/UIBubbleTableView/
//
//  This work is licensed under the Creative Commons Attribution-ShareAlike 3.0 Unported License.
//  To view a copy of this license, visit http://creativecommons.org/licenses/by-sa/3.0/
//


#import "UIBubbleTableViewCell.h"
#import "NSBubbleData.h"
#import <QuartzCore/QuartzCore.h>

#define HEADIMAGE_EDGE 35

@interface UIBubbleTableViewCell ()
- (void) setupInternalData;
@end

@implementation UIBubbleTableViewCell

@synthesize dataInternal = _dataInternal;

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
	[self setupInternalData];
}

- (void) dealloc
{
	_dataInternal = nil;
}


- (void)setDataInternal:(NSBubbleDataInternal *)value
{
	_dataInternal = value;
	[self setupInternalData];
}

- (void) setupInternalData
{
    if (!_dataInternal) {
        return;
    }
    
    switch (_dataInternal.data.cellType) {
        case CellTypeDetail:
            [self setupInternalTextImageData];
            break;
        case CellTypeTelInfo:
            [self setupInternalTelephoneData];
            break;
        case CellTypeBookInfoNew:
            [self setupInternalBookInfoData];
            break;
        case CellTypeMapInfo:
            [self setupInternalMapInfoData];
            break;
        default:
            [self setupInternalTextImageData];
            break;
    }
}

- (void)setupInternalTextImageData
{
//    [headImage setUserInteractionEnabled:YES];
    
    if (self.dataInternal.header)
    {
        headerLabel.hidden = NO;
        headerLabel.text = self.dataInternal.header;
    }
    else
    {
        headerLabel.hidden = YES;
    }
    
    NSBubbleType type = self.dataInternal.data.type;
    
    // +30图片宽度 +2图片与气泡间距
//    float picSize = _dataInternal.data.headImage ? HEADIMAGE_EDGE + 2: 0;
//    float headSize = _dataInternal.data.headImage ? HEADIMAGE_EDGE : 0;
//    float nameHeight = 12;
    float x = (type == BubbleTypeSomeoneElse) ? 20 : self.frame.size.width - 15 - _dataInternal.labelSize.width;
//    float x = (type == BubbleTypeSomeoneElse) ? 20 + picSize : self.frame.size.width - 30 - 5 - picSize - _dataInternal.labelSize.width;
    float y = 10 + (self.dataInternal.header ? 30 : 0);
    
    if (_dataInternal.data.msgImage) {
        [contentLabel setHidden:YES];
        [msgImage setHidden:NO];
        msgImage.frame = CGRectMake(x + 1, y + 2, _dataInternal.labelSize.width, _dataInternal.labelSize.height);
        msgImage.image = _dataInternal.data.msgImage;
    }
    else {
        [contentLabel setHidden:NO];
        [msgImage setHidden:YES];
        contentLabel.font = [UIFont systemFontOfSize:15];
        contentLabel.frame = CGRectMake(x, y, _dataInternal.labelSize.width, _dataInternal.labelSize.height);
        contentLabel.text = self.dataInternal.data.text;
    }
    
    if (type == BubbleTypeSomeoneElse)
    {
//        [[headImage layer] setCornerRadius:3.0];
//        [[headImage layer] setBorderWidth:2.0];
//        [[headImage layer] setBorderColor:[UIColor colorWithRed:249.0/255 green:208.0/255 blue:214.0/255 alpha:1.0].CGColor];
//        [headImage setBackgroundColor:[UIColor clearColor]];
//        [headImage setContentMode:UIViewContentModeScaleAspectFit];
//        [headImage setBackgroundColor:[UIColor whiteColor]];
//        [headImage setHidden:NO];
//        [headImage setClipsToBounds:YES];
        
        bubbleImage.image = [CMImageUtils defaultImageUtil].chatOtherBubbleImage;
        if (_dataInternal.data.msgImage) {
            bubbleImage.frame = CGRectMake(x - 16, y - 5, _dataInternal.labelSize.width + 30, _dataInternal.labelSize.height + 15);
        }
        else {
            bubbleImage.frame = CGRectMake(x - 16, y - 4, _dataInternal.labelSize.width + 30, _dataInternal.labelSize.height + 15);
        }
//        if ([self dataInternal].data.headImage) {
//            headImage.image = _dataInternal.data.headImage;
//            headImage.frame = CGRectMake(2, _dataInternal.height - picSize - nameHeight, headSize, headSize);
//            [doctorNameLabel setHidden:NO];
//            [doctorNameLabel setFont:[UIFont systemFontOfSize:12]];
//            [doctorNameLabel setText:_dataInternal.data.talkerName];
//            [doctorNameLabel setBackgroundColor:[UIColor clearColor]];
//            doctorNameLabel.frame = CGRectMake(2, _dataInternal.height - nameHeight, headSize, nameHeight);
//        }
//        else {
//            [doctorNameLabel setHidden:YES];
//        }
    }
    else {
//        [headImage setHidden:YES];
//        [doctorNameLabel setHidden:YES];
        
        bubbleImage.image = [CMImageUtils defaultImageUtil].chatSelfBubbleImage;
        if (_dataInternal.data.msgImage) {
            bubbleImage.frame = CGRectMake(x - 8, y - 5, _dataInternal.labelSize.width + 30, _dataInternal.labelSize.height + 15);
        }
        else {
            bubbleImage.frame = CGRectMake(x - 15, y - 4, self.dataInternal.labelSize.width + 20, self.dataInternal.labelSize.height + 15);
            
        }
    }
    
    if (_dataInternal.height < MIN_BUBBLECELL_HEIGHT) {
        _dataInternal.height = MIN_BUBBLECELL_HEIGHT;
        CGRect frame = self.contentView.frame;
        if (frame.size.height < MIN_BUBBLECELL_HEIGHT) {
            frame.size.height = MIN_BUBBLECELL_HEIGHT;
        }
        self.contentView.frame = frame;
    }
}

- (void)setupInternalTelephoneData
{
    
}

- (void)setupInternalMapInfoData
{
    
}

- (void)setupInternalBookInfoData
{
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSSet *touchSet = [event allTouches];
    UITouch *touch = [touchSet anyObject];
    
    switch ([touchSet count]) {
        case 1:
            // 如果点击了缩略图
            if ([touch.view isKindOfClass:[UIImageView class]]) {
                UIImageView *imageView = (UIImageView *)touch.view;
                if ([imageView.image isEqual:_dataInternal.data.msgImage]) {
                    // 发送Notification
                    NSDictionary *userInfo = [[NSDictionary alloc] initWithObjectsAndKeys:_dataInternal.data.imageKey, @"imageKey", nil];
                    NSNotification *note = [NSNotification notificationWithName:NTF_ChatMsgThumbnailClick object:self userInfo:userInfo];
                    [[NSNotificationCenter defaultCenter] postNotification:note];
                }
                imageView = nil;
            }
            // 如果点击了头像
            else if ([[touch view] isKindOfClass:[UIImageView class]] &&
                [touch view].frame.size.width == HEADIMAGE_EDGE &&
                [touch view].frame.size.height == HEADIMAGE_EDGE) {
                if (self.dataInternal.data.type == BubbleTypeSomeoneElse) {
                    // 给聊天列表发送Notification，告诉它展开对应的聊天记录
                    NSNotification *note = nil;
                    NSDictionary *dict = [NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:self.dataInternal.data.talkerID] forKey:@"tID"];
                    note = [NSNotification notificationWithName:NTF_TalkHeadImageSelected object:self userInfo:dict];
                    [[NSNotificationCenter defaultCenter] postNotification:note];
                }
            }
            else {
//                if (self.dataInternal.data.cellType == CellTypeList) {
//                    // 如果是聊天记录列表，点击时发送消息通知展开联系人聊天
//                    NSNotification *note = nil;
//                    NSDictionary *dict = [NSDictionary dictionaryWithObject:[NSNumber numberWithInt:self.dataInternal.data.talkerID] forKey:@"tID"];
//                    note = [NSNotification notificationWithName:NTF_BubbleCellSelected object:self userInfo:dict];
//                    [[NSNotificationCenter defaultCenter] postNotification:note];
//                }
                if (self.dataInternal.data.cellType == CellTypeDetail) {
                    // 如果是聊天，点击行为暂时不定义
                }
            }
            break;
            
        default:
            break;
    }
}

@end
