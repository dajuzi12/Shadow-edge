//
//  SEEdgeBaseViewController.m
//  Shadow edge
//
//  Created by En Shuo on 2021/8/26.
//

#import "SEEdgeBaseViewController.h"

@interface SEEdgeBaseViewController ()

@end

@implementation SEEdgeBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)setTextFiledHolder:(UITextField *)textField PlaceholderStr:(NSString *)str{
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:str attributes:
                                      @{NSForegroundColorAttributeName:[UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1],
                     NSFontAttributeName:textField.font
             }];
    textField.attributedPlaceholder = attrString;
}
@end
