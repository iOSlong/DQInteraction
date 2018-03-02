//
//  DQHorizontalSelectionListView.h
//  Le123PhoneClient
//
//  Created by 刘洋 on 2016/10/28.
//  Copyright © 2016年 Ying Shi Da Quan. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol DQHorizontalSelectionListItemProtocol <NSObject>
@property (nonatomic, strong) UILabel *titleLabel;
@end

@interface DQHorizontalSelectionListItemView : UIView <DQHorizontalSelectionListItemProtocol>
@end


@protocol DQHorizontalSelectionListDataSource;
@protocol DQHorizontalSelectionListDelegate;


@interface DQHorizontalSelectionListView : UIView
@property (nonatomic, weak) id<DQHorizontalSelectionListDataSource> dataSource;
@property (nonatomic, weak) id<DQHorizontalSelectionListDelegate>   delegate;


@property (nonatomic, strong, readonly) UIView *bottomTrimView;

@property (nonatomic, strong) UIColor          *normalColor;
@property (nonatomic, strong) UIColor          *selectedColor;

@property (nonatomic, strong) UIFont           *fontOfNormalState;
@property (nonatomic, strong) UIFont           *fontOfSelectedState;

@property (nonatomic, strong) UIColor          *bottomTrimColor;
@property (nonatomic, assign) CGSize            boottomTrimSize;

@property (nonatomic, strong) UIColor          *bottomLineColor;


@property (nonatomic, assign) CGFloat padding;
@property (nonatomic, assign) CGFloat spacing;


@property (nonatomic, assign) NSInteger   selectedIndex;// Default is -1

@property (nonatomic, weak) UIScrollView *scrollView; //观察offset变化进行动画

- (void)reloadData;

/**
 *    set the offset of the indicator(only for HTHorizontalSelectionIndicatorStyleBottomBar).
 *    （add by liuyang13 ）
 *    @param offset -1~1
 */
- (void)setSelectionIndicatorOffsetRatio:(CGFloat)offset;
@end


@protocol DQHorizontalSelectionListDataSource <NSObject>

@required
- (NSInteger)numberOfItemsInSelectionList:(DQHorizontalSelectionListView*)selectionList;
- (NSString*)selectionList:(DQHorizontalSelectionListView*)selectionList titleForItemWithIndex:(NSInteger)index;

@end

@protocol DQHorizontalSelectionListDelegate <NSObject>

@optional
- (void)selectionList:(DQHorizontalSelectionListView*)selectionList didSelectButtonWithIndex:(NSInteger)index;

@end
