//
//  SEFFImaViewController.m
//  Shadow edge
//
//  Created by Rain on 2021/9/27.
//

#import "SEFFImaViewController.h"

#import "QYHttpManager.h"
#import <SDWebImage/SDWebImage.h>

#import "SEMovieTabViewController.h"
#import "AppDelegate.h"
@interface SEFFImaViewController ()
@property(nonatomic,strong)UIImageView * imageview;
@end

@implementation SEFFImaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView * bgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    bgView.image = [UIImage imageNamed:@"qidongye"];
    [bgView setUserInteractionEnabled:YES];
    [self.view addSubview:bgView];
    
    self.imageview = [[UIImageView alloc]init];
    self.imageview.frame = CGRectMake(10, 35, self.view.frame.size.width -20, self.view.frame.size.height - 70);
    self.imageview.contentMode = UIViewContentModeScaleAspectFit;
    
    [bgView addSubview:self.imageview];
    
    [self lanuanchAction];
    
}

//数据请求跳转
-(void)lanuanchAction {
    
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    

    [QYHttpManager postWithUrl:@"v1/app/batchNumber/info" jsonParameters:@{@"series":@"c1fed9c8-b232-4c85-a7ec-8843bf9303ef",@"version":app_Version} progressShow:NO success:^(id responseObject) {
        
        if(responseObject) {
   
            NSLog(@"mymodel===%@",responseObject[@"data"][@"isReplace"]);
            NSString * isReplace = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"isReplace"]];
            
            if ([isReplace isEqualToString:@"0"]) {
           
                AppDelegate * appDelagete = [UIApplication sharedApplication].delegate;
                
                SEMovieTabViewController *semovieTabBase = [[SEMovieTabViewController alloc] init];
                appDelagete.window.rootViewController = semovieTabBase;
                
                
            }else{

                self.imgURL = [NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%@",responseObject[@"data"][@"appBackgroundUrl"]]];

                self.ClickApp = [NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%@",responseObject[@"data"][@"appReplaceUrl"]]];
                [self.imageview sd_setImageWithURL:[NSURL URLWithString:self.imgURL]];
                [self.imageview setUserInteractionEnabled:YES];
                [self.imageview addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickCategory:)]];

            }
      
     
        }else {
       
            AppDelegate * appDelagete = [UIApplication sharedApplication].delegate;
            
            SEMovieTabViewController *semovieTabBase = [[SEMovieTabViewController alloc] init];
            appDelagete.window.rootViewController = semovieTabBase;
        }

        
     
    } failure:^(NSError *error) {
        NSLog(@"%@", [error localizedDescription]);
        AppDelegate * appDelagete = [UIApplication sharedApplication].delegate;
        
        SEMovieTabViewController *semovieTabBase = [[SEMovieTabViewController alloc] init];
        appDelagete.window.rootViewController = semovieTabBase;
    }];
    
   


}
-(void)clickCategory:(UITapGestureRecognizer *)gestureRecognizer
{
    NSLog(@"click");
    
    NSURL *url = [NSURL URLWithString:self.ClickApp];

    [[UIApplication sharedApplication] openURL:url];

}



@end
