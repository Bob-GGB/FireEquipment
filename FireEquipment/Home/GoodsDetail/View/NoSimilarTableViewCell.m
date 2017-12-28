//
//  NoSimilarTableViewCell.m
//  FireEquipment
//
//  Created by mc on 2017/12/20.
//  Copyright © 2017年 mc. All rights reserved.
//

#import "NoSimilarTableViewCell.h"

@implementation NoSimilarTableViewCell



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier ];
    if (self) {
        
        [self setUpAllUI];
    }
    
    return self;
}

-(void)setUpAllUI{
    UILabel *label=[UILabel new];
    
    label.textColor=[UIColor colorWithHexString:@"#282828"];
    label.font=[UIFont systemFontOfSize:14];
    label.textAlignment=NSTextAlignmentLeft;
    label.text=@"相似推荐";
    [self.contentView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.left.equalTo(@10);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth/3, 20));
    }];
    
    UIImageView *images=[UIImageView new];
//    images.backgroundColor=[UIColor redColor];
    [images setImage:[UIImage imageNamed:@"nodata"]];
    [self.contentView addSubview:images];
    [images mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(label.mas_bottom);
//        make.left.right.equalTo(@0);
//        make.height.equalTo(@160);
        make.center.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(80, 80));
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
