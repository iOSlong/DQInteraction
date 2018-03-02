//
//  SectionTitlePageCollectionView.h
//  DQInteraction
//
//  Created by lxw on 2018/3/2.
//  Copyright © 2018年 lxw. All rights reserved.
//

#import "SASView.h"
@class SectionTitlePageCollectionView;

@protocol SectionTitlePageCollectionViewDelegate <NSObject>
- (NSArray *)sectionTitlesOfPageCollection:(SectionTitlePageCollectionView *)pageCollectionView;
- (NSArray *)pageCollection:(SectionTitlePageCollectionView *)pageCollectionView dataSouceInSection:(NSInteger)section;
@end



@interface SectionTitlePageCollectionView : SASView
@property (nonatomic, assign) id<SectionTitlePageCollectionViewDelegate> delegate;

- (void)reloadData;
- (void)reloadSection:(NSInteger)section;

@end
