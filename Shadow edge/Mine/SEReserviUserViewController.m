//
//  SEReserviUserViewController.m
//  Shadow edge
//
//  Created by En Shuo on 2021/8/31.
//

#import "SEReserviUserViewController.h"
#import "SEParMovieTableViewCell.h"
#import "SEHotMovModel.h"
#import <SVProgressHUD.h>
#import <MJExtension.h>
#import "SEMovieCaDetailViewController.h"
@interface SEReserviUserViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *resTableV;
@property (nonatomic, strong) NSMutableArray *userResArr;
@end


@implementation SEReserviUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的预约";
    self.view.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.resTableV];
    [self getMyReservamov];
}
- (void)getMyReservamov{
    [SVProgressHUD show];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
        NSString * shaDowMask= NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
        NSString * shadowPath = [shaDowMask stringByAppendingPathComponent:@"shaDowMyReservationMov.plist"];
        NSArray * resMovAll = [[NSArray alloc]initWithContentsOfFile:shadowPath];
        for (NSDictionary *mov in resMovAll) {
            [self.userResArr addObject:[SEHotMovModel mj_objectWithKeyValues:mov]];
        }
        [self.resTableV reloadData];
    });
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.userResArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SEParMovieTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SEParMovieTableViewCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.moveModel = self.userResArr[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SEMovieCaDetailViewController *detail = [[SEMovieCaDetailViewController alloc]init];
    detail.movModel = self.userResArr[indexPath.row];
    [self.navigationController pushViewController:detail animated:YES];
}

- (UITableView *)resTableV{
    if (!_resTableV) {
        _resTableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SESCREEN_Wid, SESCREEN_Hei - SESCREEN_Nav) style:UITableViewStylePlain];
        _resTableV.delegate = self;
        _resTableV.dataSource = self;
        _resTableV.backgroundColor = [UIColor blackColor];
        _resTableV.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_resTableV registerNib:[UINib nibWithNibName:@"SEParMovieTableViewCell" bundle:nil] forCellReuseIdentifier:@"SEParMovieTableViewCell"];
    }
    return _resTableV;
}
- (NSMutableArray *)userResArr{
    if (!_userResArr) {
        _userResArr = [[NSMutableArray alloc]init];
    }
    return _userResArr;
}
@end
