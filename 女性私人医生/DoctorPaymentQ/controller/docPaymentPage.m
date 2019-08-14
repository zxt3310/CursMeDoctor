//
//  docPaymentPage.m
//  masonryExample
//
//  Created by zhangxintao on 2019/8/9.
//  Copyright © 2019 zhangxintao. All rights reserved.
//

#import "docPaymentPage.h"
#import "Masonry.h"
#import "BEMCheckBox.h"
#define padding 10.0
@interface docPaymentPage ()<wxBackDelegate,BEMCheckBoxDelegate>
{
    UIImageView *headerImg;
    UILabel *nameLb;
    UILabel *officeLb;
    UILabel *levelLb;
    UILabel *hospitalLb;
    UILabel *skillLb;
    UILabel *priceLb;
    UIButton *btn;
}
@end

@implementation docPaymentPage


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"支付确认";
    self.view.backgroundColor = [UIColor whiteColor];
    [WeixinBackTools sharedInstance].wxBackDelegate = self;
    
    UIView *payInfoView = [[UIView alloc] init];
    [self.view addSubview:payInfoView];
    
    [payInfoView mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(self.view).offset(padding);
        make.right.equalTo(self.view).offset(-padding);
        make.top.equalTo(self.view).offset(padding);
        make.height.mas_equalTo(80);
    }];
    
    UILabel *payLb = [[UILabel alloc] init];
    payLb.font = [UIFont systemFontOfSize:14];
    payLb.text = @"支付金额";
    [payInfoView addSubview:payLb];
    
    [payLb mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(payInfoView);
        make.left.equalTo(payInfoView);
    }];
    
    priceLb = [[UILabel alloc] init];
    priceLb.text = [NSString stringWithFormat:@"￥%0.2f",self.doctor.price];
    priceLb.font = [UIFont systemFontOfSize:18];
    priceLb.textColor = [UIColor redColor];
    [payInfoView addSubview:priceLb];
    
    [priceLb mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerX.equalTo(payInfoView);
        make.centerY.equalTo(payInfoView);
    }];
    
    UIView *line1 = [[UIView alloc] init];
    line1.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:line1];
    
    [line1 mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(payInfoView.mas_bottom).offset(padding);
        make.height.mas_equalTo(1);
    }];
    
    UIView *docView = [[UIView alloc] init];
    [self.view addSubview:docView];
    
    [docView mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(self.view).offset(padding);
        make.right.equalTo(self.view).offset(-padding);
        make.top.equalTo(payInfoView.mas_bottom).offset(padding);
    }];
    
    UILabel *docTitle = [[UILabel alloc] init];
    docTitle.text = @"购买服务-付费咨询";
    docTitle.font = [UIFont systemFontOfSize:16];
    [docView addSubview:docTitle];
    
    [docTitle mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(docView);
        make.top.equalTo(docView).offset(padding);
    }];
    
    headerImg = [[UIImageView alloc] init];
    headerImg.backgroundColor = [UIColor lightGrayColor];
    headerImg.layer.cornerRadius = 35;
    headerImg.clipsToBounds = YES;
    headerImg.image = [[CureMeUtils defaultCureMeUtil] getImageByKey:self.doctor.pic andSize:@"150"];
    [docView addSubview:headerImg];
    [headerImg mas_makeConstraints:^(MASConstraintMaker *make){
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(70);
        make.left.equalTo(docView.mas_left).offset(0);
        make.top.equalTo(docTitle.mas_bottom).offset(padding * 2);
    }];
    
    UIView *infoView = [[UIView alloc] init];
    [docView addSubview:infoView];
    [infoView mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(self->headerImg.mas_right).offset(10);
        make.top.equalTo(self->headerImg.mas_top).offset(0);
        make.right.equalTo(docView.mas_right).offset(0);
        make.bottom.equalTo(docView.mas_bottom).offset(0);
    }];
    
    nameLb = [[UILabel alloc] init];
    nameLb.font = [UIFont systemFontOfSize:16];
    nameLb.text = self.doctor.name;
    [infoView addSubview:nameLb];
    
    [nameLb mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(infoView.mas_left).offset(0);
        make.top.equalTo(infoView.mas_top).offset(0);
    }];
    
    officeLb = [[UILabel alloc] init];
    officeLb.font = [UIFont systemFontOfSize:14];
