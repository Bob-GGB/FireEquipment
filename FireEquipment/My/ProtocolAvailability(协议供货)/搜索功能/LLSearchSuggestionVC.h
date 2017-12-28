//
//  LLSearchSuggestionVC.h
//  LLSearchView
//
//

#import <UIKit/UIKit.h>

typedef void(^SuggestSelectBlock)(NSString *searchTest);
@interface LLSearchSuggestionVC : UIViewController

@property (nonatomic, copy) SuggestSelectBlock searchBlock;

- (void)searchTestChangeWithTest:(NSString *)test;

@end
