//
//  SimilarTableViewCell.h
//  FireEquipment
//
//  Created by mc on 2017/11/27.
//  Copyright © 2017年 mc. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol  delegateColl <NSObject>

-(void)ClickCooRow :(NSInteger)CellRow andProductNum:(NSInteger)productnum;
-(void)ClickCooRow :(NSInteger)CellRow;
@end
@interface SimilarTableViewCell : UITableViewCell
/**
 *  数据源数组用来接受controller传过来的数据
 */
@property (strong, nonatomic) NSArray *HomeArray;

@property (nonatomic,strong) UICollectionView *collectionView;

@property (weak, nonatomic) id <delegateColl> delegateColl;

@end
