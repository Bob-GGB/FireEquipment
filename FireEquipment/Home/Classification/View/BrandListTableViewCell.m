//
//  BrandListTableViewCell.m
//  FireEquipment
//
//  Created by mc on 2017/11/23.
//  Copyright © 2017年 mc. All rights reserved.
//

#import "BrandListTableViewCell.h"

@implementation BrandListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatUI];
    }
    return self;
}
-(void)creatUI{
    self.selectBtn=[UIButton buttonWithType:UIButtonTypeCustom];
   
    [self.selectBtn addTarget:self action:@selector(selectBtnDidPress:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.selectBtn];

    [self.selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    self.nameLabel=[[UILabel alloc] init];
    self.nameLabel.textColor=[UIColor colorWithHexString:@"#282828"];
    self.nameLabel.font=[UIFont systemFontOfSize:14];
    [self.nameLabel setTextAlignment:NSTextAlignmentLeft];
    [self.contentView addSubview:self.nameLabel];
//    [self.nameLabel setBackgroundColor:[UIColor redColor]];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.selectBtn.mas_right);
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth*0.75, 30));
        
    }];
}

-(void)selectBtnDidPress:(UIButton *)sender{
    
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    if (selected) {
         [self.selectBtn setImage:[UIImage imageNamed:@"xuanzhongs.png"] forState:UIControlStateNormal];
    }
    else{
        [self.selectBtn setImage:[UIImage imageNamed:@"hhh"] forState:UIControlStateNormal];
    }
    
}

@end
