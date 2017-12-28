//
//  NomalTableViewCell.m
//  FireEquipment
//
//  Created by mc on 2017/11/29.
//  Copyright © 2017年 mc. All rights reserved.
//

#import "NomalTableViewCell.h"

@implementation NomalTableViewCell



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier ];
    if (self) {
        
        [self setUpAllUI];
    }
    
    return self;
}
-(void)setUpAllUI{
    self.iconImageView =[UIImageView new];
    [self.contentView addSubview:self.iconImageView];
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(@10);
        make.size.mas_equalTo(CGSizeMake(30, 30));
        
    }];
    self.titleLabel=[UILabel new];
    self.titleLabel.textColor=[UIColor colorWithHexString:@"#282828"];
    self.titleLabel.font=[UIFont systemFontOfSize:15.0f];
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iconImageView.mas_top);
        make.left.equalTo(self.iconImageView.mas_right).offset(15);
        make.size.mas_equalTo(CGSizeMake(100, 30));
        
    }];
    self.vertionLabel=[UILabel new];
    self.vertionLabel.textColor=[UIColor colorWithHexString:@"#989898"];
    self.vertionLabel.font=[UIFont systemFontOfSize:13.0f];
    self.vertionLabel.textAlignment=NSTextAlignmentRight;
    [self.contentView addSubview:self.vertionLabel];
    [self.vertionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iconImageView.mas_top);
        make.right.equalTo(@(-10));
        make.size.mas_equalTo(CGSizeMake(70, 30));
        
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
