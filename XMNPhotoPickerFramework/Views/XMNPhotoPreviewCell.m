//
//  XMNPhotoPreviewCell.m
//  XMNPhotoPickerFrameworkExample
//
//  Created by XMFraker on 16/1/29.
//  Copyright © 2016年 XMFraker. All rights reserved.
//

#import "XMNPhotoPreviewCell.h"

#import "XMNAssetModel.h"

@interface XMNPhotoPreviewCell () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation XMNPhotoPreviewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self _setup];
    }
    return self;
}

#pragma mark - Methods

- (void)configCellWithItem:(XMNAssetModel *)item {
    
    [self.scrollView setZoomScale:1.0f];
    self.imageView.image = item.previewImage;
    [self _resizeSubviews];
}

- (void)_setup {
    
    self.backgroundColor = self.contentView.backgroundColor = [UIColor blackColor];
    
    [self.containerView addSubview:self.imageView];
    [self.scrollView addSubview:self.containerView];
    [self.contentView addSubview:self.scrollView];
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_handleSingleTap)];
    
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_handleDoubleTap:)];
    doubleTap.numberOfTapsRequired = 2;
    
    [singleTap requireGestureRecognizerToFail:doubleTap];
    [self.contentView addGestureRecognizer:singleTap];
    [self.contentView addGestureRecognizer:doubleTap];
    
}

- (void)_resizeSubviews {
    self.containerView.frame = self.bounds;
    UIImage *image = self.imageView.image;
    if (!image) {
        return;
    }
    CGFloat screenScale = [UIScreen mainScreen].scale;
    CGFloat widthPercent = (image.size.width / screenScale) / self.frame.size.width;
    CGFloat heightPercent = (image.size.height / screenScale) / self.frame.size.height;
    if (widthPercent <= 1.0f && heightPercent <= 1.0f) {
        self.containerView.bounds = CGRectMake(0, 0, image.size.width/screenScale, image.size.height/screenScale);
        self.containerView.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    } else if (widthPercent > 1.0f && heightPercent < 1.0f) {
        self.containerView.frame = CGRectMake(0, 0, self.frame.size.width, heightPercent * self.frame.size.width);
    }else if (widthPercent <= 1.0f && heightPercent > 1.0f) {
        self.containerView.frame = CGRectMake(0, 0, self.frame.size.height * widthPercent ,self.frame.size.height);
    }else {
        if (widthPercent > heightPercent) {
            self.containerView.frame = CGRectMake(0, 0, self.frame.size.width, heightPercent * self.frame.size.width);
        }else {
            self.containerView.frame = CGRectMake(0, 0, self.frame.size.height * widthPercent ,self.frame.size.height);
        }
    }
    
    self.scrollView.contentSize = CGSizeMake(self.frame.size.width, self.frame.size.height);
    [self.scrollView scrollRectToVisible:self.bounds animated:NO];
    self.scrollView.alwaysBounceVertical = self.containerView.frame.size.height <= self.frame.size.height ? NO : YES;
    self.imageView.frame = self.containerView.bounds;
    
}


- (void)_handleSingleTap {
    self.singleTapBlock ? self.singleTapBlock() : nil;
}

- (void)_handleDoubleTap:(UITapGestureRecognizer *)doubleTap {
    if (self.scrollView.zoomScale > 1.0f) {
        [self.scrollView setZoomScale:1.0 animated:YES];
    }else {
        CGPoint touchPoint = [doubleTap locationInView:self.imageView];
        CGFloat newZoomScale = self.scrollView.maximumZoomScale;
        CGFloat xsize = self.frame.size.width / newZoomScale;
        CGFloat ysize = self.frame.size.height / newZoomScale;
        [self.scrollView zoomToRect:CGRectMake(touchPoint.x - xsize/2, touchPoint.y - ysize/2, xsize, ysize) animated:YES];
    }
}


#pragma mark - UIScrollViewDelegate

- (nullable UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.containerView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    CGFloat offsetX = (scrollView.frame.size.width > scrollView.contentSize.width) ? (scrollView.frame.size.width - scrollView.contentSize.width) * 0.5 : 0.0;
    CGFloat offsetY = (scrollView.frame.size.height > scrollView.contentSize.height) ? (scrollView.frame.size.height - scrollView.contentSize.height) * 0.5 : 0.0;
    self.containerView.center = CGPointMake(scrollView.contentSize.width * 0.5 + offsetX, scrollView.contentSize.height * 0.5 + offsetY);
}

#pragma mark - Getters

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollView.bouncesZoom = YES;
        _scrollView.maximumZoomScale = 3.0f;
        _scrollView.minimumZoomScale = 1.0f;
        _scrollView.multipleTouchEnabled = YES;
        _scrollView.delegate = self;
        _scrollView.scrollsToTop = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _scrollView.delaysContentTouches = NO;
        _scrollView.canCancelContentTouches = YES;
        _scrollView.alwaysBounceVertical = NO;
    }
    return _scrollView;
}


- (UIView *)containerView {
    if (!_containerView) {
        _containerView = [[UIView alloc] initWithFrame:self.bounds];
        _containerView.clipsToBounds = YES;
    }
    return _containerView;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        
        _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _imageView.backgroundColor = [UIColor colorWithWhite:1.000 alpha:0.500];
        _imageView.clipsToBounds = YES;
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        
    }
    return _imageView;
}

@end
