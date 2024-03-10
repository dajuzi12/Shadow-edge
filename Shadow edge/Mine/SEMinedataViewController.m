//
//  SEMinedataViewController.m
//  Shadow edge
//
//  Created by En Shuo on 2021/8/26.
//

#import "SEMinedataViewController.h"
#import <SDWebImage.h>
#import <SVProgressHUD.h>
#import "SEMyAccInfoTableViewCell.h"
#import "SEUserCenterMoTableViewCell.h"
#import "SEReserviUserViewController.h"
#import <SDImageCache.h>
#import "SEUserFeedBViewController.h"
@interface SEMinedataViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *mineDataTable;
@end

@implementation SEMinedataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的";
    [self.view addSubview:self.mineDataTable];
    self.view.backgroundColor = [UIColor blackColor];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        SEMyAccInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SEMyAccInfoTableViewCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.myName.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"sedowUserName"];
        [cell.myAvatar sd_setImageWithURL:[NSURL URLWithString:[[NSUserDefaults standardUserDefaults]objectForKey:@"sedowUserPic"]]];
        return cell;
    }
    SEUserCenterMoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SEUserCenterMoTableViewCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSArray *moText = @[@"我的预约",@"清理缓存",@"意见反馈",@"联系客服",@"退出登录"];
    NSArray *moImg = @[@"shadow_res",@"shadow_clean",@"shadow_feed",@"shadow_scontact",@"shadow_gout"];
    cell.moImg.image = [UIImage imageNamed:moImg[indexPath.row]];
    cell.moText.text = moText[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            SEReserviUserViewController *reserviUser = [[SEReserviUserViewController alloc]init];
            [self.navigationController pushViewController:reserviUser animated:YES];
        }else if (indexPath.row == 1){
          
            [SVProgressHUD show];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
                [[SDImageCache sharedImageCache] clearMemory];
                [SVProgressHUD showSuccessWithStatus:@"清理缓存成功"];
                [SVProgressHUD dismissWithDelay:1.1];
            });
        }else if (indexPath.row == 2){
            SEUserFeedBViewController *feed = [[SEUserFeedBViewController alloc]init];
            [self.navigationController pushViewController:feed animated:YES];
        }else if (indexPath.row == 3){
            UIAlertController *userHelp = [UIAlertController alertControllerWithTitle:@"提示" message:@"客服联系电话 +84 928201821" preferredStyle:UIAlertControllerStyleAlert];
            [userHelp addAction:[UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil]];
            [self presentViewController:userHelp animated:YES completion:nil];
        }else if (indexPath.row == 4){
            UIAlertController *gOUt = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定要退出吗？" preferredStyle:UIAlertControllerStyleAlert];
            [gOUt addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
            [gOUt addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [SVProgressHUD show];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [SVProgressHUD dismiss];
                    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"sedowLogStatus"];
                    [SVProgressHUD showSuccessWithStatus:@"退出成功"];
                    [SVProgressHUD dismissWithDelay:1.2 completion:^{
                        [self.tabBarController setSelectedIndex:0];
                    }];
                });
            }]];
            [self presentViewController:gOUt animated:YES completion:nil];
        }
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return  220;
    }
    return 56;
}
- (UITableView *)mineDataTable{
    if (!_mineDataTable) {
        _mineDataTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SESCREEN_Wid, SESCREEN_Hei - SESCREEN_Nav - SESCREEN_Tab) style:UITableViewStylePlain];
        _mineDataTable.backgroundColor = [UIColor blackColor];
        _mineDataTable.delegate = self;
        _mineDataTable.dataSource = self;
        _mineDataTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_mineDataTable registerNib:[UINib nibWithNibName:@"SEMyAccInfoTableViewCell" bundle:nil] forCellReuseIdentifier:@"SEMyAccInfoTableViewCell"];
        [_mineDataTable registerNib:[UINib nibWithNibName:@"SEUserCenterMoTableViewCell" bundle:nil] forCellReuseIdentifier:@"SEUserCenterMoTableViewCell"];
    }
    return _mineDataTable;
}

@end
