//
//
//  TopMenu
//
//  Created by home on 2017/9/29.
//  Copyright © 2017年 home. All rights reserved.
//

#import "NormalCell.h"
#import "Masonry.h"
#define kWidth  [UIScreen mainScreen].bounds.size.width
@interface NormalCell()
@property(nonatomic,strong) UIImageView * imageView;
@property(nonatomic,strong) UILabel * name;

@property(nonatomic,strong) UILabel * price;
@end
@implementation NormalCell


-(void)bindDataWithModel:(ProductListModel *)model{
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.titleImage]];
    self.name.text=model.name;
//    self.comName.text=model.sellerName;
    self.price.text=model.price;
    //    self.countLabel.text=model.
    
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor=[UIColor whiteColor];
        [self makeUI];
    }
    return self;
}
-(void)makeUI{
    self.imageView = ({
        UIImageView * imageView = [UIImageView new];
        [imageView setBackgroundColor:[UIColor redColor]];
        [self.contentView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(self.frame.size.width);
            make.centerX.equalTo(self);
        }];
        imageView;
    });
    self.name = ({
        UILabel * name = [UILabel new];
        name.text = @"iPhoneX";
        name.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:name];
        [name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_imageView.mas_bottom).offset(5);
            make.left.equalTo(@10);
            make.right.equalTo(@-10);
        }];
        name;
    });
    
    self.price = ({
        UILabel * price = [UILabel new];
        price.text = @"¥9999";
        price.textColor = [UIColor colorWithHexString:@"#b6463b"];
        price.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:price];
        [price mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_name.mas_bottom).offset(5);
            make.left.equalTo(@10);
            make.right.equalTo(@-10);
        }];
        price;
    });
}
-(void)reloadDatewith:(NSDictionary*)dict{
    
}
@end
