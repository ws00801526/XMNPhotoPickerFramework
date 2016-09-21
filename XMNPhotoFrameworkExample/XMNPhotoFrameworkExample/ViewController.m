//
//  ViewController.m
//  XMNPhotoPickerFrameworkExample
//
//  Created by XMFraker on 16/1/28.
//  Copyright © 2016年 XMFraker. All rights reserved.
//

#import "ViewController.h"

#import <XMNPhotoPicker/XMNPhotoPicker.h>
#import <XMNPhotoBrowser/XMNPhotoBrowser.h>


@interface XMNTestAssetCell : UICollectionViewCell

@property (weak, nonatomic)   UIImageView *imageView;


@end

@implementation XMNTestAssetCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        [self.contentView addSubview:self.imageView = imageView];
    }
    return self;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    self.imageView.frame = self.contentView.bounds;
}

@end

@interface ViewController () <UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, copy)   NSArray<XMNAssetModel *> *assets;
@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) UIImageView *imageView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.assets = @[];
    
    
    [self.view insertSubview:self.collectionView atIndex:0];
    UIBarButtonItem *controllerItem =  [[UIBarButtonItem alloc] initWithTitle:@"Controller" style:UIBarButtonItemStylePlain target:self action:@selector(_handleButtonAction)];
    UIBarButtonItem *pickerItem = [[UIBarButtonItem alloc] initWithTitle:@"Picker" style:UIBarButtonItemStylePlain target:self action:@selector(_handlePickerAction)];
    self.navigationItem.rightBarButtonItems = @[controllerItem,pickerItem];
    
    [self.view addSubview:self.imageView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionViewDelegate & UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.assets.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    XMNTestAssetCell *assetCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"XMNTestAssetCell" forIndexPath:indexPath];
    assetCell.contentView.backgroundColor = [UIColor greenColor];
    assetCell.imageView.image = self.assets[indexPath.row].thumbnail;
    return assetCell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSArray *links = @[
                       /*
                        You can add your image url here.
                        */
                       @"http://img3.duitang.com/uploads/item/201505/02/20150502005315_2zBTe.thumb.700_0.jpeg",
                       @"http://h.hiphotos.baidu.com/image/pic/item/cb8065380cd7912340202a49a5345982b3b780cf.jpg",
                       @"http://c.hiphotos.baidu.com/image/pic/item/9c16fdfaaf51f3de4e7a03599ceef01f3b2979c7.jpg",
                       // progressive jpeg
                       @"https://s-media-cache-ak0.pinimg.com/1200x/2e/0c/c5/2e0cc5d86e7b7cd42af225c29f21c37f.jpg",
                       
                       // animated gif: http://cinemagraphs.com/
                       @"http://i.imgur.com/uoBwCLj.gif",
                       @"http://i.imgur.com/8KHKhxI.gif",
                       @"http://i.imgur.com/WXJaqof.gif",
                       
                       // animated gif: https://dribbble.com/markpear
                       @"https://d13yacurqjgara.cloudfront.net/users/345826/screenshots/1780193/dots18.gif",
                       @"https://d13yacurqjgara.cloudfront.net/users/345826/screenshots/1809343/dots17.1.gif",
                       @"https://d13yacurqjgara.cloudfront.net/users/345826/screenshots/1845612/dots22.gif",
                       @"https://d13yacurqjgara.cloudfront.net/users/345826/screenshots/1820014/big-hero-6.gif",
                       @"https://d13yacurqjgara.cloudfront.net/users/345826/screenshots/1819006/dots11.0.gif",
                       @"https://d13yacurqjgara.cloudfront.net/users/345826/screenshots/1799885/dots21.gif",
                       
                       // animaged gif: https://dribbble.com/jonadinges
                       @"https://d13yacurqjgara.cloudfront.net/users/288987/screenshots/2025999/batman-beyond-the-rain.gif",
                       @"https://d13yacurqjgara.cloudfront.net/users/288987/screenshots/1855350/r_nin.gif",
                       @"https://d13yacurqjgara.cloudfront.net/users/288987/screenshots/1963497/way-back-home.gif",
                       @"https://d13yacurqjgara.cloudfront.net/users/288987/screenshots/1913272/depressed-slurp-cycle.gif",
                       
                       // jpg: https://dribbble.com/snootyfox
                       @"https://d13yacurqjgara.cloudfront.net/users/26059/screenshots/2047158/beerhenge.jpg",
                       @"https://d13yacurqjgara.cloudfront.net/users/26059/screenshots/2016158/avalanche.jpg",
                       @"https://d13yacurqjgara.cloudfront.net/users/26059/screenshots/1839353/pilsner.jpg",
                       @"https://d13yacurqjgara.cloudfront.net/users/26059/screenshots/1833469/porter.jpg",
                       @"https://d13yacurqjgara.cloudfront.net/users/26059/screenshots/1521183/farmers.jpg",
                       @"https://d13yacurqjgara.cloudfront.net/users/26059/screenshots/1391053/tents.jpg",
                       @"https://d13yacurqjgara.cloudfront.net/users/26059/screenshots/1399501/imperial_beer.jpg",
                       @"https://d13yacurqjgara.cloudfront.net/users/26059/screenshots/1488711/fishin.jpg",
                       @"https://d13yacurqjgara.cloudfront.net/users/26059/screenshots/1466318/getaway.jpg",
                       
                       // animated webp and apng: http://littlesvr.ca/apng/gif_apng_webp.html
                       @"http://littlesvr.ca/apng/images/BladeRunner.png",
                       @"http://littlesvr.ca/apng/images/Contact.webp",
                       ];
    NSMutableArray *photos = [NSMutableArray array];
    [self.assets enumerateObjectsUsingBlock:^(XMNAssetModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        XMNPhotoModel *model = [[XMNPhotoModel alloc] initWithImagePath:links[idx]
                                                              thumbnail:obj.previewImage];
        [photos addObject:model];
    }];
    
    // 够着XMNPhotoBrowserController 实例
    XMNPhotoBrowserController *browserC = [[XMNPhotoBrowserController alloc] initWithPhotos:photos];
    // 设置第一张预览图片位置  默认0
    browserC.currentItemIndex = indexPath.row;
    // 设置 预览的sourceView
    browserC.sourceView = [[collectionView cellForItemAtIndexPath:indexPath] valueForKey:@"imageView"];
    // 使用presentVC方式 弹出
    [self presentViewController:browserC animated:YES completion:nil];
}

