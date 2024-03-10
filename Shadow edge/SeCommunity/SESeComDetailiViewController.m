//
//  SESeComDetailiViewController.m
//  Shadow edge
//
//  Created by En Shuo on 2021/8/30.
//

#import "SESeComDetailiViewController.h"
#import <SDWebImage.h>
#import <SVProgressHUD.h>
@interface SESeComDetailiViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *CokCover;
@property (weak, nonatomic) IBOutlet UITextField *applyName;
@property (weak, nonatomic) IBOutlet UITextField *applyStyle;
@property (weak, nonatomic) IBOutlet UITextField *applyDate;
@property (weak, nonatomic) IBOutlet UITextField *applyPhone;

@end

@implementation SESeComDetailiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"参与详情";
    [self.CokCover sd_setImageWithURL:[NSURL URLWithString:self.seCommunity.seCooverC]];
    
    [self setTextFiledHolder:self.applyName PlaceholderStr:@"请输入您的姓名"];
    [self setTextFiledHolder:self.applyStyle PlaceholderStr:@"请输入您喜欢的影视风格"];
    [self setTextFiledHolder:self.applyDate PlaceholderStr:@"请输入您想看电影的日期"];
    [self setTextFiledHolder:self.applyPhone PlaceholderStr:@"请输入您的预留联系方式"];
}


- (IBAction)seComApplyToParticipate:(id)sender {
    if (self.applyName.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入您的姓名"];
        [SVProgressHUD dismissWithDelay:1.1];
        return;
    }
    if (self.applyStyle.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入您喜欢的影视风格"];
        [SVProgressHUD dismissWithDelay:1.1];
        return;
    }
    if (self.applyDate.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入您想看电影的日期"];
        [SVProgressHUD dismissWithDelay:1.1];
        return;
    }
    if (self.applyPhone.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入您的预留联系方式"];
        [SVProgressHUD dismissWithDelay:1.1];
        return;
    }
    [SVProgressHUD show];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
        [[NSUserDefaults standardUserDefaults]setValue:self.applyPhone forKey:@"shadowapplyParticipateCom"];
        [SVProgressHUD showSuccessWithStatus:@"提交申请成功，请等待发起人与您确定"];
        [SVProgressHUD dismissWithDelay:1.2 completion:^{
            [self.navigationController popViewControllerAnimated:YES];
        }];
    });
}

@end
