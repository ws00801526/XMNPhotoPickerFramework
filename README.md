## XMNPhotoPickerKit
> 一款图片,视频选择类库


--------


### 相关bug修复


##### V1.0.4

1. 增加了一个基于[YYWebImage](https://github.com/ibireme/YYWebImage)框架封装的图片浏览器 **XMNPhotoBrowser** -- 强烈推荐学习下[ibireme](https://github.com/ibireme)大神的其他框架
2. 修复iOS8以下崩溃bug
3. 去除获取图片时，图片按照创建时间排序的功能
4. 增加了类似QQ手势拖动发送图片功能
5. 2016-07-14 修复pickingVideoEnable属性  区分是否选择图片,或者视频
6. 修复选择视频时 谓词过滤崩溃bug 感谢[suyongmaozhao](https://github.com/suyongmaozhao)

##### V1.0.3
1. 修复了首次提示授权选择后 页面不更新问题
2. 去除了拖动发送功能
3. 增加了类似QQ的选择stick功能

##### V1.0.2
1. 修复XMNPhotoPicker 选择最大数量提示不正确

##### V1.0.1
1. 修复pods引用后没有找到xib文件

##### V1.0.0
1. 修复自定义导航栏导致底部bottomBar位置不正确问题	


### 1. 预览

![最新V1.0.4版本](http://7xlt1j.com1.z0.glb.clouddn.com/XMNPhotoPickerFramework.gif)
![图片浏览器](http://7xlt1j.com1.z0.glb.clouddn.com/XMNPhotoPickerFramework_Browser.gif)

### 2. 功能
* 一款图片,视频选择类库
* 支持直接显示相册选择
* 支持类似QQ方式Sheet选择
* iOS8+支持动态监测PhotoLibrary变化
* 支持预览图片,预览视频

### 3. 使用方法
* . pods使用
	pod 'XMNPhotoPickerFramework'

* . 直接引用

	1. 命令行下 `git clone https://github.com/ws00801526/	XMNPhotoPickerFramework.git`
	2. 拖动`XMNPhotoPickerFramework` 到你的工程内
	3. 导入头文件`XMNPhotoPickerFramework.h` 即可
	4. 具体用法,请参考demo
 

### 3.1 直接显示相册

```
- (void)_showPhotoPickerC {
    //1.初始化一个XMNPhotoPickerController
    XMNPhotoPickerController *photoPickerC = [[XMNPhotoPickerController alloc] initWithMaxCount:9 delegate:nil];
    //3.取消注释下面代码,使用代理方式回调,代理方法参考XMNPhotoPickerControllerDelegate
//    photoPickerC.photoPickerDelegate = self;
    
    //3..设置选择完照片的block 回调
    __weak typeof(*&self) wSelf = self;
    [photoPickerC setDidFinishPickingPhotosBlock:^(NSArray<UIImage *> *images, NSArray<XMNAssetModel *> *assets) {
        __weak typeof(*&self) self = wSelf;
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

```

#### 3.2 显示XMNPhotoPicker

```
- (void)_showPhotoPicker {
    //1. 推荐使用XMNPhotoPicker 的单例
    //2. 设置选择完照片的block回调
    [[XMNPhotoPicker sharePhotoPicker] setDidFinishPickingPhotosBlock:^(NSArray<UIImage *> *images, NSArray<XMNAssetModel *> *assets) {
        NSLog(@"picker images :%@ \n\n assets:%@",images,assets);
        self.assets = [assets copy];
        [self.collectionView reloadData];
    }];
    //3. 设置选择完视频的block回调
    [[XMNPhotoPicker sharePhotoPicker] setDidFinishPickingVideoBlock:^(UIImage * image, XMNAssetModel *asset) {
        NSLog(@"picker video :%@ \n\n asset :%@",image,asset);
        self.assets = @[asset];
        [self.collectionView reloadData];
    }];
    //4. 显示XMNPhotoPicker
    [[XMNPhotoPicker sharePhotoPicker] showPhotoPickerwithController:self animated:YES];
}

```

### 4.相关类说明 : [传送门](https://github.com/ws00801526/XMNPhotoPickerFramework/blob/master/XMNPhotoPickerKit-照片选择-类说明.md)

### 5. 感谢
感谢 [GitHub:banchichen](https://github.com/banchichen/TZImagePickerController)