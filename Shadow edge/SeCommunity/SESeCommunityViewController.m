//
//  SESeCommunityViewController.m
//  Shadow edge
//
//  Created by En Shuo on 2021/8/26.
//

#import "SESeCommunityViewController.h"
#import "SESeCommunityTableViewCell.h"
#import <SVProgressHUD.h>
#import "SESeCommuntiyModel.h"
#import <MJExtension.h>
#import "SEMyLogAccountViewController.h"
#import "SESeComDetailiViewController.h"
#import "SEReleaseNewViewController.h"
@interface SESeCommunityViewController ()<UITableViewDelegate,UITableViewDataSource,SECommunityChuDelegate>
@property (nonatomic, strong) UITableView *seComTableView;
@property (nonatomic, strong) NSMutableArray *seComArray;
@end

@implementation SESeCommunityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.seComTableView];
    self.navigationItem.title = @"社区";
    [self getSECompleCommunity];
    
    UIButton *releasBt  = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 35, 35)];
    [releasBt setImage:[UIImage imageNamed:@"shadow_release"] forState:UIControlStateNormal];
    [releasBt addTarget:self action:@selector(addClickRealseAct) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *addItm = [[UIBarButtonItem alloc]initWithCustomView:releasBt];
    self.navigationItem.rightBarButtonItem = addItm;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.seComArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SESeCommunityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SESeCommunityTableViewCell"];
    cell.delegate = self;
    cell.seCom = self.seComArray[indexPath.row];
    cell.idxPath = indexPath;
    return cell;
}

- (void)getSECompleCommunity{
    [SVProgressHUD show];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
        NSString * shadowPath = [[NSBundle mainBundle] pathForResource:@"SECompleteCirl" ofType:@"plist"];
        NSArray * seCirArr = [[NSArray alloc]initWithContentsOfFile:shadowPath];
        for (NSDictionary *dic in seCirArr) {
            [self.seComArray addObject:[SESeCommuntiyModel mj_objectWithKeyValues:dic]];
        }
        [self.seComTableView reloadData];
    });
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SESeComDetailiViewController *secomDetail = [[SESeComDetailiViewController alloc]init];
    secomDetail.seCommunity = self.seComArray[indexPath.row];
    [self.navigationController pushViewController:secomDetail animated:YES];
}


- (void)clickApplyFor:(NSIndexPath *)idxPath{
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"sedowLogStatus"] == nil) {
        SEMyLogAccountViewController *myLogacc = [[SEMyLogAccountViewController alloc] initWithNibName:@"SEMyLogAccountViewController" bundle:nil];
        myLogacc.hidesBottomBarWhenPushed = YES;
        UINavigationController *navlog= [[UINavigationController alloc]initWithRootViewController:myLogacc];
        [navlog.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17.0],NSForegroundColorAttributeName:[UIColor blackColor]}];
        navlog.navigationBar.barTintColor = [UIColor whiteColor];
        [self presentViewController:navlog animated:YES completion:nil];
        return;
    }
    SESeComDetailiViewController *secomDetail = [[SESeComDetailiViewController alloc]init];
    secomDetail.seCommunity = self.seComArray[idxPath.row];
    [self.navigationController pushViewController:secomDetail animated:YES];
}


- (void)addClickRealseAct{
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"sedowLogStatus"] == nil) {
        SEMyLogAccountViewController *myLogacc = [[SEMyLogAccountViewController alloc] initWithNibName:@"SEMyLogAccountViewController" bundle:nil];
        myLogacc.hidesBottomBarWhenPushed = YES;
        UINavigationController *navlog= [[UINavigationController alloc]initWithRootViewController:myLogacc];
        [navlog.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17.0],NSForegroundColorAttributeName:[UIColor blackColor]}];
        navlog.navigationBar.barTintColor = [UIColor whiteColor];
        [self presentViewController:navlog animated:YES completion:nil];
        return;
    }
    SEReleaseNewViewController *releaseCom =[[SEReleaseNewViewController alloc]init];
    [self.navigationController pushViewController:releaseCom animated:YES];
}

