//
//  SEEdgeBaseViewController.h
//  Shadow edge
//
//  Created by En Shuo on 2021/8/26.
//

#import <UIKit/UIKit.h>

#define SESCREEN_Wid [UIScreen mainScreen].bounds.size.width
#define SESCREEN_Hei [UIScreen mainScreen].bounds.size.height
#define Is_iphone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define Is_iPhoneX SESCREEN_Wid >=375.0f && SESCREEN_Hei >=812.0f&& Is_iphone
#define SESCREEN_Nav (CGFloat)(Is_iPhoneX?(88.0):(64.0))
#define SESCREEN_Tab (CGFloat)(Is_iPhoneX?(49.0 + 34.0):(49.0))

NS_ASSUME_NONNULL_BEGIN

@interface SEEdgeBaseViewController : UIViewController
- (void)setTextFiledHolder:(UITextField *)textField PlaceholderStr:(NSString *)str;
@end

NS_ASSUME_NONNULL_END
