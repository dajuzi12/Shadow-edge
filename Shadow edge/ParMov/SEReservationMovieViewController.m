//
//  SEReservationMovieViewController.m
//  Shadow edge
//
//  Created by En Shuo on 2021/8/30.
//

#import "SEReservationMovieViewController.h"
#import <SVProgressHUD.h>
#import <MJExtension.h>
@interface SEReservationMovieViewController ()
@property (weak, nonatomic) IBOutlet UITextField *shaDowUserName;
@property (weak, nonatomic) IBOutlet UITextField *shaDowPhone;
@property (weak, nonatomic) IBOutlet UITextField *shaDowMovNum;
@property (weak, nonatomic) IBOutlet UITextField *shaDowMovDate;
@property (weak, nonatomic) IBOutlet UITextView *shaDowNote;

@end

@implementation SEReservationMovieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"预约信息";
    
    [self setTextFiledHolder:self.shaDowUserName PlaceholderStr:@"请输入您的姓名"];
    [self setTextFiledHolder:self.shaDowPhone PlaceholderStr:@"请输入您的预留联系方式"];
    [self setTextFiledHolder:self.shaDowMovNum PlaceholderStr:@"请输入您的观影人数"];
    [self setTextFiledHolder:self.shaDowMovDate PlaceholderStr:@"请输入您的观影日期"];
}

- (IBAction)shaDowreservaitonCaMovie:(id)sender {
    if (self.shaDowUserName.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入您的姓名"];
        [SVProgressHUD dismissWithDelay:1.1];
        return;
    }
    if (self.shaDowPhone.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入您的预留联系方式"];
        [SVProgressHUD dismissWithDelay:1.1];
        return;
    }
    if (self.shaDowMovNum.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入您的观影人数"];
        [SVProgressHUD dismissWithDelay:1.1];
        return;
    }
    if (self.shaDowMovDate.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入您的观影日期"];
        [SVProgressHUD dismissWithDelay:1.1];
        return;
    }
    if (self.shaDowNote.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入您的预约备注"];
        [SVProgressHUD dismissWithDelay:1.1];
        return;
    }
    [SVProgressHUD show];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
        NSString * shaDowMask= NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
        NSString * shadowPath = [shaDowMask stringByAppendingPathComponent:@"shaDowMyReservationMov.plist"];
        NSArray * resMovAll = [[NSArray alloc]initWithContentsOfFile:shadowPath];
        NSMutableArray* mutMov = [NSMutableArray arrayWithArray:resMovAll];
        [mutMov addObject:[self.selHotMOv mj_keyValues]];
        [mutMov writeToFile:shadowPath atomically:YES];
        [SVProgressHUD showSuccessWithStatus:@"预约成功，请与您预约的日期到店提供预留的手机号"];
        [SVProgressHUD dismissWithDelay:1.1 completion:^{
            [self.navigationController popViewControllerAnimated:YES];
        }];
    });
}

@end