#pragma mark - Methods


- (IBAction)_handleButtonAction {
    //1.初始化一个XMNPhotoPickerController
    XMNPhotoPickerController *photoPickerC = [[XMNPhotoPickerController alloc] initWithMaxCount:99 delegate:nil];
    //3.取消注释下面代码,使用代理方式回调,代理方法参考XMNPhotoPickerControllerDelegate
    //    photoPickerC.photoPickerDelegate = self;
    
    //3..设置选择完照片的block 回调
    __weak typeof(*&self) wSelf = self;
    [photoPickerC setDidFinishPickingPhotosBlock:^(NSArray<UIImage *> *images, NSArray<XMNAssetModel *> *assets) {
        __weak typeof(*&self) self = wSelf;
        NSLog(@"imageinfo :%@",[[assets firstObject] filename]);
        NSLog(@"picker images :%@ \n\n assets:%@",images,assets);
        
        //!!!如果需要自定义大小的图片 使用下面方法
        //        [[XMNPhotoManager sharedManager] getThumbnailWithAsset:<# asset in assets #> size:<# your size #> completionBlock:^(UIImage * _Nullable image) {
        //
        //        }];
        
        self.assets = [assets copy];
        [self.collectionView reloadData];
        //XMNPhotoPickerController 确定选择,并不会自己dismiss掉,需要自己dismiss
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    
    //4.设置选择完视频的block回调
    [photoPickerC setDidFinishPickingVideoBlock:^(UIImage *coverImage, XMNAssetModel * asset) {
        __weak typeof(*&self) self = wSelf;
        NSLog(@"picker image :%@\n\n asset:%@\n\n",coverImage,asset);
        self.assets = @[asset];
        [self.collectionView reloadData];
        //XMNPhotoPickerController 确定选择,并不会自己dismiss掉,需要自己dismiss
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    
    //5.设置用户取消选择的回调 可选
    [photoPickerC setDidCancelPickingBlock:^{
        NSLog(@"photoPickerC did Cancel");
        //此处不需要自己dismiss
    }];
    
    //6. 显示photoPickerC
    [self presentViewController:photoPickerC animated:YES completion:nil];
}

- (IBAction)_handlePickerAction {
    //1. 使用XMNPhotoPicker 的单例
    //2. 设置选择完照片的block回调
    __weak typeof(*&self) wSelf = self;
    [XMNPhotoPickerSheet sharePhotoPicker].pickingVideoEnable = NO;
    [XMNPhotoPickerSheet sharePhotoPicker].maxCount = 9;
    [[XMNPhotoPickerSheet sharePhotoPicker] setDidFinishPickingPhotosBlock:^(NSArray<UIImage *> *images, NSArray<XMNAssetModel *> *assets) {
        __strong typeof(*&wSelf) self = wSelf;
        NSLog(@"picker images :%@ \n\n assets:%@",images,assets);
        
        if (!assets) {
            self.imageView.hidden = NO;
            self.imageView.image = [images firstObject];
        }else {
            self.imageView.hidden = YES;
            self.assets = [assets copy];
            [self.collectionView reloadData];
        }
    }];
    //3. 设置选择完视频的block回调
    [[XMNPhotoPickerSheet sharePhotoPicker] setDidFinishPickingVideoBlock:^(UIImage * image, XMNAssetModel *asset) {
        __strong typeof(*&wSelf) self = wSelf;
        NSLog(@"picker video :%@ \n\n asset :%@",image,asset);
        self.assets = @[asset];
        [self.collectionView reloadData];
    }];
    
    /** 添加手势发送图片功能 */
    [[XMNPhotoPickerSheet sharePhotoPicker] setDidSendAsset:^(XMNAssetModel * _Nonnull asset, UIView * _Nonnull originView, void (^completedBlock)()) {
        
        /** 使用kXMNGestureSendImageViewTag 可以获取拖动发送view中的imageView */
        UIImageView *imageView = (UIImageView *)[originView viewWithTag:[XMNPhotoPickerOption sendingImageViewTag]];
        completedBlock();
    }];
    
    //4. 显示XMNPhotoPicker
    [[XMNPhotoPickerSheet sharePhotoPicker] showPhotoPickerwithController:self animated:YES];
}

#pragma mark - Getters

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        
        UICollectionViewLayout *layout = [XMNPhotoPickerOption photoCollectionViewLayoutWithWidth:self.view.bounds.size.width];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 64) collectionViewLayout:layout];
        _collectionView.contentInset = UIEdgeInsetsMake(8, 8, 8, 8);
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [_collectionView registerClass:[XMNTestAssetCell class] forCellWithReuseIdentifier:@"XMNTestAssetCell"];
    }
    return _collectionView;
}


- (UIImageView *)imageView {
    
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 300, 250)];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.center = CGPointMake(self.view.center.x, self.view.center.y - 150);
        _imageView.hidden = YES;
    }
    return _imageView;
}

@end
