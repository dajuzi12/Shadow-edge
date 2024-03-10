//
//  SEMesCenterTableViewCell.h
//  Shadow edge
//
//  Created by En Shuo on 2021/8/30.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SEMesCenterTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *mesTitle;
@property (weak, nonatomic) IBOutlet UILabel *mesContent;
@property (weak, nonatomic) IBOutlet UILabel *mesdate;

@end

NS_ASSUME_NONNULL_END