//    officeLb.text = self.doctor.title;
    [infoView addSubview:officeLb];
    [officeLb mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(self->nameLb.mas_right).offset(20);
        make.centerY.equalTo(self->nameLb);
    }];
    
    levelLb = [[UILabel alloc] init];
    levelLb.font = [UIFont systemFontOfSize:14];
    levelLb.text = self.doctor.title;
    [infoView addSubview:levelLb];
    
    [levelLb mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(self->officeLb.mas_right).offset(20);
        make.centerY.equalTo(self->nameLb);
    }];
    
    hospitalLb = [[UILabel alloc] init];
    hospitalLb.font = [UIFont systemFontOfSize:14];
    hospitalLb.text = self.doctor.hosp_name;
    [infoView addSubview:hospitalLb];
    
    [hospitalLb mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(infoView.mas_left);
        make.top.equalTo(self->nameLb.mas_bottom).offset(10);
    }];
    
    skillLb = [[UILabel alloc] init];
    skillLb.font = [UIFont systemFontOfSize:14];
    skillLb.numberOfLines = 2;
    skillLb.text = self.doctor.intro;
    [infoView addSubview:skillLb];
    
    [skillLb mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(infoView.mas_left);
        make.right.equalTo(infoView.mas_right).offset(10);
        make.top.equalTo(self->hospitalLb.mas_bottom).offset(10);
        make.bottom.equalTo(infoView).offset(-10);
    }];
    
    UIView *line2 = [[UIView alloc] init];
    line2.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:line2];
    
    [line2 mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(docView.mas_bottom).offset(padding);
        make.height.mas_equalTo(1);
    }];
    
    btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundColor:[UIColor colorWithRed:246.0/255.0 green:83.0/255.0 blue:120.0/255.0 alpha:1]];
    [btn setTitle:@"去支付" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:16];
    [btn addTarget:self action:@selector(goToPay) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(self.view).offset(0);
        make.bottom.equalTo(self.view).offset(0);
        make.width.equalTo(self.view);
        make.height.mas_equalTo(50);
    }];
    
    UIView *payView = [[UIView alloc] init];
    [self.view addSubview:payView];
    
    [payView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(line2).offset(padding);
        make.left.equalTo(self.view).offset(padding);
        make.right.equalTo(self.view).offset(-padding);
        make.bottom.equalTo(btn.mas_top).offset(-padding);
    }];
    
    UILabel *payTitleLb = [[UILabel alloc] init];
    payTitleLb.text = @"支付方式";
    payTitleLb.font = [UIFont systemFontOfSize:16];
    [payView addSubview:payTitleLb];
    
    [payTitleLb mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(payView);
        make.top.equalTo(payView);
    }];
    
    BEMCheckBox *check = [[BEMCheckBox alloc] init];
    check.onFillColor = [UIColor colorWithRed:28.0/255.0 green:113.0/255.0 blue:61.0/255.0 alpha:1];
    check.onTintColor = [UIColor colorWithRed:28.0/255.0 green:113.0/255.0 blue:61.0/255.0 alpha:1];
    check.onCheckColor = [UIColor whiteColor];
    check.boxType = BEMBoxTypeSquare;
    check.onAnimationType = BEMAnimationTypeFill;
    check.offAnimationType = BEMAnimationTypeFill;
    check.delegate = self;
    [check setOn:YES];
    [payView addSubview:check];
    
    [check mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(payView).offset(padding *2);
        make.top.equalTo(payTitleLb.mas_bottom).offset(padding*2);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(20);
    }];
    
    UIImageView *wechat = [[UIImageView alloc] init];
    wechat.image = [UIImage imageNamed:@"wechat"];
    [payView addSubview:wechat];
    
    [wechat mas_makeConstraints:^(MASConstraintMaker *make){
        make.width.mas_equalTo(35);
        make.height.mas_equalTo(35);
        make.left.equalTo(check.mas_right).offset(3*padding);
        make.centerY.equalTo(check);
    }];
    
    UILabel *wechatLb = [[UILabel alloc] init];
    wechatLb.text = @"微信支付";
    wechatLb.font = [UIFont systemFontOfSize:14];
    [payView addSubview:wechatLb];
    
    [wechatLb mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(wechat.mas_right).offset(15);
        make.centerY.equalTo(wechat);
    }];
    
}

