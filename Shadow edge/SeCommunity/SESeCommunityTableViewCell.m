//
//  SESeCommunityTableViewCell.m
//  Shadow edge
//
//  Created by En Shuo on 2021/8/30.
//

#import "SESeCommunityTableViewCell.h"
#import <SDWebImage.h>
@implementation SESeCommunityTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setSeCom:(SESeCommuntiyModel *)seCom{
    _seCom = seCom;
    //load community
    [self.seComUserPic sd_setImageWithURL:[NSURL URLWithString:self.seCom.seUserPic]];
    [self.seComCoverB sd_setImageWithURL:[NSURL URLWithString:self.seCom.seCooverB]];
    [self.seComCoverV sd_setImageWithURL:[NSURL URLWithString:self.seCom.seCooverV]];
    [self.seComCoverC sd_setImageWithURL:[NSURL URLWithString:self.seCom.seCooverC]];
    self.seComlocDa.text = self.seCom.seCokText;
    self.seComTextInfo.text = self.seCom.seContentE;
    self.seComUserName.text = self.seCom.seUserName;
}
- (IBAction)seComThreeStarOp:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickThreeStarOp:)]) {
        [self.delegate clickThreeStarOp:self.idxPath];
    }
}
- (IBAction)seComGiveLike:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickGiveLike:)]) {
        [self.delegate clickGiveLike:self.idxPath];
    }
}
- (IBAction)seComApplyFor:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickApplyFor:)]) {
        [self.delegate clickApplyFor:self.idxPath];
    }
}

@end
