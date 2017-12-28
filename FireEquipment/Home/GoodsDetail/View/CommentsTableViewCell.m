//
//  CommentsTableViewCell.m
//  FireEquipment
//
//  Created by mc on 2017/11/27.
//  Copyright © 2017年 mc. All rights reserved.
//

#import "CommentsTableViewCell.h"

@implementation CommentsTableViewCell



-(void)bindDataWithModel:(CommentsModel *)model{
    
    NSArray *array = [model.time componentsSeparatedByString:@" "]; //从字符A中分隔成2个元素的数组
     NSArray *array1 = [model.addtime componentsSeparatedByString:@" "]; //从字符A中分隔成2个元素的数组
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:model.thumb]];
    self.nameLabel.text=model.userName;
    if (model.addtime) {
          self.timeLabel.text=array1[0];
    }
    else{
    self.timeLabel.text=array[0];
    }
    self.commentLabel.text=model.content;
    
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier ];
    if (self) {
        
        [self setUpAllUI];
    }
    
    return self;
}


-(void)setUpAllUI{
    self.headImageView =[[UIImageView alloc] init];
//    [self.headImageView setBackgroundColor:[UIColor redColor]];
    [self.headImageView.layer setMasksToBounds:YES];
    [self.headImageView.layer setCornerRadius:20];
    [self.contentView addSubview:self.headImageView];
    
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@10);
        make.left.equalTo(@10);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    
    self.nameLabel=[[UILabel alloc] init];
    [self.nameLabel setFont:[UIFont systemFontOfSize:13]];
    [self.nameLabel setTextColor:[UIColor colorWithHexString:@"#282828"]];
//    [self.nameLabel setText:@"水电费二无热无若翁热无"];
    [self.contentView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headImageView.mas_top).offset(10);
        make.left.equalTo(self.headImageView.mas_right).offset(10);
        make.size.mas_equalTo(CGSizeMake(110, 20));
    }];
    self.commentLabel =[[UILabel alloc] init];
    [self.commentLabel setFont:[UIFont systemFontOfSize:15]];
    [self.commentLabel setTextColor:[UIColor colorWithHexString:@"#282828"]];
//    [self.commentLabel setText:@"¥200"];
    [self.commentLabel setTextAlignment:NSTextAlignmentLeft];
    [self.commentLabel setNumberOfLines:0];
    [self.contentView addSubview:self.commentLabel];
    
    [self.commentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headImageView.mas_bottom).offset(5);
        make.left.equalTo(self.headImageView.mas_left).offset(10);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth-20, 40));
    }];
    self.timeLabel =[[UILabel alloc] init];
    [self.timeLabel setFont:[UIFont systemFontOfSize:12]];
    [self.timeLabel setTextColor:[UIColor colorWithHexString:@"#989898"]];
//    [self.timeLabel setText:@"¥200"];
    [self.timeLabel setTextAlignment:NSTextAlignmentLeft];
    [self.contentView addSubview:self.timeLabel];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLabel.mas_top);
        make.left.equalTo(@(kScreenWidth-90));
        make.size.mas_equalTo(CGSizeMake(80, 15));
    }];
    
}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
