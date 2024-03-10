//
//  SEParMovieTableViewCell.h
//  Shadow edge
//
//  Created by En Shuo on 2021/8/27.
//

#import <UIKit/UIKit.h>
#import "SEHotMovModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface SEParMovieTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *movName;
@property (weak, nonatomic) IBOutlet UILabel *movPlaceLoa;
@property (weak, nonatomic) IBOutlet UIImageView *movCovImg;
@property (weak, nonatomic) IBOutlet UILabel *movClient;
@property (nonatomic, strong) SEHotMovModel *moveModel;
@end

NS_ASSUME_NONNULL_END
