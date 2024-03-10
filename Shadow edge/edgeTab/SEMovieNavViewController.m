//
//  SEMovieNavViewController.m
//  Shadow edge
//
//  Created by En Shuo on 2021/8/26.
//

#import "SEMovieNavViewController.h"

@interface SEMovieNavViewController ()

@end

@implementation SEMovieNavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBar.translucent = NO;
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    [UIBarButtonItem appearance].tintColor = [UIColor whiteColor];

    [[UIBarButtonItem appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} forState:UIControlStateNormal];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.childViewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

@end
