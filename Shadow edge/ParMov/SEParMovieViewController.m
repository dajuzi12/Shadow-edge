//
//  SEParMovieViewController.m
//  Shadow edge
//
//  Created by En Shuo on 2021/8/26.
//

#import "SEParMovieViewController.h"
#import "SEParMovieTableViewCell.h"
#import "SEHotMovModel.h"
#import <MJExtension.h>
#import <SVProgressHUD.h>
#import "SEPoreationTableViewCell.h"
#import "SEMovieCaDetailViewController.h"
#import "SEReleaseNewViewController.h"
#import "SEMyLogAccountViewController.h"
#import "SEMesCenterViewController.h"

#import "QYHttpManager.h"
#import <SDWebImage/SDWebImage.h>
@interface SEParMovieViewController ()<UITableViewDelegate,UITableViewDataSource,SEPoreationDelegate>
@property (nonatomic, strong) UITableView *parTableView;
@property (nonatomic, strong) NSMutableArray *latestRecomList;

@property (nonatomic, strong) UIImageView *pushIma;

@end

@implementation SEParMovieViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [self getSourse];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    self.navigationItem.title = @"首页";
    [self.view addSubview:self.parTableView];
    
//    self.parTableView.hidden = YES;
    
//    self.pushIma = [[UIImageView alloc]initWithFrame:CGRectMake(10, 20, self.view.frame.size.width - 20, self.view.frame.size.height - 40)];
////    [self.pushIma setImage:[UIImage imageNamed:@"pushImage"]];
//    self.pushIma.backgroundColor = UIColor.redColor;
////    [self.pushIma setHidden:YES];
//    [self.view addSubview:self.pushIma];
    
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setPushIma:) name:@"PushIma" object:nil];
    [self getSEHotMovSourse];
    
   
    
}
-(void)getSourse{
    
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    

    [QYHttpManager postWithUrl:@"v1/app/batchNumber/info" jsonParameters:@{@"series":@"c1fed9c8-b232-4c85-a7ec-8843bf9303ef",@"version":app_Version} progressShow:NO success:^(id responseObject) {
        
        if(responseObject) {
            
            
            NSLog(@"mymodel===%@",responseObject[@"data"][@"isReplace"]);
            NSString * isReplace = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"isReplace"]];
            
            if ([isReplace isEqualToString:@"0"]) {
                NSLog(@"mymodel");
            }else{
                
                UIImageView * imageview = [[UIImageView alloc]init];
                [imageview sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",responseObject[@"data"][@"appBackgroundUrl"]]]];
                
                [[UIApplication sharedApplication].keyWindow.rootViewController.view addSubview:imageview];
            }
            
            
            
     
        }else {
               
        }

        
     
    } failure:^(NSError *error) {
        NSLog(@"%@", [error localizedDescription]);
    }];
}
- (void)setPushIma:(NSNotification *)notification{
    NSLog(@"通知");
//    [self.pushIma bringSubviewToFront:self.pushIma];
//    [self.pushIma setHidden:NO];
//    [self.parTableView setHidden:YES];
    

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    return self.latestRecomList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        SEPoreationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SEPoreationTableViewCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.seDelegate = self;
        return cell;
    }
    SEParMovieTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SEParMovieTableViewCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.moveModel = self.latestRecomList[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SEMovieCaDetailViewController *movieDetail = [[SEMovieCaDetailViewController alloc]init];
    movieDetail.movModel = self.latestRecomList[indexPath.row];
    [self.navigationController pushViewController:movieDetail animated:YES];
}

- (void)poreationClickRealseAct{
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

- (void)poreationClickCommunityDy{
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"sedowLogStatus"] == nil) {
        SEMyLogAccountViewController *myLogacc = [[SEMyLogAccountViewController alloc] initWithNibName:@"SEMyLogAccountViewController" bundle:nil];
        myLogacc.hidesBottomBarWhenPushed = YES;
        UINavigationController *navlog= [[UINavigationController alloc]initWithRootViewController:myLogacc];
        [navlog.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17.0],NSForegroundColorAttributeName:[UIColor blackColor]}];
        navlog.navigationBar.barTintColor = [UIColor whiteColor];
        [self presentViewController:navlog animated:YES completion:nil];
        return;
    }
    SEMesCenterViewController *msgCenter = [[SEMesCenterViewController alloc]init];
    [self.navigationController pushViewController:msgCenter animated:YES];
}
- (void)poreationClickFeedback{
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"sedowLogStatus"] == nil) {
        SEMyLogAccountViewController *myLogacc = [[SEMyLogAccountViewController alloc] initWithNibName:@"SEMyLogAccountViewController" bundle:nil];
        myLogacc.hidesBottomBarWhenPushed = YES;
        UINavigationController *navlog= [[UINavigationController alloc]initWithRootViewController:myLogacc];
        [navlog.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17.0],NSForegroundColorAttributeName:[UIColor blackColor]}];
        navlog.navigationBar.barTintColor = [UIColor whiteColor];
        [self presentViewController:navlog animated:YES completion:nil];
        return;
    }
}
- (void)getSEHotMovSourse{
    [SVProgressHUD show];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
        NSString * shadowPath = [[NSBundle mainBundle] pathForResource:@"SENHMovieSourse" ofType:@"plist"];
        NSArray * movieArr = [[NSArray alloc]initWithContentsOfFile:shadowPath];
        for (NSDictionary *mov in movieArr) {
            [self.latestRecomList addObject:[SEHotMovModel mj_objectWithKeyValues:mov]];
        }
        [self.parTableView reloadData];
    });
    UIView *seHead = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SESCREEN_Wid, 219)];
    seHead.backgroundColor = [UIColor blackColor];
    UIImageView *idHead = [[UIImageView alloc]initWithFrame:CGRectMake(13, 5, SESCREEN_Wid - 26, 214)];
    idHead.image = [UIImage imageNamed:@"seMovHead1"];
    idHead.layer.cornerRadius = 5;
    idHead.contentMode = UIViewContentModeScaleAspectFill;
    idHead.layer.masksToBounds = YES;
    [seHead addSubview:idHead];
    self.parTableView.tableHeaderView = seHead;
}

- (NSMutableArray *)latestRecomList{
    if (!_latestRecomList) {
        _latestRecomList = [[NSMutableArray alloc]init];
    }
    return _latestRecomList;
}

- (UITableView *)parTableView{
    if (!_parTableView) {
        _parTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SESCREEN_Wid, SESCREEN_Hei - SESCREEN_Nav - SESCREEN_Tab) style:UITableViewStylePlain];
        _parTableView.backgroundColor = [UIColor blackColor];
        _parTableView.delegate = self;
        _parTableView.dataSource = self;
        _parTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_parTableView registerNib:[UINib nibWithNibName:@"SEParMovieTableViewCell" bundle:nil] forCellReuseIdentifier:@"SEParMovieTableViewCell"];
        [_parTableView registerNib:[UINib nibWithNibName:@"SEPoreationTableViewCell" bundle:nil] forCellReuseIdentifier:@"SEPoreationTableViewCell"];
        
    }
    return _parTableView;
}
@end
