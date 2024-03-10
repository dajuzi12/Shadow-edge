//
//  SEMesCenterViewController.m
//  Shadow edge
//
//  Created by En Shuo on 2021/8/30.
//

#import "SEMesCenterViewController.h"
#import "SEMesCenterTableViewCell.h"
#import <SVProgressHUD.h>
@interface SEMesCenterViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *mesTableView;
@property (nonatomic, strong) NSMutableArray *mesArray;
@end

@implementation SEMesCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"消息中心";
    self.view.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.mesTableView];
    [self getNewMessageData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.mesArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SEMesCenterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SEMesCenterTableViewCell"];
    NSDictionary *msg = self.mesArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.mesTitle.text = msg[@"message_title"];
    cell.mesContent.text = msg[@"message_text"];
    cell.mesdate.text = msg[@"message_date"];
    return cell;
}

- (void)getNewMessageData{
    [SVProgressHUD show];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
        NSString * shadowPath = [[NSBundle mainBundle] pathForResource:@"SENewMsgCData" ofType:@"plist"];
        NSArray * msgArr = [[NSArray alloc]initWithContentsOfFile:shadowPath];
        for (NSDictionary *msg in msgArr) {
            [self.mesArray addObject:msg];
        }
        [self.mesTableView reloadData];
    });
}


- (UITableView *)mesTableView{
    if (!_mesTableView) {
        _mesTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SESCREEN_Wid, SESCREEN_Hei - SESCREEN_Nav) style:UITableViewStylePlain];
        _mesTableView.delegate = self;
        _mesTableView.dataSource = self;
        _mesTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _mesTableView.backgroundColor = [UIColor blackColor];
        [_mesTableView registerNib:[UINib nibWithNibName:@"SEMesCenterTableViewCell" bundle:nil] forCellReuseIdentifier:@"SEMesCenterTableViewCell"];
    }
    return _mesTableView;
}
- (NSMutableArray *)mesArray{
    if (!_mesArray) {
        _mesArray = [[NSMutableArray alloc]init];
    }
    return _mesArray;
}

@end
