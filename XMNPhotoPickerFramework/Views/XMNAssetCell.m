//
//  XMNAssetCell.m
//  XMNPhotoPickerFrameworkExample
//
//  Created by XMFraker on 16/1/28.
//  Copyright © 2016年 XMFraker. All rights reserved.
//

#import "XMNAssetCell.h"

#import "XMNAssetModel.h"
#import "XMNPhotoManager.h"

#import "UIView+Animations.h"

@interface XMNAssetCell ()
@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@property (weak, nonatomic) IBOutlet UIView *videoView;
@property (weak, nonatomic) IBOutlet UILabel *videoTimeLabel;
@property (weak, nonatomic) IBOutlet UIButton *photoStateButton;


@property (nonatomic, strong) UIView *tempView;
@property (nonatomic, weak)   UIImageView *tempImageView;
@property (nonatomic, weak)   UILabel *tempTipsLabel;

@property (nonatomic, assign) CGPoint startCenter;
@property (nonatomic, weak, readonly)   UIView *keyWindow;


@end

@implementation XMNAssetCell
@synthesize asset = _asset;

#pragma mark - Methods

/// ========================================
/// @name   Public Methods
/// ========================================

/**
 *  XMNPhotoCollectionController 中配置collectionView的cell
 *
 *  @param item 具体的AssetModel
 */
- (void)configCellWithItem:(XMNAssetModel * _Nonnull )item {
    _asset = item;
    switch (item.type) {
        case XMNAssetTypeVideo:
        case XMNAssetTypeAudio:
            self.videoView.hidden = NO;
            self.videoTimeLabel.text = item.timeLength;
            break;
        case XMNAssetTypeLivePhoto:
        case XMNAssetTypePhoto:
            self.videoView.hidden = YES;
            break;
    }
    self.photoStateButton.selected = item.selected;
    self.photoImageView.image = item.thumbnail;

}

/**
 *  XMNPhotoPicker 中配置collectionView的cell
 *
 *  @param item 具体的AssetModel
 */
- (void)configPreviewCellWithItem:(XMNAssetModel * _Nonnull )item {
    _asset = item;
    switch (item.type) {
        case XMNAssetTypeVideo:
        case XMNAssetTypeAudio:
            self.videoView.hidden = NO;
            self.videoTimeLabel.text = item.timeLength;
            break;
        case XMNAssetTypeLivePhoto:
        case XMNAssetTypePhoto:
            self.videoView.hidden = YES;
            break;
    }
    self.photoStateButton.selected = item.selected;
    self.photoImageView.image = item.previewImage;
    
    
    UILongPressGestureRecognizer *longPressGes = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(_handleLongPress:)];
    longPressGes.numberOfTouchesRequired =1;
    longPressGes.minimumPressDuration = .1f;
    [self.photoImageView addGestureRecognizer:longPressGes];
    self.photoImageView.userInteractionEnabled = YES;

}

/// ========================================
/// @name   Private Methods
/// ========================================

- (void)_handleLongPress:(UILongPressGestureRecognizer *)longPressGes {
    if (longPressGes.state == UIGestureRecognizerStateBegan) {
        //开始手势,显示tempView,隐藏tipsLabel,photoImageView,photoStateButton
        self.tempView.hidden = NO;
        self.tempTipsLabel.hidden = YES;
        
        //记录其实center
        self.startCenter = [self.photoImageView convertPoint:self.photoImageView.center toView:self.keyWindow];
        CGRect startFrame = [self.photoImageView convertRect:self.photoImageView.frame toView:self.keyWindow];
        [self.tempView setFrame:startFrame];
        [self.tempImageView setFrame:CGRectMake(0, 0, startFrame.size.width, startFrame.size.height)];
        self.tempImageView.image = self.photoImageView.image;
        self.tempTipsLabel.center = CGPointMake(self.tempView.frame.size.width/2, 12);
        [self.keyWindow addSubview:self.tempView];
        
        self.photoImageView.hidden = YES;
        self.photoStateButton.hidden = YES;
    }else if (longPressGes.state == UIGestureRecognizerStateChanged) {
        self.tempView.center = CGPointMake(self.tempView.center.x, MIN([longPressGes locationInView:self.keyWindow].y, self.startCenter.y));
        CGRect convertRect = [self.superview convertRect:self.superview.frame toView:self.keyWindow];
        if (CGRectContainsPoint(CGRectMake(0, convertRect.origin.y, convertRect.size.width, convertRect.size.height), self.tempView.center)) {
            self.tempTipsLabel.hidden = YES;
        }else {
            self.tempTipsLabel.hidden = NO;
        }
    }else {
        if (!self.tempTipsLabel.hidden) {
            self.tempView.hidden = YES;
            self.photoImageView.hidden = NO;
            self.photoStateButton.hidden = NO;
            self.didSendAsset ? self.didSendAsset(self.asset, self.tempView.frame) : nil;
        }else {
            [UIView animateWithDuration:.2 animations:^{
                self.tempView.center = self.startCenter;
            } completion:^(BOOL finished) {
                self.startCenter = CGPointZero;
                [self.tempView removeFromSuperview];
                self.photoImageView.hidden = NO;
                self.photoStateButton.hidden = NO;
            }];
        }
    }
}

/**
 *  处理stateButton的点击动作
 *
 *  @param sender button
 */
- (IBAction)_handleButtonAction:(UIButton *)sender {
    BOOL originState = sender.selected;
    self.photoStateButton.selected = self.willChangeSelectedStateBlock ? self.willChangeSelectedStateBlock(self.asset) : NO;
    if (self.photoStateButton.selected) {
        [UIView animationWithLayer:self.photoStateButton.layer type:XMNAnimationTypeBigger];
    }
    if (originState != self.photoStateButton.selected) {
        self.didChangeSelectedStateBlock ? self.didChangeSelectedStateBlock(self.photoStateButton.selected, self.asset) : nil;
    }
}

#pragma mark - Getter

- (UIView *)keyWindow {
    return [[UIApplication sharedApplication] keyWindow];
}

- (UIView *)tempView {
    if (!_tempView) {
        _tempView = [[UIView alloc] init];
        
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        [_tempView addSubview:self.tempImageView = imageView];
        
        UILabel *tipsLabel = [[UILabel alloc] init];
        [tipsLabel setText:@"松开选择"];
        tipsLabel.font = [UIFont systemFontOfSize:10.0f];
        tipsLabel.backgroundColor = [UIColor darkGrayColor];
        tipsLabel.textColor = [UIColor whiteColor];
        tipsLabel.textAlignment = NSTextAlignmentCenter;
        tipsLabel.hidden = YES;
        tipsLabel.layer.cornerRadius = 10.0f;
        tipsLabel.layer.masksToBounds = YES;
        tipsLabel.frame = CGRectMake(0, 4, 55, 20);
        [_tempView addSubview:self.tempTipsLabel = tipsLabel];
    }
    return _tempView;
}

@end
