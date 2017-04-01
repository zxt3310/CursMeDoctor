//
//  PerCenterViewController.m
//  CureMe
//
//  Created by Tim on 12-8-16.
//  Copyright (c) 2012年 Tim. All rights reserved.
//


// 1. 账户Cell：已登录（姓名+“退出登录”）；未登录（登录、注册）
// 2. 个人信息Cell：
//  1）姓名Cell - 可编辑
//  2）年龄Cell - 可编辑
//  3）手机Cell - 可编辑
//  4）地区Cell - 可编辑
// 3. 修改密码Cell

#import "PerCenterViewController.h"
#import "PerCenterViewController.h"
#import "LoginViewController.h"
#import "PerCenterLoginCell.h"
#import "PerCenterLogoutCell.h"
#import "CMDataPickEditCell.h"
#import "RegisterViewController.h"
#import "ChangePasswordViewController.h"
#import "CMChooseQueryOfficeTableViewController.h"
#import "CMMainTabViewController.h"
#import "CMPerCenterHeaderCell.h"


@interface PerCenterViewController ()

@end



@implementation PerCenterViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        hasShownLoginViewController = false;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]}];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.tableView.backgroundView = nil;
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]]];
    
    self.tableView.userInteractionEnabled = YES;
    
    [self.tableView reloadData];
    
    [self.navigationItem setTitle:@"个人中心"];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
//    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]]];
    
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.tableView reloadData];
    self.tabBarController.navigationItem.leftBarButtonItem = nil;
    self.tabBarController.navigationItem.rightBarButtonItem = nil;
    self.tabBarController.navigationItem.leftBarButtonItems = nil;
    self.tabBarController.navigationItem.rightBarButtonItems = nil;
    self.tabBarController.navigationItem.titleView = nil;
    self.tabBarController.navigationItem.title = @"个人中心";

    [super viewWillAppear:animated];
    
    if (IOS_VERSION >= 7.0) {
        CGRect tableFrame = self.tableView.frame;
        //tableFrame.origin.y = 20 + NAVIGATIONBAR_HEIGHT;
        //tableFrame.size.height = SCREEN_HEIGHT - 20 - NAVIGATIONBAR_HEIGHT - 50;
        tableFrame.size.height = SCREEN_HEIGHT - 49 - 64;
        self.tableView.frame = tableFrame;
        //[self.tableView setContentOffset:CGPointMake(0.0, 20.0) animated:NO];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (![CureMeUtils defaultCureMeUtil].hasLogin && !hasShownLoginViewController) {
        LoginViewController *loginVC = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
        [self.navigationController pushViewController:loginVC animated:YES];
        hasShownLoginViewController = true;
        return;
    }
    
    // 如果已登录，则更新用户信息
    if ([CureMeUtils defaultCureMeUtil].hasLogin) {
        [[CureMeUtils defaultCureMeUtil] updateUserInfo:[CureMeUtils defaultCureMeUtil].userID];
    }
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    NSLog(@"PerCenterViewController didReceiveMemoryWarning");
    
    [super didReceiveMemoryWarning];
}

