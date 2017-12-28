//
//  LeftTableViewCell.m
//  FireEquipment
//
//  Created by mc on 2017/12/4.
//  Copyright © 2017年 mc. All rights reserved.
//

#import "LeftTableViewCell.h"
#import "UILabel+XFLabel.h"
@implementation LeftTableViewCell



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatAllUI];
    }
    return self;
}

-(void)creatAllUI{
    self.headImageView =[UIImageView new];
    [self.headImageView.layer setMasksToBounds:YES];
    [self.headImageView.layer setCornerRadius:20];
//    self.headImageView.backgroundColor=[UIColor redColor];
    [self.contentView addSubview:self.headImageView];
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@5);
        make.left.equalTo(@10);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    
    self.nameLabel=[UILabel new];
    self.nameLabel.font=[UIFont systemFontOfSize:15.0f];
    self.nameLabel.textColor=[UIColor colorWithHexString:@"#282828"];
    self.nameLabel.textAlignment=NSTextAlignmentCenter;
    [self.nameLabel.layer setMasksToBounds:YES];
    [self.nameLabel.layer setCornerRadius:15];
    self.nameLabel.text=@"警戒器材哈哈";
    [self.contentView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(12);
        make.left.equalTo(self.headImageView.mas_right).offset(10);
        make.size.mas_equalTo(CGSizeMake([UILabel getWidthWithTitle:self.nameLabel.text font:[UIFont systemFontOfSize:13]],30));
    }];
    UIView *lineView=[UIView new];
    [lineView setBackgroundColor:[UIColor colorWithHexString:@"#f2f2f2"]];
    [self.contentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.right.equalTo(@(-1));
        make.size.mas_equalTo(CGSizeMake(1, 60));
    }];
    
    
}











- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    if(selected) {
        [self.nameLabel setBackgroundColor:[UIColor colorWithHexString:@"#c8996b"]];
         self.nameLabel.textColor=[UIColor whiteColor];
               }
    else{
        [self.nameLabel setBackgroundColor:[UIColor whiteColor]];
         self.nameLabel.textColor=[UIColor colorWithHexString:@"#282828"];
    }
}

@end
