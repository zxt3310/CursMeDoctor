//
//  CMMainPageCoverView.m
//  女性私人医生
//
//  Created by Zxt on 2020/6/19.
//  Copyright © 2020 Tim. All rights reserved.
//

#import "CMMainPageCoverView.h"

@implementation CMMainPageCoverView
{
    NSString *urlStr;
    UIImageView *imgView;
    float top;
    UIButton *closeBtn;
    UIScrollView *scroll;
}

- (instancetype)initWithImgUrl:(NSString *)str{
    self = [super init];
    if (self) {
        urlStr = str;
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        self.backgroundColor = [UIColor whiteColor];
        top = 64;
        float bottom = 0;
        float chatBtnHeight = 60;
        if (@available(iOS 11.0, *)) {
            top = [UIApplication sharedApplication].keyWindow.safeAreaInsets.top + 44;
            bottom = [UIApplication sharedApplication].keyWindow.safeAreaInsets.bottom;
        }
       UIView *appBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, top)];
       appBar.backgroundColor = UIColorFromHex(0x0168b7,1);
       [self addSubview:appBar];
       UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-100, top-40, 200, 30)];
       title.text = @"详情";
        title.textAlignment = NSTextAlignmentCenter;
       title.font = [UIFont systemFontOfSize:18];
       title.textColor = [UIColor whiteColor];
       [appBar addSubview:title];
       //返回按钮
       closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
       closeBtn.frame = CGRectMake(10, top-45, 40, 40);
       [closeBtn setImage:[CMImageUtils defaultImageUtil].navBackBtnSelected forState:UIControlStateNormal];
       [closeBtn addTarget:self action:@selector(closeImg) forControlEvents:UIControlEventTouchUpInside];
       [appBar addSubview:closeBtn];
       
       scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, top, SCREEN_WIDTH, SCREEN_HEIGHT - bottom - top - chatBtnHeight)];
       [self addSubview:scroll];
       
       imgView = [[UIImageView alloc] initWithFrame:scroll.bounds];
        imgView.contentMode = UIViewContentModeScaleAspectFit;
       [scroll addSubview:imgView];
       
       UIButton *chatBtn = [UIButton buttonWithType:UIButtonTypeCustom];
       chatBtn.frame = CGRectMake(0, SCREEN_HEIGHT - chatBtnHeight, SCREEN_HEIGHT, chatBtnHeight);
       [chatBtn setBackgroundColor:UIColorFromHex(0xf5378,1)];
       [chatBtn setTitle:@"立即咨询" forState:UIControlStateNormal];
       [chatBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
       [chatBtn addTarget:self action:@selector(adTap) forControlEvents:UIControlEventTouchUpInside];
       [chatBtn setTintColor:[UIColor whiteColor]];
       [self addSubview:chatBtn];
       [self loadImage];
    }
    return self;
}
- (void)closeImg{
    [self removeFromSuperview];
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    if (point.x< 50 && point.y < top) {
        return closeBtn;
    }
    return [super hitTest:point withEvent:event];
}

- (void)loadImage{
    dispatch_async(dispatch_get_global_queue(DISPATCH_TARGET_QUEUE_DEFAULT,0), ^{
        UIImage *image = nil;
        image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:urlStr]]];
        dispatch_async(dispatch_get_main_queue(), ^{
            CGSize size = image.size;
            float wid = size.width;
            float hei = size.height;
            float newHeight = hei/wid*SCREEN_WIDTH;
            CGRect tmp = imgView.frame;
            tmp.size.height = newHeight;
            imgView.frame = tmp;
            
            imgView.image = image;
            scroll.contentSize = CGSizeMake(SCREEN_WIDTH, newHeight);
        });
    });
}
- (void)adTap{
    [self.adDelegate adCoverView:self didTapDepartStart:0];
}
@end