- (void)didTapCheckBox:(BEMCheckBox *)checkBox{
    if (checkBox.on) {
        [btn setTitle:@"去支付" forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor colorWithRed:246.0/255.0 green:83.0/255.0 blue:120.0/255.0 alpha:1]];
        btn.enabled = YES;
    }else{
        [btn setTitle:@"请选择支付方式" forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor lightGrayColor]];
        btn.enabled = NO;
    }
}

- (void)goToPay{
    [WeixinBackTools sharedInstance].wxBackDelegate = self;
    
    NSString *urlStr = [NSString stringWithFormat:@"http://new.medapp.ranknowcn.com/WxpayAPI_v3.0.1/example/wx_pay.php"];
    NSString *post = [NSString stringWithFormat:@"paymentid=&total_fee=%0f&username=%@&userid=%ld&departType=%ld&hospital_id=%ld&doctor_id=%ld",self.doctor.price*100,[CureMeUtils defaultCureMeUtil].userName,(long)[CureMeUtils defaultCureMeUtil].userID,(long)self.doctor.depart1,(long)self.doctor.hospital_id,(long)self.doctor.did];
   
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData *response = sendRequestWithFullURL(urlStr, post);
        dispatch_async(dispatch_get_main_queue(), ^{
            if (!response) {
                NSLog(@"fail to pay 获取支付信息失败");
                return;
            }
            NSDictionary *returnDic = parseJsonResponse(response);
            if (!returnDic) {
                NSLog(@"fail to pay 获取支付信息失败");
                return;
            }
            
            if ([[returnDic objectForKey:@"res"] integerValue] == 0) {
                returnDic = [returnDic objectForKey:@"data"];
                PayReq *req = [[PayReq alloc] init];
                req.partnerId = [returnDic objectForKey:@"partnerid"];
                req.prepayId = [returnDic objectForKey:@"prepayid"];
                req.package = [returnDic objectForKey:@"package"];
                req.nonceStr = [returnDic objectForKey:@"noncestr"];
                req.timeStamp = [[returnDic objectForKey:@"timestamp"] intValue];
                req.sign = [returnDic objectForKey:@"sign"];
                
                [WXApi sendReq:req];
            }else if([[returnDic objectForKey:@"res"] integerValue] == 1){
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"您已支付过此项目" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *back = [UIAlertAction actionWithTitle:@"返回咨询" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
                    NSArray *aryVC = self.navigationController.viewControllers;
                    for (int i=0; i<aryVC.count; i++) {
                        id vc = aryVC[i];
                        if ([[vc class] isEqual:NSClassFromString(@"CMNewQueryViewController")]) {
                            [self.navigationController popToViewController:vc animated:YES];
                            [[NSNotificationCenter defaultCenter] postNotificationName:NTF_PAYBACK_CHAT object:self.doctor];
                            break;
                        }
                    }
                }];
                
                [alert addAction:back];
                [self presentViewController:alert animated:YES completion:nil];
            }
        });
    });
}

- (void)receivePayResp:(PayResp *)resp{
    if (resp.errCode !=0) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"支付失败" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:cancle];
        [self presentViewController:alert animated:YES completion:nil];
    }else{
        NSArray *aryVC = self.navigationController.viewControllers;
        for (int i=0; i<aryVC.count; i++) {
            id vc = aryVC[i];
            if ([[vc class] isEqual:NSClassFromString(@"CMNewQueryViewController")]) {
                [self.navigationController popToViewController:vc animated:YES];
                [[NSNotificationCenter defaultCenter] postNotificationName:NTF_PAYBACK_CHAT object:self.doctor];
                break;
            }
        }
    }
}
@end
