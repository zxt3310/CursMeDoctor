//
//  personalDetailTableViewController.m
//  女性私人医生
//
//  Created by 张信涛 on 2017/4/18.
//  Copyright © 2017年 Tim. All rights reserved.
//

#import "personalDetailTableViewController.h"
#import "ChangePasswordViewController.h"
#import "ChangePhoneNoViewController.h"

@interface personalDetailTableViewController ()

@end

@implementation personalDetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = nil;
    self.title = @"我的账户";
    self.tableView.tableFooterView = [[UITableView alloc] initWithFrame:CGRectZero];
    self.tableView.scrollEnabled = NO;
    
    UIButton *logOutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    logOutBtn.frame = CGRectMake(SCREEN_WIDTH/2 - 100 *SCREEN_WIDTH/375, SCREEN_HEIGHT- 64 - 130 *SCREEN_HEIGHT/667, 200 *SCREEN_WIDTH/375, 50 *SCREEN_HEIGHT/667);
    logOutBtn.backgroundColor = UIColorFromHex(0xf65378, 1);
    [logOutBtn setTitle:@"退出当前帐号" forState:UIControlStateNormal];
    logOutBtn.titleLabel.textColor = [UIColor whiteColor];
    [logOutBtn addTarget:self action:@selector(logOff) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:logOutBtn];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    // 如果已登录，则更新用户信息
    if ([CureMeUtils defaultCureMeUtil].hasLogin) {
        [[CureMeUtils defaultCureMeUtil] updateUserInfo:[CureMeUtils defaultCureMeUtil].userID];
    }
    
    [self.tableView reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 6.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 2) {
        return 0;
    }
    return 60 *SCREEN_HEIGHT/667;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 5;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
   // NSString *StringEditCell = @"EditCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DefaultCell"];
    if (indexPath.section == 0) {
        
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DefaultCell"];
            
            UILabel *userNameLb = [[UILabel alloc] initWithFrame:CGRectMake(190, 20, SCREEN_WIDTH - 220, 20)];
            userNameLb.tag = 1;
            userNameLb.textAlignment = NSTextAlignmentRight;
            [cell.contentView addSubview:userNameLb];
            
            if (indexPath.row == 0) {
                UIImageView *headView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 50 , 10, 40, 40)];
                NSData *imgData = [[NSUserDefaults standardUserDefaults] objectForKey:WX_HEAD];
                if (imgData) {
                    headView.image = [UIImage imageWithData:imgData];
                }
                else{
                    headView.image = [CMImageUtils defaultImageUtil].userHeadImage;
                }
                userNameLb.hidden = YES;
                headView.clipsToBounds = YES;
                headView.layer.cornerRadius = 10;
                [cell.contentView addSubview:headView];
                
                cell.textLabel.text = @"头像";
            }
            else if (indexPath.row == 1){
                userNameLb.text = [CureMeUtils defaultCureMeUtil].userName;
                cell.textLabel.text = @"昵称";
            }
            else if (indexPath.row == 2){
                cell.textLabel.text = @"手机号";
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                userNameLb.hidden = YES;
            }
            else if (indexPath.row == 3){
                cell.textLabel.text = @"密码";
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                userNameLb.text = @"(设置/修改密码)";
                userNameLb.font = [UIFont fontWithName:@"STHeitiSC-Medium" size:14];
                userNameLb.textColor = UIColorFromHex(0x9b9b9b, 1);
            }
            else{
                cell.textLabel.text = @"地区";
                userNameLb.font = [UIFont fontWithName:@"STHeitiSC-Medium" size:14];
                userNameLb.textColor = UIColorFromHex(0x9b9b9b, 1);
                userNameLb.text = [NSString stringWithFormat:@"%@ %@",[[CureMeUtils defaultCureMeUtil] regionWithRegionID:[[[NSUserDefaults standardUserDefaults] objectForKey:USER_REGION] integerValue]],[[NSUserDefaults standardUserDefaults] objectForKey:USER_CITY_NAME]];
            }
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
//    else if (indexPath.section == 1)
//    {
//        CMStringEditCell *strEditCell = nil;
//        
//        if (indexPath.row == 0) {       // 姓名
//            strEditCell = [[CMStringEditCell alloc] initWithEditType:EDITCELL_NAME reuseIdentifier:StringEditCell];
//            return strEditCell;
//        }
//        else if (indexPath.row == 1) {  // 年龄
//            strEditCell = [[CMStringEditCell alloc] initWithEditType:EDITCELL_AGE reuseIdentifier:StringEditCell];
//            return strEditCell;
//        }
//        else if (indexPath.row == 2) {  // 手机
//            strEditCell = [[CMStringEditCell alloc] initWithEditType:EDITCELL_PHONE reuseIdentifier:StringEditCell];
//            strEditCell.userInteractionEnabled = NO;
//            return strEditCell;
//        }
//        else if (indexPath.row == 3) {  // 地区
//            if (!cell) {
//                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:StringEditCell];
//                UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 15, 30, 20)];
//                lable.tag = 1;
//                cell.textLabel.text = @"地区";
//                [cell.contentView addSubview:lable];
//            }
//            UILabel *lable = (UILabel *)[cell.contentView viewWithTag:1];
//            lable.text = [NSString stringWithFormat:@"%@ %@",[[CureMeUtils defaultCureMeUtil] regionWithRegionID:[[[NSUserDefaults standardUserDefaults] objectForKey:USER_REGION] integerValue]],[[NSUserDefaults standardUserDefaults] objectForKey:USER_CITY_NAME]];
//            CGRect temp = lable.frame;
//            temp.size.width = lable.font.pointSize * lable.text.length;
//            temp.origin.x = SCREEN_WIDTH - temp.size.width - 17;
//            lable.frame = temp;
//        }
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        return cell;
//    }
    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DefaultCell"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 2) {
            
            ChangePhoneNoViewController *changePhVc = [[ChangePhoneNoViewController alloc] init];
            [self.navigationController pushViewController:changePhVc animated:YES];

        }
        else if (indexPath.row == 3){
            ChangePasswordViewController *changePwdVC = [[ChangePasswordViewController alloc] initWithNibName:@"ChangePasswordViewController" bundle:nil];
            [self.navigationController pushViewController:changePwdVC animated:YES];
        }
    }
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}


- (bool)logOff
{
    NSString *post = [NSString stringWithFormat:@"action=logout&userid=%ld&lastactivity=%.2f", (long)[CureMeUtils defaultCureMeUtil].userID, [[NSDate alloc] init].timeIntervalSince1970];
    NSLog(@"logoff %@", post);
    
    NSData *response = sendRequest(@"m.php", post);
    
    NSString *logoffStr = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
    NSLog(@"logOff: %@", logoffStr);
    
    NSDictionary *jsonData = parseJsonResponse(response);
    NSNumber *result = [jsonData objectForKey:@"result"];
    if (!result || result.integerValue != 1) {
        NSLog(@"logOff error: %@", [jsonData objectForKey:@"msg"]);
    }
    
    [[CureMeUtils defaultCureMeUtil] resetUserInfo];
    [[CureMeUtils defaultCureMeUtil] clearUserInfoStore];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
    return true;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
