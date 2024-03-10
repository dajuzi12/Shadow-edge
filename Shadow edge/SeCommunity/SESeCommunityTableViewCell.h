//
//  SESeCommunityTableViewCell.h
//  Shadow edge
//
//  Created by En Shuo on 2021/8/30.
//

#import <UIKit/UIKit.h>
#import "SESeCommuntiyModel.h"
NS_ASSUME_NONNULL_BEGIN
@protocol SECommunityChuDelegate <NSObject>

- (void)clickThreeStarOp:(NSIndexPath *)idxPath;
- (void)clickGiveLike:(NSIndexPath *)idxPath;
- (void)clickApplyFor:(NSIndexPath *)idxPath;

@end
@interface SESeCommunityTableViewCell : UITableViewCell
@property (nonatomic, strong) SESeCommuntiyModel *seCom;
@property (weak, nonatomic) IBOutlet UIImageView *seComUserPic;
@property (weak, nonatomic) IBOutlet UILabel *seComUserName;
@property (weak, nonatomic) IBOutlet UILabel *seComlocDa;
@property (weak, nonatomic) IBOutlet UILabel *seComTextInfo;
@property (weak, nonatomic) IBOutlet UIImageView *seComCoverC;
@property (weak, nonatomic) IBOutlet UIImageView *seComCoverV;
@property (weak, nonatomic) IBOutlet UIImageView *seComCoverB;
@property (nonatomic, strong) NSIndexPath *idxPath;
@property (nonatomic, weak) id<SECommunityChuDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
