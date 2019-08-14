//
//  chooseDoctorViewController.m
//  masonryExample
//
//  Created by zhangxintao on 2019/8/8.
//  Copyright © 2019 zhangxintao. All rights reserved.
//

#import "chooseDoctorViewController.h"
#import "docPaymentPage.h"
#import "Masonry.h"

@interface chooseDoctorViewController ()<UITableViewDelegate,UITableViewDataSource,docChooseDelegate>
{
    BEMCheckBox *curOnCheck;
    NSInteger curSelect;
    UITableView *docTable;
    doctorModel *doctor;
    
    UIButton *btn;
    NSArray *doctorAry;
}
@end

@implementation chooseDoctorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    curSelect = -1;
    
    self.title = @"选择医生";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *tipView = [[UIView alloc] init];
    [self.view addSubview:tipView];
    
    [tipView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(self.view.mas_top);
        make.left.equalTo(self.view.mas_left).offset(20); //左边距20
        make.right.equalTo(self.view.mas_right).offset(-20);
        make.height.mas_equalTo(70);
    }];
    
    UIView *lineL = [[UIView alloc] init];
    lineL.backgroundColor = [UIColor grayColor];
    [tipView addSubview:lineL];
    
    UIView *lineR = [[UIView alloc] init];
    lineR.backgroundColor = [UIColor grayColor];
    [tipView addSubview:lineR];
    
    UILabel *tipLb = [[UILabel alloc] init];
    tipLb.numberOfLines = 0;
    tipLb.font = [UIFont systemFontOfSize:14];
    tipLb.textAlignment = NSTextAlignmentCenter;
    tipLb.text = @"暂时没有医院响应，您可以选择系统推荐的专科医生付费咨询";
    [tipView addSubview:tipLb];
    
    [lineL mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerY.equalTo(tipView);
        make.left.equalTo(tipView.mas_left).offset(0);
        make.right.equalTo(tipLb.mas_left).offset(-10);
        make.height.mas_equalTo(1);
    }];
    
    [lineR mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerY.equalTo(tipView);
        make.right.equalTo(tipView.mas_right).offset(0);
        make.left.equalTo(tipLb.mas_right).offset(10);
        make.height.mas_equalTo(1);
    }];
    
    [tipLb mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerY.equalTo(tipView);
        make.centerX.equalTo(tipView);
        make.width.equalTo(tipView).multipliedBy(0.6);
    }];
    
    btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundColor:[UIColor lightGrayColor]];
    [btn setTitle:@"请选择医生" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:16];
    [btn addTarget:self action:@selector(prepareToPay) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(self.view).offset(0);
        make.bottom.equalTo(self.view).offset(0);
        make.width.equalTo(self.view);
        make.height.mas_equalTo(50);
    }];
    
    docTable = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    docTable.delegate = self;
    docTable.dataSource = self;
    docTable.tableFooterView = [UIView new];
    docTable.rowHeight = UITableViewAutomaticDimension;
    docTable.estimatedRowHeight = 100;
    [self.view addSubview:docTable];
    
    [docTable mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(self.view).offset(0);
        make.right.equalTo(self.view).offset(0);
        make.top.equalTo(tipView.mas_bottom).offset(0);
        make.bottom.equalTo(self->btn.mas_top).offset(0);
    }];
    
    [self getDoctorList];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return doctorAry.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *endifier = @"cell";
    DoctorCell *cell = [tableView dequeueReusableCellWithIdentifier:endifier];
    if (!cell) {
        cell = [[DoctorCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:endifier];
        cell.docDelegate = self;
    }
    
    cell.doctor = doctorAry[indexPath.item];
    
    if (curSelect == indexPath.item) {
        [cell.check setOn:YES];
    }else{
        [cell.check setOn:NO];
    }
    return cell;
}

- (void)cell:(DoctorCell *)cell DidTapCheck:(BEMCheckBox *)check WithDoctor:(nonnull doctorModel *)doctor{
    if (check.on) {
        curSelect = [docTable indexPathForCell:cell].item;
        if (curOnCheck) {
            [curOnCheck setOn:NO animated:YES];
        }
        curOnCheck = check;
        [btn setTitle:[NSString stringWithFormat:@"付费咨询(%0.2f)元",doctor.price] forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor colorWithRed:246.0/255.0 green:83.0/255.0 blue:120.0/255.0 alpha:1]];
    }else{
        curSelect = -1;
        curOnCheck = nil;
        [btn setTitle:@"请选择医生" forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor lightGrayColor]];
        return;
    }
}

- (void)prepareToPay{
    if (curSelect == -1) {
        return;
    }
    docPaymentPage *payVC = [[docPaymentPage alloc] init];
    payVC.doctor = doctorAry[curSelect];
    [self.navigationController pushViewController:payVC animated:YES];
}

- (void)getDoctorList{
    NSString *urlStr = [NSString stringWithFormat:@"http://new.medapp.ranknowcn.com/h5_new/invite_doctor/doc_list.php?type=%ld&typechild=%ld&cityid=%ld&city2id=%ld&appid=1&source=apple",(long)self.officeId,(long)self.subOfficeId,(long)[CureMeUtils defaultCureMeUtil].cityCode,(long)[CureMeUtils defaultCureMeUtil].userCity];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData *response = sendRequestWithFullURL(urlStr, nil);
        dispatch_async(dispatch_get_main_queue(),^{
            NSDictionary *returnDic = parseJsonResponse(response);
            if (!response || !returnDic) {
                NSLog(@"fail to load doctor list");
                return ;
            }
            NSInteger result = [[returnDic objectForKey:@"err"] integerValue];
            if (result != 0) {
                NSLog(@"fail to load doctor list");
                return ;
            }
            
            NSDictionary *dataDic = [returnDic objectForKey:@"data"];
            NSArray *docAry = [NSArray yy_modelArrayWithClass:[doctorModel class] json:dataDic];
            if (docAry.count > 0) {
                doctorAry = docAry;
                [docTable reloadData];
            }
        });
    });
}

- (IBAction)back:(id)sender{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
