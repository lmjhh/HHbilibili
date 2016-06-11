//
//  CommonsTableViewCell.m
//  高仿BiLibili
//
//  Created by 黄人煌 on 16/6/2.
//  Copyright © 2016年 黄人煌. All rights reserved.
//

#import "CommonsTableViewCell.h"

@interface CommonsTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *userFaceImageView;
@property (weak, nonatomic) IBOutlet UIImageView *userLevelImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *commonLevel;
@property (weak, nonatomic) IBOutlet UILabel *commonTime;
@property (weak, nonatomic) IBOutlet UIImageView *commonImage;
@property (weak, nonatomic) IBOutlet UILabel *commonCountLabel;
@property (weak, nonatomic) IBOutlet UIImageView *likeImage;
@property (weak, nonatomic) IBOutlet UILabel *likeCountLabel;
@property (weak, nonatomic) IBOutlet UIButton *moreButton;
@property (weak, nonatomic) IBOutlet UILabel *commonLabel;
@property (weak, nonatomic) IBOutlet UIView *likeView;

@property (weak, nonatomic) IBOutlet UIView *replyView;



@end

@implementation CommonsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.backgroundColor = BBackgroundColor;
    self.likeView.backgroundColor = BBackgroundColor;
    self.replyView.backgroundColor = BBackgroundColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setData:(ReplyDataModel *)data{
    
    _data = data;
    [self.userFaceImageView sd_setImageWithURL:[NSURL URLWithString:self.data.face] placeholderImage:BPlachIcon];
    [self.userLevelImageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"misc_level_whiteLv%ld_22x11_",(long)data.level_info.current_level]]];
    [self.userNameLabel setText:data.nick];
    [self.commonLevel setText:[NSString stringWithFormat:@"#%ld",(long)data.lv]];
    NSDate *date = [[NSDate alloc]initWithTimeIntervalSince1970:data.create];
    self.commonTime.text = [date getTimeDistance];
    [self.commonCountLabel setText:[NSString stringWithFormat:@"%@",data.reply_count]];
    self.likeCountLabel.text = [NSString stringWithFormat:@"%ld",(long)data.good];
    self.commonLabel.text = data.msg;
    CGSize commonSize = [self.commonLabel boundingRectWithSize:CGSizeMake(BScreen_Width - CGRectGetMinX(self.userNameLabel.frame) -15, 0)];
    self.commonLabel.frame = CGRectMake(CGRectGetMinX(self.userNameLabel.frame),CGRectGetMaxY(self.commonTime.frame)+5,commonSize.width, commonSize.height);
    
    self.frame = CGRectMake(0, 0, BScreen_Width,CGRectGetMaxY(self.commonLabel.frame)+15);
    self.contentView.frame = CGRectMake(0, 0, BScreen_Width,CGRectGetMaxY(self.commonLabel.frame)+15);
    
    self.separatorInset = UIEdgeInsetsMake(0, self.commonLabel.frame.origin.x, 0, 0);
    
    [self layoutSubviews];
    
}

- (void)layoutSubviews{
    

    
    self.moreButton.frame = CGRectMake(BScreen_Width - 30, 15, 15, 15);
    self.likeView.frame = CGRectMake(CGRectGetMinX(self.moreButton.frame) - 55, 13, 55, 20);
    self.replyView.frame = CGRectMake(CGRectGetMinX(self.likeView.frame) - 55, 13, 55, 20);
    
}

@end
