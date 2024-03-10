//
//  SEMovieCaDetailViewController.m
//  Shadow edge
//
//  Created by En Shuo on 2021/8/27.
//

#import "SEMovieCaDetailViewController.h"
#import <SDWebImage.h>
#import "SEMyLogAccountViewController.h"
#import <SVProgressHUD.h>
#import "SEReservationMovieViewController.h"
@interface SEMovieCaDetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *movCaCover;
@property (weak, nonatomic) IBOutlet UILabel *movCaName;
@property (weak, nonatomic) IBOutlet UILabel *movCaPlace;
@property (weak, nonatomic) IBOutlet UILabel *movCaClientele;
@property (weak, nonatomic) IBOutlet UILabel *movCaDetail;
@property (weak, nonatomic) IBOutlet UIImageView *movCaViewJ;
@property (weak, nonatomic) IBOutlet UIImageView *movCaViewM;

@end

@implementation SEMovieCaDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"详情";
    [self.movCaCover sd_setImageWithURL:[NSURL URLWithString:self.movModel.movCover]];
    self.movCaName.text = self.movModel.movName;
    self.movCaPlace.text = self.movModel.movPlace;
    self.movCaDetail.text = self.movModel.movIntrocul;
    self.movCaClientele.text = [NSString stringWithFormat:@"%@人去过",self.movModel.movClientele];
    [self.movCaViewJ sd_setImageWithURL:[NSURL URLWithString:self.movModel.movReviewJ]];
    [self.movCaViewM sd_setImageWithURL:[NSURL URLWithString:self.movModel.movReviewM]];
    
}

- (IBAction)seReservationParMoive:(id)sender {
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"sedowLogStatus"] == nil) {
        SEMyLogAccountViewController *myLogacc = [[SEMyLogAccountViewController alloc] initWithNibName:@"SEMyLogAccountViewController" bundle:nil];
        myLogacc.hidesBottomBarWhenPushed = YES;
        UINavigationController *navlog= [[UINavigationController alloc]initWithRootViewController:myLogacc];
        [navlog.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17.0],NSForegroundColorAttributeName:[UIColor blackColor]}];
        navlog.navigationBar.barTintColor = [UIColor whiteColor];
        [self presentViewController:navlog animated:YES completion:nil];
        return;
    }
    SEReservationMovieViewController *seReservatioMov = [[SEReservationMovieViewController alloc]init];
    seReservatioMov.selHotMOv = self.movModel;
    [self.navigationController pushViewController:seReservatioMov animated:YES];
}



@end
