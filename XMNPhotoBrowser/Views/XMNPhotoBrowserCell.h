//
//  XMNPhotoBrowserCell.h
//  XMNPhotoPickerFrameworkExample
//
//  Created by XMFraker on 16/6/13.
//  Copyright © 2016年 XMFraker. All rights reserved.
//

#import <UIKit/UIKit.h>


@class XMNPhotoModel;
@class YYAnimatedImageView;
@interface XMNPhotoBrowserCell : UICollectionViewCell

@property (nonatomic, strong, readonly, nonnull) YYAnimatedImageView *imageView;

@property (nonatomic, copy, nullable)   void(^singleTapBlock)(XMNPhotoBrowserCell __weak  * _Nullable  browserCell);

- (void)configCellWithItem:(XMNPhotoModel * _Nonnull )item;
- (void)cancelImageRequest;
@end
