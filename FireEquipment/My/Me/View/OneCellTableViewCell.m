//
//  OneCellTableViewCell.m
//  FireEquipment
//
//  Created by mc on 2017/11/29.
//  Copyright © 2017年 mc. All rights reserved.
//

#import "OneCellTableViewCell.h"

@implementation OneCellTableViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUpAllUI];
    }
    return self;
}

-(void)setUpAllUI{
    
    self.namelabel=[UILabel new];
    self.namelabel.textColor=[UIColor colorWithHexString:@"#9e9e9e"];
    self.namelabel.font=[UIFont systemFontOfSize:14.0f];
    [self.contentView addSubview:self.namelabel];
    [self.namelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom);
        make.left.equalTo(@10);
        make.size.mas_equalTo(CGSizeMake(100, 30));
        
    }];
    self.lookLabel=[UILabel new];
    self.lookLabel.textColor=[UIColor colorWithHexString:@"#9e9e9e"];
    self.lookLabel.font=[UIFont systemFontOfSize:14.0f];
    [self.contentView addSubview:self.lookLabel];
    
    [self.lookLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.right.equalTo(@0);
        make.size.mas_equalTo(CGSizeMake(70, 30));
    }];
    UIView *uView=[UIView new];
    [self.contentView addSubview:uView];
    uView.backgroundColor=[UIColor colorWithHexString:@"#9e9e9e"];
    uView.alpha=0.3;
    [uView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@(-0.5));
        make.left.equalTo(@0);
        make.height.equalTo(@0.5);
        make.width.equalTo(@(kScreenWidth));
    }];
    
    
}


-(void)ButtonDidPress{
    
    
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
