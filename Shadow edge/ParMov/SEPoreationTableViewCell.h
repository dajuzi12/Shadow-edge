//
//  SEPoreationTableViewCell.h
//  Shadow edge
//
//  Created by En Shuo on 2021/8/27.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol SEPoreationDelegate <NSObject>

- (void)poreationClickRealseAct;
- (void)poreationClickCommunityDy;
- (void)poreationClickFeedback;

@end
@interface SEPoreationTableViewCell : UITableViewCell
@property (nonatomic, weak) id<SEPoreationDelegate> seDelegate;
@end

NS_ASSUME_NONNULL_END
