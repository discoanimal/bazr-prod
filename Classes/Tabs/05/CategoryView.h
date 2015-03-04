//
//  CategoryView.h
//  bazr
//
//  Created by a on 3/3/15.
//  Copyright (c) 2015 KZ. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark - CateCellDelegate
@protocol CateCellDelegate <NSObject>
- (void) selectCateItem : (NSInteger) index;
- (BOOL) isSelected : (NSInteger) index;
@end

#pragma mark - CategoryCell
@interface CategoryCell : UITableViewCell

@property (strong, readwrite) id<CateCellDelegate> delegate;
- (void) setupUI : (NSInteger) index color:(UIColor*)color;

@end

#pragma mark - CategoryDelegate
@protocol CategoryDelegate <NSObject>

- (void) onSelectCategory : (NSMutableDictionary*)categories;

@end

#pragma mark - CategoryView
@interface CategoryView : UIViewController<UITableViewDataSource, UITableViewDelegate, CateCellDelegate>

+(CategoryView*) shareInstance;

@property (strong, readwrite) id<CategoryDelegate> delegate;
- (void) showCategoryView : (NSMutableDictionary*)cates;

@end
