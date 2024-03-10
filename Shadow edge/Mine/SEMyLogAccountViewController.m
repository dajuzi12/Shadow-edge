//
//  SEMyLogAccountViewController.m
//  Shadow edge
//
//  Created by En Shuo on 2021/8/27.
//

#import "SEMyLogAccountViewController.h"
#import <SVProgressHUD.h>
#import "SEMyRegisterAccountViewController.h"
#import "SEMyUserAgreementViewController.h"
@interface SEMyLogAccountViewController ()
@property (weak, nonatomic) IBOutlet UITextField *logUsernamee;
@property (weak, nonatomic) IBOutlet UITextField *logUserPas;

@end

@implementation SEMyLogAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"登录";
    
    UIButton * back = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 39, 35)];
    [back setTitle:@"back" forState:UIControlStateNormal];
    [back setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [back addTarget:self action:@selector(backAppVc) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:back];
    self.navigationItem.leftBarButtonItem = item;
}

- (void)backAppVc{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)shadowLogAcc:(id)sender {
    
    if (self.logUsernamee.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入登录用户名"];
        [SVProgressHUD dismissWithDelay:1.1];
        return;
    }
    if (self.logUserPas.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入登录密码"];
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
        NSString * shadowcodePath = [[NSBundle mainBundle] pathForResource:@"SEMubUser" ofType:@"plist"];
        NSArray * mbArr = [[NSArray alloc]initWithContentsOfFile:shadowcodePath];
        [mutReUser addObjectsFromArray:mbArr];
        for (NSDictionary *uDic in mutReUser) {
            if ([uDic[@"shadoeEdgeUser"] isEqualToString:self.logUsernamee.text] && [uDic[@"shadoeEdgePSd"] isEqualToString:self.logUserPas.text]) {
                [[NSUserDefaults standardUserDefaults]setValue:uDic[@"shadoeEdgeUser"] forKey:@"sedowLogStatus"];
                [[NSUserDefaults standardUserDefaults]setValue:uDic[@"shadoeEdgeNick"] forKey:@"sedowUserName"];
                [[NSUserDefaults standardUserDefaults]setValue:uDic[@"shadoeEdgeUserPic"] forKey:@"sedowUserPic"];
                [SVProgressHUD showSuccessWithStatus:@"登录成功"];
                [SVProgressHUD dismissWithDelay:1.1 completion:^{
                    [self dismissViewControllerAnimated:YES completion:nil];
                }];
                return;
            }
        }
        [SVProgressHUD showErrorWithStatus:@"登录失败，请检查用户名或密码是否正确"];
        [SVProgressHUD dismissWithDelay:1.2 completion:^{
        }];
    });
}
- (IBAction)shadowRegisterAcc:(id)sender {
    SEMyRegisterAccountViewController *regisAccount = [[SEMyRegisterAccountViewController alloc]init];
    [self.navigationController pushViewController:regisAccount animated:YES];
}

- (IBAction)agreeUserProtocol:(id)sender {
    SEMyUserAgreementViewController *myUserAgreement = [[SEMyUserAgreementViewController alloc]init];
    [self.navigationController pushViewController:myUserAgreement animated:YES];
}

@end
