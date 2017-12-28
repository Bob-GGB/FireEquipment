//
//  BoughtInfoBtnTableViewCell.m
//  FireEquipment
//
//  Created by mc on 2017/11/30.
//  Copyright © 2017年 mc. All rights reserved.
//

#import "BoughtInfoBtnTableViewCell.h"
#import "UIButton+ImageTitleSpacing.h"
@implementation BoughtInfoBtnTableViewCell

-(instancetype)initWithTitleArr:(NSArray *)titleArr andImageArr:(NSArray *)imageArr andBadgeArr:(NSArray *)badgeArr{
    
    self=[super init];
    
    if (self) {
        [self setBackgroundColor:[UIColor whiteColor]];
      
            [self setUpAllUIWithTitleArr:titleArr andImageArr:imageArr andBadgeArr:badgeArr];
    }
    return self;
    
}


//-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
//    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
//    if (self) {
//        [self setUpAllUI];
//    }
//    return self;
//}

-(void)setUpAllUIWithTitleArr:(NSArray *)titleArr andImageArr:(NSArray *)imageArr andBadgeArr:(NSArray *)badgeArr{
//    NSArray *arr=@[@"hetong.png",@"daifahuo.png",@"daishouhuo.png",@"daipingjia.png"];
//    NSArray *titleArr=@[@"签订合同",@"待发货",@"待收货",@"待评价"];
    
//    NSArray *arr=@[@"hetong.png",@"daifahuo.png",@"daishouhuo.png",@"daipingjia.png"];
//    NSArray *titleArr=@[@"已入库",@"审核中",@"审核通过",@"审核不通过"];
    CGFloat space=0;
    for (int i=0; i<titleArr.count; i++) {
        _Btn=[UIButton buttonWithType:UIButtonTypeCustom];
        _Btn.tag=100+i;
        [_Btn setImage:[UIImage imageNamed:imageArr[i]] forState:UIControlStateNormal];
        _Btn.frame=CGRectMake((kScreenWidth/4)*i, 10, kScreenWidth/4, 50);
        [_Btn setTitle:titleArr[i] forState:UIControlStateNormal];
        _Btn.titleLabel.font=[UIFont systemFontOfSize:14];
        //        [_shopCarButton setBackgroundColor:[UIColor redColor]];
        [_Btn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:space];
        [_Btn setTitleColor:[UIColor colorWithHexString:@"#9e9e9e"] forState:UIControlStateNormal];
        [_Btn addTarget:self action:@selector(ButtonDidPress:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_Btn];
        [_Btn pp_addBadgeWithNumber:[badgeArr[i] integerValue]];
//         调整badge颜色
        [_Btn pp_setBadgeLabelAttributes:^(PPBadgeLabel *badgeLabel) {
            badgeLabel.backgroundColor =[UIColor colorWithHexString:@"#b6463b"];
            //        badgeLabel.font =  [UIFont systemFontOfSize:13];
            //        badgeLabel.textColor = [UIColor blueColor];
        }];
//         调整badge的位置
            [_Btn pp_moveBadgeWithX:-30 Y:5];
        
    }

}






-(void)ButtonDidPress:(UIButton *)sender{
    
//    NSLog(@"%ld",sender.tag);
    if (sender.tag==100) {
        [sender pp_decreaseBy:1000000000000];
    }
   
}


- (void)awakeFromNib {
    [super awakeFromNib];
   
}



@end
