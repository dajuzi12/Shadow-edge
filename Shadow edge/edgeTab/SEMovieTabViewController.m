//
//  SEMovieTabViewController.m
//  Shadow edge
//
//  Created by En Shuo on 2021/8/26.
//

#import "SEMovieTabViewController.h"
#import "SEParMovieViewController.h"
#import "SESeCommunityViewController.h"
#import "SEMinedataViewController.h"
#import "SEMovieNavViewController.h"
#import "SEMyLogAccountViewController.h"
@interface SEMovieTabViewController ()<UITabBarControllerDelegate>

@end

@implementation SEMovieTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabBar.translucent = NO;
    self.delegate = self;
    self.tabBar.tintColor = [UIColor colorWithRed:97/255.0 green:35/255.0 blue:237/255.0 alpha:1];
    self.tabBar.backgroundColor = [UIColor blackColor];
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SESCREEN_Wid, SESCREEN_Tab)];
    bgView.backgroundColor = [UIColor blackColor];
    [self.tabBar insertSubview:bgView atIndex:0];
    
    SEParMovieViewController *parMovie = [[SEParMovieViewController alloc]init];
    SEMovieNavViewController *parNav = [[SEMovieNavViewController alloc] initWithRootViewController:parMovie];
    parNav.navigationBar.translucent = NO;
    [self addChildViewController:parNav];
    parNav.tabBarItem.image = [[UIImage imageNamed:@"evhome"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    parNav.tabBarItem.selectedImage = [[UIImage imageNamed:@"evhome-2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    SESeCommunityViewController *seCommunity = [[SESeCommunityViewController alloc]init];
    SEMovieNavViewController *seCommubityNav = [[SEMovieNavViewController alloc]initWithRootViewController:seCommunity];
    seCommubityNav.navigationBar.translucent = NO;
    [self addChildViewController:seCommubityNav];
    seCommubityNav.tabBarItem.image = [[UIImage imageNamed:@"evhuatizhuti"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    seCommubityNav.tabBarItem.selectedImage = [[UIImage imageNamed:@"evhuatizhuti-2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    SEMinedataViewController *mineData = [[SEMinedataViewController alloc]init];
    SEMovieNavViewController *mineDataNav = [[SEMovieNavViewController alloc]initWithRootViewController:mineData];
    mineDataNav.navigationBar.translucent = NO;
    [self addChildViewController:mineDataNav];
    mineDataNav.tabBarItem.image = [[UIImage imageNamed:@"evmine"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    mineDataNav.tabBarItem.selectedImage = [[UIImage imageNamed:@"evmine-2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    if ([tabBarController.childViewControllers indexOfObject:viewController] == 2) {
        NSString *shadowstatus = [[NSUserDefaults standardUserDefaults] objectForKey:@"sedowLogStatus"];
        if (shadowstatus == nil) {
            SEMyLogAccountViewController *myLogacc = [[SEMyLogAccountViewController alloc] initWithNibName:@"SEMyLogAccountViewController" bundle:nil];
            myLogacc.hidesBottomBarWhenPushed = YES;
            UINavigationController *navlog= [[UINavigationController alloc]initWithRootViewController:myLogacc];
            [navlog.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17.0],NSForegroundColorAttributeName:[UIColor blackColor]}];
            navlog.navigationBar.barTintColor = [UIColor whiteColor];
            [tabBarController.selectedViewController presentViewController:navlog animated:YES completion:nil];
            return NO;
        }
    }
    return YES;
}


@end
