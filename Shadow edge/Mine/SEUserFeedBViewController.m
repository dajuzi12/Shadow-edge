//
//  SEUserFeedBViewController.m
//  Shadow edge
//
//  Created by En Shuo on 2021/8/31.
//

#import "SEUserFeedBViewController.h"
#import <SVProgressHUD.h>
@interface SEUserFeedBViewController ()
@property (weak, nonatomic) IBOutlet UITextView *userFeedContent;

@end

@implementation SEUserFeedBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"意见反馈";
}

- (IBAction)clickSubmitUserFeedb:(id)sender {
    if (self.userFeedContent.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入您的反馈"];
        [SVProgressHUD dismissWithDelay:1.1];
        return;
    }
    [SVProgressHUD show];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
        [[NSUserDefaults standardUserDefaults]setValue:self.userFeedContent.text forKey:@"shadowFeedback"];
        [SVProgressHUD showSuccessWithStatus:@"反馈成功"];
        [SVProgressHUD dismissWithDelay:1.1 completion:^{
            [self.navigationController popViewControllerAnimated:YES];
        }];
    });
}


@end
