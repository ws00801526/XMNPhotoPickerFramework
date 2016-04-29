//
//  ViewController.m
//  XMNPhotoPickerFrameworkExample
//
//  Created by XMFraker on 16/1/28.
//  Copyright © 2016年 XMFraker. All rights reserved.
//

#import "ViewController.h"

#import "XMNPhotoPickerFramework.h"
#import "XMNPhotoCollectionController.h"

#import "XMNAssetCell.h"

@interface ViewController () <UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, copy)   NSArray<XMNAssetModel *> *assets;
@property (nonatomic, strong) UICollectionView *collectionView;


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

    XMNAssetCell *assetCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"XMNAssetCell" forIndexPath:indexPath];
    assetCell.contentView.backgroundColor = [UIColor greenColor];
    [assetCell configCellWithItem:self.assets[indexPath.row]];
    return assetCell;

}



#pragma mark - Methods



- (IBAction)_handleButtonAction {
    //1.初始化一个XMNPhotoPickerController
    XMNPhotoPickerController *photoPickerC = [[XMNPhotoPickerController alloc] initWithMaxCount:9 delegate:nil];
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
    //1. 推荐使用XMNPhotoPicker 的单例
    //2. 设置选择完照片的block回调
    __weak typeof(*&self) wSelf = self;
    [XMNPhotoPicker sharePhotoPicker].maxCount = 9;
    [[XMNPhotoPicker sharePhotoPicker] setDidFinishPickingPhotosBlock:^(NSArray<UIImage *> *images, NSArray<XMNAssetModel *> *assets) {
        __strong typeof(*&wSelf) self = wSelf;
        NSLog(@"picker images :%@ \n\n assets:%@",images,assets);
        self.assets = [assets copy];
        [self.collectionView reloadData];
    }];
    //3. 设置选择完视频的block回调
    [[XMNPhotoPicker sharePhotoPicker] setDidFinishPickingVideoBlock:^(UIImage * image, XMNAssetModel *asset) {
        __strong typeof(*&wSelf) self = wSelf;
        NSLog(@"picker video :%@ \n\n asset :%@",image,asset);
        self.assets = @[asset];
        [self.collectionView reloadData];
    }];
    //4. 显示XMNPhotoPicker
    [[XMNPhotoPicker sharePhotoPicker] showPhotoPickerwithController:self animated:YES];
}

#pragma mark - Getters

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        
        UICollectionViewLayout *layout = [XMNPhotoCollectionController photoCollectionViewLayoutWithWidth:self.view.bounds.size.width];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 64) collectionViewLayout:layout];
        _collectionView.contentInset = UIEdgeInsetsMake(8, 8, 8, 8);
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"CollectionCell"];
        [_collectionView registerNib:[UINib nibWithNibName:@"XMNAssetCell" bundle:nil] forCellWithReuseIdentifier:@"XMNAssetCell"];
    }
    return _collectionView;
}


@end
