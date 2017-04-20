//
//  CMPerCenterHeaderCell.m
//  我的私人医生
//
//  Created by Tim on 13-8-21.
//  Copyright (c) 2013年 Tim. All rights reserved.
//

#import "CMPerCenterHeaderCell.h"
#import "LoginViewController.h"
#import "CMMyChatListViewController.h"
#import "MyBookListViewController.h"
#import "WebViewController.h"


@interface CMPerCenterHeaderCell(private)

- (void)initialization;

@end



@implementation CMPerCenterHeaderCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self initialization];
    }
    return self;
}

- (void)initialization
{
    self.contentView.frame = CGRectMake(0, 0, 320, 80);
    
    UIImageView *headImgVew = [[UIImageView alloc] initWithFrame:CGRectMake(12, 10, 60, 60)];
    headImgVew.image = [CMImageUtils defaultImageUtil].userHeadImage;
    [self.contentView addSubview:headImgVew];
    
    UILabel *userNameLb = [[UILabel alloc] initWithFrame:CGRectMake(82, 16, 100, 20)];
    userNameLb.text = [CureMeUtils defaultCureMeUtil].userName;
    userNameLb.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:userNameLb];
    
    UILabel *userStatusLb = [[UILabel alloc] initWithFrame:CGRectMake(82, 38, 100, 20)];
    userStatusLb.textColor = [UIColor grayColor];
    userStatusLb.font = [UIFont systemFontOfSize:13];
    if ([CureMeUtils defaultCureMeUtil].hasLogin) {
        if ([CureMeUtils defaultCureMeUtil].isUnRegLoginUser) {
            userStatusLb.text = @"非正式用户";
        }
        else{
            userStatusLb.text = @"正式用户";
        }
    }
    else {
        userNameLb.text = @"点击登录";
    }
    [self.contentView addSubview:userStatusLb];

//    UIButton *myBookBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [myBookBtn setImage:[UIImage imageNamed:@"twdzx_p.png"] forState:UIControlStateNormal];
//    [myBookBtn setImage:[UIImage imageNamed:@"twdzx_n.png"] forState:UIControlStateHighlighted];
//    [myBookBtn setImage:[UIImage imageNamed:@"twdzx_n.png"] forState:UIControlStateSelected];
//    myBookBtn.frame = CGRectMake(60, 5, 50, 50);
//    [myBookBtn addTarget:self action:@selector(myBookBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//    [self.contentView addSubview:myBookBtn];
//    
//    UILabel *myBookLabel = [[UILabel alloc] init];
//    [myBookLabel setText:@"我的预约"];
//    [myBookLabel setFont:[UIFont systemFontOfSize:13]];
//    [myBookLabel setTextColor:[UIColor darkGrayColor]];
//    [myBookLabel setTextAlignment:NSTextAlignmentCenter];
//    [myBookLabel setBackgroundColor:[UIColor clearColor]];
//    myBookLabel.frame = CGRectMake(55, 57, 60, 14);
//    [self.contentView addSubview:myBookLabel];
//
//    UIButton *myChatBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [myChatBtn setImage:[UIImage imageNamed:@"twddh_p.png"] forState:UIControlStateNormal];
//    [myChatBtn setImage:[UIImage imageNamed:@"twddh_n.png"] forState:UIControlStateHighlighted];
//    [myChatBtn setImage:[UIImage imageNamed:@"twddh_n.png"] forState:UIControlStateSelected];
//    myChatBtn.frame = CGRectMake(130, 5, 50, 50);
//    [myChatBtn addTarget:self action:@selector(myChatBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//    [self.contentView addSubview:myChatBtn];
//
//    UILabel *myChatLabel = [[UILabel alloc] init];
//    [myChatLabel setText:@"我的咨询"];
//    [myChatLabel setFont:[UIFont systemFontOfSize:13]];
//    [myChatLabel setTextColor:[UIColor darkGrayColor]];
//    [myChatLabel setTextAlignment:NSTextAlignmentCenter];
//    [myChatLabel setBackgroundColor:[UIColor clearColor]];
//    myChatLabel.frame = CGRectMake(125, 57, 60, 14);
//    [self.contentView addSubview:myChatLabel];
//
//    UIButton *appBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [appBtn setImage:[UIImage imageNamed:@"tuijianapp_p.png"] forState:UIControlStateNormal];
//    [appBtn setImage:[UIImage imageNamed:@"tuijianapp_n.png"] forState:UIControlStateHighlighted];
//    [appBtn setImage:[UIImage imageNamed:@"tuijianapp_n.png"] forState:UIControlStateSelected];
//    appBtn.frame = CGRectMake(195, 5, 50, 50);
//    [appBtn addTarget:self action:@selector(appBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//    [self.contentView addSubview:appBtn];    
//
//    UILabel *appLabel = [[UILabel alloc] init];
//    [appLabel setText:@"推荐App"];
//    [appLabel setFont:[UIFont systemFontOfSize:13]];
//    [appLabel setTextColor:[UIColor darkGrayColor]];
//    [appLabel setTextAlignment:NSTextAlignmentCenter];
//    appLabel.frame = CGRectMake(195, 57, 60, 14);
//    [appLabel setBackgroundColor:[UIColor clearColor]];
//    [self.contentView addSubview:appLabel];
//
//    [self setBackgroundView:[[UIView alloc] initWithFrame:CGRectZero]];
}

- (void)setPerCenterViewController:(PerCenterViewController *)perCenterViewController
{
    _perCenterViewController = perCenterViewController;
}

- (IBAction)myBookBtnClick:(id)sender
{
    if (!_perCenterViewController)
        return;

    if (![CureMeUtils defaultCureMeUtil].hasLogin) {
        LoginViewController *loginVC = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
        [_perCenterViewController.navigationController pushViewController:loginVC animated:YES];
        return;
    }

    MyBookListViewController *myBookListVC = [[MyBookListViewController alloc] initWithNibName:@"MyBookListViewController" bundle:nil]; //[[MyBookListViewController alloc] initWithStyle:UITableViewStylePlain];
    myBookListVC.isMainTabPage = false;
    [_perCenterViewController.navigationController pushViewController:myBookListVC animated:YES];
}

- (IBAction)myChatBtnClick:(id)sender
{
    if (!_perCenterViewController)
        return;
    
    if (![CureMeUtils defaultCureMeUtil].hasLogin) {
        LoginViewController *loginVC = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
        [_perCenterViewController.navigationController pushViewController:loginVC animated:YES];
        return;
    }
    
    CMMyChatListViewController *myChatListVC = [[CMMyChatListViewController alloc] initWithNibName:@"CMMyChatListViewController" bundle:nil]; //[[CMMyChatListViewController alloc] initWithStyle:UITableViewStylePlain];
    myChatListVC.isMainTabController = false;
    [_perCenterViewController.navigationController pushViewController:myChatListVC animated:YES];
}

- (IBAction)appBtnClick:(id)sender
{
    WebViewController *webVC = [[WebViewController alloc] initWithNibName:@"WebViewController" bundle:nil];
    [webVC setStrURL:[NSString stringWithFormat:@"http://app.imeirong.com/applist.php?appid=1"]];

    [_perCenterViewController.navigationController pushViewController:webVC animated:YES];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
