//
//  SEReleaseNewViewController.m
//  Shadow edge
//
//  Created by En Shuo on 2021/8/30.
//

#import "SEReleaseNewViewController.h"
#import <SVProgressHUD.h>
@interface SEReleaseNewViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextView *shadowPushInfo;
@property (weak, nonatomic) IBOutlet UITextField *shadowPushDate;
@property (weak, nonatomic) IBOutlet UITextField *shadowPushCity;
@property (weak, nonatomic) IBOutlet UIButton *shadowAddIgBtn;
@property (nonatomic, strong) UIImage *shadowImg;
@end

@implementation SEReleaseNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"发布活动";
    [self setTextFiledHolder:self.shadowPushCity PlaceholderStr:@"请输入城市"];
    [self setTextFiledHolder:self.shadowPushDate PlaceholderStr:@"请输入日期"];
    
}


- (IBAction)seClickReleaseNewCommunity:(id)sender {
    if (self.shadowPushInfo.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入您想说的话"];
        [SVProgressHUD dismissWithDelay:1.1];
        return;
    }
    if (self.shadowPushDate.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入日期"];
        [SVProgressHUD dismissWithDelay:1.1];
        return;
    }
    if (self.shadowPushCity.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入城市"];
        [SVProgressHUD dismissWithDelay:1.1];
        return;
    }
    if (!self.shadowImg) {
        [SVProgressHUD showErrorWithStatus:@"请添加图片"];
        [SVProgressHUD dismissWithDelay:1.1];
        return;
    }
    [SVProgressHUD show];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
        [[NSUserDefaults standardUserDefaults]setValue:self.shadowPushInfo.text forKey:@"shadowreleaseNewCom"];
        [SVProgressHUD showSuccessWithStatus:@"提交发布成功，您的发布内容将由平台进行审核，审核通过成功发布"];
        [SVProgressHUD dismissWithDelay:1.2 completion:^{
            [self.navigationController popViewControllerAnimated:YES];
        }];
    });
    
}
- (IBAction)seClickAddCoverImg:(id)sender {
    UIAlertController *selectImg = [UIAlertController alertControllerWithTitle:@"提示" message:@"请选择添加图片的方式" preferredStyle:UIAlertControllerStyleActionSheet];
    [selectImg addAction:[UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImagePickerController *shadowAImg = [[UIImagePickerController alloc]init];
        shadowAImg.sourceType = UIImagePickerControllerSourceTypeCamera;
        shadowAImg.allowsEditing = YES;
        shadowAImg.delegate = self;
        [self presentViewController:shadowAImg animated:YES completion:nil];
    }]];
    [selectImg addAction:[UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImagePickerController *shadowBImg = [[UIImagePickerController alloc] init];
        shadowBImg.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        shadowBImg.allowsEditing = YES;
        shadowBImg.delegate = self;
        [self presentViewController:shadowBImg animated:YES completion:nil];
    }]];
    [selectImg addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self presentViewController:selectImg animated:YES completion:nil];
    
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    self.shadowImg = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    [self.shadowAddIgBtn setImage:self.shadowImg forState:UIControlStateNormal];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
