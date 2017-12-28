//
//Created by ESJsonFormatForMac on 17/11/21.
//

#import <Foundation/Foundation.h>

@class Content,Selectproductlist,Hotproductlist;
@interface IndexModel : NSObject

@property (nonatomic, copy) NSString *msg;

@property (nonatomic, strong) Content *content;

@property (nonatomic, assign) NSInteger code;

@end
@interface Content : NSObject

@property (nonatomic, strong) NSArray<Selectproductlist *> *selectProductList;

@property (nonatomic, strong) NSArray<Hotproductlist *> *hotProductList;

@end

@interface Selectproductlist : NSObject

@property (nonatomic, assign) NSInteger productID;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *price;

@property (nonatomic, copy) NSString *titleImage;

@end

@interface Hotproductlist : NSObject

@property (nonatomic, copy) NSString *productName;

@property (nonatomic, copy) NSString *img;

@property (nonatomic, assign) NSInteger productID;

@property (nonatomic, assign) NSInteger sellerID;

@property (nonatomic, copy) NSString *price;

@property (nonatomic, copy) NSString *sellerName;

@end