- (void)clickGiveLike:(NSIndexPath *)idxPath{
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"sedowLogStatus"] == nil) {
        SEMyLogAccountViewController *myLogacc = [[SEMyLogAccountViewController alloc] initWithNibName:@"SEMyLogAccountViewController" bundle:nil];
        myLogacc.hidesBottomBarWhenPushed = YES;
        UINavigationController *navlog= [[UINavigationController alloc]initWithRootViewController:myLogacc];
        [navlog.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17.0],NSForegroundColorAttributeName:[UIColor blackColor]}];
        navlog.navigationBar.barTintColor = [UIColor whiteColor];
        [self presentViewController:navlog animated:YES completion:nil];
        return;
    }
    [SVProgressHUD show];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
        SESeCommuntiyModel *seCom = self.seComArray[idxPath.row];
        [[NSUserDefaults standardUserDefaults]setValue:seCom.seUserName forKey:@"shadowGetLike"];
        [SVProgressHUD showSuccessWithStatus:@"点赞成功"];
        [SVProgressHUD dismissWithDelay:1.1];
    });
}

- (void)clickThreeStarOp:(NSIndexPath *)idxPath{
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"sedowLogStatus"] == nil) {
        SEMyLogAccountViewController *myLogacc = [[SEMyLogAccountViewController alloc] initWithNibName:@"SEMyLogAccountViewController" bundle:nil];
        myLogacc.hidesBottomBarWhenPushed = YES;
        UINavigationController *navlog= [[UINavigationController alloc]initWithRootViewController:myLogacc];
        [navlog.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17.0],NSForegroundColorAttributeName:[UIColor blackColor]}];
        navlog.navigationBar.barTintColor = [UIColor whiteColor];
        [self presentViewController:navlog animated:YES completion:nil];
        return;
    }
    UIAlertController *oparAlert = [UIAlertController alertControllerWithTitle:@"提示" message:@"内容违规？请选择操作" preferredStyle:UIAlertControllerStyleActionSheet];
    [oparAlert addAction:[UIAlertAction actionWithTitle:@"举报" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [SVProgressHUD show];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
            SESeCommuntiyModel *seCom = self.seComArray[idxPath.row];
            [[NSUserDefaults standardUserDefaults]setValue:seCom.seContentE forKey:@"shadowReport"];
            [SVProgressHUD showSuccessWithStatus:@"举报成功，平台会在24小时内对内容重新审核并处理"];
            [SVProgressHUD dismissWithDelay:1.1];
        });
    }]];
    [oparAlert addAction:[UIAlertAction actionWithTitle:@"屏蔽" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [SVProgressHUD show];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
            [self.seComArray removeObjectAtIndex:idxPath.row];
            [SVProgressHUD showSuccessWithStatus:@"屏蔽成功，以为您移除此内容"];
            [SVProgressHUD dismissWithDelay:1.1 completion:^{
                [self.seComTableView reloadData];
            }];
        });
    }]];
    [oparAlert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self presentViewController:oparAlert animated:YES completion:nil];
}

- (UITableView *)seComTableView{
    if (!_seComTableView) {
        _seComTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SESCREEN_Wid, SESCREEN_Hei - SESCREEN_Nav - SESCREEN_Tab) style:UITableViewStylePlain];
        _seComTableView.backgroundColor = [UIColor blackColor];
        _seComTableView.dataSource = self;
        _seComTableView.delegate = self;
        _seComTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_seComTableView registerNib:[UINib nibWithNibName:@"SESeCommunityTableViewCell" bundle:nil] forCellReuseIdentifier:@"SESeCommunityTableViewCell"];
    }
    return _seComTableView;
}

- (NSMutableArray *)seComArray{
    if (!_seComArray) {
        _seComArray = [[NSMutableArray alloc]init];
    }
    return _seComArray;
}

@end
