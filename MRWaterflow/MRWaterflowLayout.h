//
//  MRWaterflowLayout.h
//  MRWaterflow
//
//  Created by Andrew554 on 16/8/4.
//  Copyright © 2016年 Andrew554. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MRWaterflowLayout;

@protocol MRWaterflowLayoutDelegate <NSObject>
@required
- (CGFloat)waterflowLayout:(MRWaterflowLayout *)waterflowLayout heightForItemAtIndex:(NSUInteger)index itemWidth:(CGFloat)itemWidth;

@optional
- (CGFloat)columnCountInWaterflowLayout:(MRWaterflowLayout *)waterflowLayout;
- (CGFloat)columnMarginInWaterflowLayout:(MRWaterflowLayout *)waterflowLayout;
- (CGFloat)rowMarginInWaterflowLayout:(MRWaterflowLayout *)waterflowLayout;
- (UIEdgeInsets)edgeInsetsInWaterflowLayout:(MRWaterflowLayout *)waterflowLayout;
@end

@interface MRWaterflowLayout : UICollectionViewLayout
/** 瀑布流代理 */
@property (nonatomic, weak) id<MRWaterflowLayoutDelegate> delegate;
@end
