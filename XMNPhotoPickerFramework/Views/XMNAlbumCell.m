//
//  XMNAlbumCell.m
//  XMNPhotoPickerFrameworkExample
//
//  Created by XMFraker on 16/1/28.
//  Copyright © 2016年 XMFraker. All rights reserved.
//

#import "XMNAlbumCell.h"

#import "XMNAlbumModel.h"
#import "XMNPhotoManager.h"

@interface XMNAlbumCell ()
@property (weak, nonatomic) IBOutlet UIImageView *albumCoverImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation XMNAlbumCell


- (void)configCellWithItem:(XMNAlbumModel * _Nonnull)item {
    
    NSMutableAttributedString *nameString = [[NSMutableAttributedString alloc] initWithString:item.name attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16],NSForegroundColorAttributeName:[UIColor blackColor]}];
    NSAttributedString *countString = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"  (%zd)",item.count] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16],NSForegroundColorAttributeName:[UIColor lightGrayColor]}];
    [nameString appendAttributedString:countString];
    self.titleLabel.attributedText = nameString;
    
    __weak typeof(*&self) wSelf = self;
    [[XMNPhotoManager sharedManager] getThumbnailWithAsset:[item.fetchResult lastObject] size:kXMNThumbnailSize completionBlock:^(UIImage *image) {
        __weak typeof(*&self) self = wSelf;
        self.albumCoverImageView.image = image;
    }];
    
}

@end
