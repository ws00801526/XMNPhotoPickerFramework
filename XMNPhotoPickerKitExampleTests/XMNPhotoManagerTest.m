//
//  XMNPhotoManagerTest.m
//  XMNPhotoPickerFrameworkExample
//  测试XMNPhotoManager 是否正常工作
//  Created by XMFraker on 16/1/28.
//  Copyright © 2016年 XMFraker. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "XMNPhotoPickerFramework.h"
@interface XMNPhotoManagerTest : XCTestCase

@end

@implementation XMNPhotoManagerTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

- (void)testGetAllAlbums {
    [[XMNPhotoManager sharedManager] getAlbumsPickingVideoEnable:YES completionBlock:^(NSArray<XMNAlbumModel *> *array) {
        [array enumerateObjectsUsingBlock:^(XMNAlbumModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSLog(@"%@",obj);
        }];
    }];
}

- (void)testGetAllPhotos {
    [[XMNPhotoManager sharedManager] getAlbumsPickingVideoEnable:YES completionBlock:^(NSArray<XMNAlbumModel *> *albums) {
        for (XMNAlbumModel *albumModel in albums) {
            [[XMNPhotoManager sharedManager] getAssetsFromResult:albumModel.fetchResult pickingVideoEnable:YES completionBlock:^(NSArray<XMNAssetModel *> *assets) {
                NSLog(@"i get asets :%@ in :%@",assets,albumModel.name);
            }];
        }
    }];
}

- (void)testGetOriginImage {
    [[XMNPhotoManager sharedManager] getAlbumsPickingVideoEnable:YES completionBlock:^(NSArray<XMNAlbumModel *> *albums) {
        [albums enumerateObjectsUsingBlock:^(XMNAlbumModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [[XMNPhotoManager sharedManager] getAssetsFromResult:obj.fetchResult pickingVideoEnable:YES completionBlock:^(NSArray<XMNAssetModel *> *assets) {
                [assets enumerateObjectsUsingBlock:^(XMNAssetModel * _Nonnull assetModel, NSUInteger idx, BOOL * _Nonnull stop) {
                    NSLog(@"assetModel.originImage :%@",assetModel.originImage);
                    *stop = YES;
                }];
            }];
            *stop = YES;
        }];
    }];
}

- (void)testGetThumbnail {
    [[XMNPhotoManager sharedManager] getAlbumsPickingVideoEnable:YES completionBlock:^(NSArray<XMNAlbumModel *> *albums) {
        [albums enumerateObjectsUsingBlock:^(XMNAlbumModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [[XMNPhotoManager sharedManager] getAssetsFromResult:obj.fetchResult pickingVideoEnable:YES completionBlock:^(NSArray<XMNAssetModel *> *assets) {
                [assets enumerateObjectsUsingBlock:^(XMNAssetModel * _Nonnull assetModel, NSUInteger idx, BOOL * _Nonnull stop) {
                    NSLog(@"assetModel.thumbnail :%@",assetModel.thumbnail);
                    *stop = YES;
                }];
            }];
            *stop = YES;
        }];
    }];
}

- (void)testGetPreviewImage {
    [[XMNPhotoManager sharedManager] getAlbumsPickingVideoEnable:YES completionBlock:^(NSArray<XMNAlbumModel *> *albums) {
        [albums enumerateObjectsUsingBlock:^(XMNAlbumModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [[XMNPhotoManager sharedManager] getAssetsFromResult:obj.fetchResult pickingVideoEnable:YES completionBlock:^(NSArray<XMNAssetModel *> *assets) {
                [assets enumerateObjectsUsingBlock:^(XMNAssetModel * _Nonnull assetModel, NSUInteger idx, BOOL * _Nonnull stop) {
                    NSLog(@"assetModel.previewImage :%@",assetModel.previewImage);
                    *stop = YES;
                }];
            }];
            *stop = YES;
        }];
    }];
}


- (void)testXMNPhotoAuthorized {
    XCTAssertTrue([[XMNPhotoManager sharedManager] hasAuthorized], @"应用已经被授权");
}

@end
