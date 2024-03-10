//
//  SEParMovieTableViewCell.m
//  Shadow edge
//
//  Created by En Shuo on 2021/8/27.
//

#import "SEParMovieTableViewCell.h"
#import <SDWebImage.h>
@implementation SEParMovieTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setMoveModel:(SEHotMovModel *)moveModel{
    _moveModel = moveModel;
    [self.movCovImg sd_setImageWithURL:[NSURL URLWithString:self.moveModel.movCover]];
    self.movName.text = self.moveModel.movName;
    self.movPlaceLoa.text = [NSString stringWithFormat:@"地址: %@",self.moveModel.movPlace];
    self.movClient.text = [NSString stringWithFormat:@"%@人去过",self.moveModel.movClientele];
}
@end