- (IBAction)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source
/*
 – tableView:cellForRowAtIndexPath:  required method
 – numberOfSectionsInTableView:
 – tableView:numberOfRowsInSection:  required method
 – sectionIndexTitlesForTableView:
 – tableView:sectionForSectionIndexTitle:atIndex:
 – tableView:titleForHeaderInSection:
 – tableView:titleForFooterInSection:
 */

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
        return 0;
    
    return 30;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return nil;
    }
    if (section == 1) {
        return @"账户";
    }
    else if (section == 2) {
        return @"个人信息";
    }
    
    return @"账户管理";
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    return nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    if ([CureMeUtils defaultCureMeUtil].hasLogin) {
        return 4;
    }
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (section == 0) { // 顶部三个按钮Cell
        return 1;
    }
    else if (section == 1) {
        return 1;       // 账户登录、注销、注册Cell
    }
    else if (section == 2) {
        return 4;       // 个人信息Cell（姓名、年龄、手机、地区）
    }
    else if (section == 3) {
        return 1;       // 修改密码Cell
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *DefaultCell = @"DefaultCell";
    static NSString *HeaderCell = @"HeaderCell";
    static NSString *loginCell = @"LoginCell";
    static NSString *logoutCell = @"LogoutCell";
    static NSString *StringEditCell = @"StringEditCell";
    
    if (indexPath.section == 0) {
        CMPerCenterHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:HeaderCell];
        if (!cell) {
            cell = [[CMPerCenterHeaderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:HeaderCell];
        }
        [cell setPerCenterViewController:self];
        
        return cell;
    }
    else if (indexPath.section == 1) {
        if ([CureMeUtils defaultCureMeUtil].hasLogin) {
            PerCenterLogoutCell *cell = [tableView dequeueReusableCellWithIdentifier:logoutCell];
            if (!cell) {
                cell = [[PerCenterLogoutCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:logoutCell];
            }
            [cell clearDisplay];
            [cell setViewController:self];

            return cell;
        }
        else {
            PerCenterLoginCell *cell = [tableView dequeueReusableCellWithIdentifier:loginCell];
            if (!cell) {
                cell = [[PerCenterLoginCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:loginCell];
            }
            [cell setViewController:self];

            return cell;
        }
    }
    else if (indexPath.section == 2) {
        CMStringEditCell *strEditCell = nil;
        
        if (indexPath.row == 0) {       // 姓名
            strEditCell = [[CMStringEditCell alloc] initWithEditType:EDITCELL_NAME reuseIdentifier:StringEditCell];
            return strEditCell;
        }
        else if (indexPath.row == 1) {  // 年龄
            strEditCell = [[CMStringEditCell alloc] initWithEditType:EDITCELL_AGE reuseIdentifier:StringEditCell];
            return strEditCell;
        }
        else if (indexPath.row == 2) {  // 手机
            strEditCell = [[CMStringEditCell alloc] initWithEditType:EDITCELL_PHONE reuseIdentifier:StringEditCell];
            return strEditCell;
        }
        else if (indexPath.row == 3) {  // 地区
            CMDataPickEditCell *cell = [[CMDataPickEditCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:DefaultCell];
            return cell;
        }
    }
    else if (indexPath.section == 3) {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:DefaultCell];
        cell.textLabel.text = @"修改密码";
        [cell.textLabel setFont:[UIFont systemFontOfSize:16]];
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        return cell;        
    }
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:DefaultCell];
    return cell;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 80;
    }
    
    return 40;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 3) {
        ChangePasswordViewController *changePwdVC = [[ChangePasswordViewController alloc] initWithNibName:@"ChangePasswordViewController" bundle:nil];
        [self.navigationController pushViewController:changePwdVC animated:YES];
    }
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
//        return false;
    }
    
    [[CureMeUtils defaultCureMeUtil] resetUserInfo];
    [[CureMeUtils defaultCureMeUtil] clearUserInfoStore];
    
    [self.tableView reloadData];
    if (IOS_VERSION >= 7.0) {
        CGRect tableFrame = self.tableView.frame;
        //tableFrame.origin.y = 20 + NAVIGATIONBAR_HEIGHT;
        //tableFrame.size.height = SCREEN_HEIGHT - 20 - NAVIGATIONBAR_HEIGHT - 50;
        tableFrame.size.height = SCREEN_HEIGHT - 49 - 64;
        self.tableView.frame = tableFrame;
        //[self.tableView setContentOffset:CGPointMake(0.0, 20.0) animated:NO];
    }
   
    {
        // 跳转到“我的咨询”页面
        CMMainTabViewController *mainTabVC = (CMMainTabViewController *)[[self.navigationController viewControllers] objectAtIndex:0];
        
        NSMutableArray *VCs = [[NSMutableArray alloc] initWithArray:[mainTabVC viewControllers]];
        // “我的咨询”页面
        UIViewController *listViewController = [VCs objectAtIndex:1];
        if (![listViewController isKindOfClass:[CMChooseQueryOfficeTableViewController class]]) {
            CMChooseQueryOfficeTableViewController *chooseVC = [[CMChooseQueryOfficeTableViewController alloc] initWithNibName:@"CMChooseQueryOfficeTableViewController" bundle:nil]; //[[CMChooseQueryOfficeTableViewController alloc] initWithStyle:UITableViewStylePlain];
            [VCs setObject:chooseVC atIndexedSubscript:1];
        }
        
        // “我的预约”页面
        listViewController = [VCs objectAtIndex:3];
        if (![listViewController isKindOfClass:[CMChooseQueryOfficeTableViewController class]]) {
            CMChooseQueryOfficeTableViewController *chooseVC = [[CMChooseQueryOfficeTableViewController alloc] initWithNibName:@"CMChooseQueryOfficeTableViewController" bundle:nil]; //[[CMChooseQueryOfficeTableViewController alloc] initWithStyle:UITableViewStylePlain];
            [VCs setObject:chooseVC atIndexedSubscript:3];
        }
        [mainTabVC setViewControllers:[VCs copy]];
    }

    return true;
}

- (void)login
{
    LoginViewController *loginVC = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    if (!loginVC)
        return;
    
    [self.navigationController pushViewController:loginVC animated:YES];
}

- (void)regist
{
    RegisterViewController *registerVC = [[RegisterViewController alloc] initWithNibName:@"RegisterViewController" bundle:nil];
    if (!registerVC)
        return;
    
    [self.navigationController pushViewController:registerVC animated:YES];
}

@end
