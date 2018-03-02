//
//  SearchBarView.h
//  SARRS
//
//  Created by xuewu.long on 17/7/7.
//  Copyright © 2017年 Beijing Ninety Culture Co.ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SearchBarView;

@protocol SearchBarViewDelegate <NSObject>
@optional
- (void)searchBarDidEndEditing:(SearchBarView*)searchBar;
- (void)searchBarDidBeginEditing:(SearchBarView*)searchBar;
- (BOOL)searchBarShouldReturn:(SearchBarView*)searchBar;
- (BOOL)searchBarShouldClear:(SearchBarView*)searchBar;
- (void)searchBarChangedEditing:(SearchBarView*)searchBar;
@end


@interface SearchBarView : UIView<UITextFieldDelegate>
@property (nonatomic, weak) id<SearchBarViewDelegate> delegate;
@property (nonatomic, strong) IBOutlet UITextField   *textField;
@property (nonatomic, strong) UIButton               *btnClear;
@property (nonatomic, strong) UIImageView            *imgvLeft;
@property (nonatomic, strong) NSString               *text;
@property (nonatomic, strong) NSString               *placeholder;
+ (instancetype)searchBarView;
- (void)textfieldResignFirstResponder;
- (void)addKeyboardNotification;
- (void)removeKeyboardNotification;

@end
