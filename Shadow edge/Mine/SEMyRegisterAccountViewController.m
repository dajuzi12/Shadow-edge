//
//  SEMyRegisterAccountViewController.m
//  Shadow edge
//
//  Created by En Shuo on 2021/8/27.
//

#import "SEMyRegisterAccountViewController.h"
#import <SVProgressHUD.h>
@interface SEMyRegisterAccountViewController ()
@property (weak, nonatomic) IBOutlet UITextField *resUsername;
@property (weak, nonatomic) IBOutlet UITextField *resUserPas;
@property (weak, nonatomic) IBOutlet UITextField *resConfirmPas;

@end

@implementation SEMyRegisterAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"注册新用户";
}


- (IBAction)shadowUserRegisterClick:(id)sender {
    if (self.resUsername.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入注册用户名"];
        [SVProgressHUD dismissWithDelay:1.1];
        return;
    }
    if (self.resUserPas.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入注册密码"];
        [SVProgressHUD dismissWithDelay:1.1];
        return;
    }
    if (self.resConfirmPas.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入确认密码"];
        [SVProgressHUD dismissWithDelay:1.1];
        return;
    }
    if (![self.resUserPas.text isEqualToString:self.resConfirmPas.text]) {
        [SVProgressHUD showErrorWithStatus:@"两次密码输入不一致"];
        [SVProgressHUD dismissWithDelay:1.1];
        return;
    }
    [SVProgressHUD show];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
        NSString * shaDowMask= NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
        NSString * shadowPath = [shaDowMask stringByAppendingPathComponent:@"shaDowERegisterAcc.plist"];
        NSArray * regisUserAll = [[NSArray alloc]initWithContentsOfFile:shadowPath];
        NSMutableArray* mutReUser = [NSMutableArray arrayWithArray:regisUserAll];
        NSMutableDictionary *shaDic = [[NSMutableDictionary alloc]init];
        [shaDic setValue:self.resUsername.text forKey:@"shadoeEdgeUser"];
        [shaDic setValue:@"Vuho Rews" forKey:@"shadoeEdgeNick"];
        [shaDic setValue:self.resUserPas.text forKey:@"shadoeEdgePSd"];
        [shaDic setValue:@"https://img2.woyaogexing.com/2021/08/25/01ef25b1815b46e8a4063ba8a17e8dc9!400x400.jpeg" forKey:@"shadoeEdgeUserPic"];
        [mutReUser addObject:shaDic];
        [mutReUser writeToFile:shadowPath atomically:YES];
        [SVProgressHUD showSuccessWithStatus:@"注册成功"];
        [SVProgressHUD dismissWithDelay:1.2 completion:^{
            [self.navigationController popViewControllerAnimated:YES];
        }];
    });
}


@end
