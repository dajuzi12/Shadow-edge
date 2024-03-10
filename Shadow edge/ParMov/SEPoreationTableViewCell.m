//
//  SEPoreationTableViewCell.m
//  Shadow edge
//
//  Created by En Shuo on 2021/8/27.
//

#import "SEPoreationTableViewCell.h"

@implementation SEPoreationTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)seReleaseNewActivity:(id)sender {
    if (self.seDelegate && [self.seDelegate respondsToSelector:@selector(poreationClickRealseAct)]) {
        [self.seDelegate poreationClickRealseAct];
    }
}
- (IBAction)seToCommunitydymic:(id)sender {
    if (self.seDelegate && [self.seDelegate respondsToSelector:@selector(poreationClickCommunityDy)]) {
        [self.seDelegate poreationClickCommunityDy];
    }
}
- (IBAction)seToCommentTheApp:(id)sender {
    if (self.seDelegate && [self.seDelegate respondsToSelector:@selector(poreationClickFeedback)]) {
        [self.seDelegate poreationClickFeedback];
    }
}

@end
