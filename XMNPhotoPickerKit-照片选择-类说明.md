## 思路

1. 为了兼容iOS7(`AssetsLibaray`),iOS8+(`PhotoKit`),统一使用一个单例类 `XMNPhotoManager` 来获取图片
2. 使用`XMNAssetModel` 和`XMNAlbumModel` 封装下获取的result
3. 自定义`XMNPhotoPickerController`继承`UINavigationController` 来作为选择图片的入口


##1. XMNPhotoPickerKit

###1.1 照片管理Manager
####1.1.1 相关类

#####1.1.1.1. XMNAlbumModel : 专辑信息

| 属性        |  属性说明     |  作用           |
| ------------- | --- |:-------------:| 
| name   |    | album 名称 | 
| count     |   | 照片数量  | 
| result |    | 包含的图片数组,PHFetchResult<PHAsset> or ALAssetsGroup<ALAsset> | 


| 方法        |  方法说明     |  作用           |
| ------------- | --- |:-------------:| 
| albumWithResult:   | Class方法   |  通过获取的PHFetchResult<PHAsset> or ALAssetsGroup<ALAsset> | 
| setName:     |  重写name的setter方法  | 设置name为中文字符串  | 

#####1.1.1.2. XMNAssetModel : 照片,视频等信息

| 属性        |  属性说明     |  作用           |
| ------------- | --- |:-------------:| 
| asset   |    | 资源类型,PHAsset or ALAsset | 
| selected     |   | 是否被选中   | 
| type |  readonly  | 图片,视频,livePhoto,audio等| 
| timeLength | readonly | 视频长度 |
| originImage   | readOnly  | 原图 | 
| thumbnail     |  readonly | 缩略图,默认大小的缩略图   | 
| previewImage |  readonly  |适合当前屏幕的预览图 | 
| imageOrientation | readonly | 图片方向|

#####1.1.1.3. XMNPhotoManager : 获取所有专辑,专辑内照片视频等

* iOS6,7 使用`AssetsLibaray` iOS8+使用`PhotoKit`
* 使用单例模式,并且iOS8+使用了`PHCachingImageManager`在获取图片的时候缓存,保证`XMNPhotoCollectionController`的滑动流畅

| 	方法        |  方法说明          | 作用 | 
| ------------- |:-------------:| --- | 
| hasAuthorized| classMethods | 判断是否授权 |
| | 
| requestOriginImageWithAsset:WithCompletion:      |  方法 | 获取asset的原图  | 
| requestThumbnailWithAsset:WithCompletion:     |  方法   | 获取asset的对应的缩略图 |
| requestPreviewImageWithAsset:WithCompletion: |   方法 | 获取asset对应的预览图,适应当前屏幕的尺寸 |  
| imageOrientationWithAsset:WithCompletion: |  方法  |获取对应asset的图片方向 | 

###1.2 照片选择ViewController
####1.2.1 XMNPhotoPickerController

* 继承`UINavigationController`
* 默认rootController是`XMNAlbumListController`
* 除了`didCancelPickingBlock` 会自动dismiss `XMNPhotoPickerController`,**其他回调方式均不会自动dismiss,需要手动dismiss**

| 属性        |  属性说明     |  作用           |
| ------------- | --- |:-------------:| 
| pickingVideoEnable   |    | 是否允许选择视频 | 
| autoPushToPhotoCollection     |   | 是否自动push到photoCollectionController界面   | 
| maxCount |   | 最大选择数量 ,默认视频一次只能选择一个,默认选择9个| 
| photoPickerDelegate |  | delegate 回调 方式|
| didFinishPickingPhotosBlock   |   | 确定选择图片的block回调方式 | 
| didFinishPickingVideoBlock     |   | 确定选择视频的block回调方式  | 
| didCancelPickingBlock |  readonly  | 确定取消选择的回调方式 | 


| 	方法        |  方法说明          | 作用 | 
| ------------- |:-------------:| --- | 
| `- (instancetype)initWithMaxCount:(NSUInteger)maxCount delegate:(id<XMNPhotoPickerControllerDelegate>)delegate NS_DESIGNATED_INITIALIZER;`| 初始化方法 | 初始化XMNPhotoPickerController |
| `- (void)didFinishPickingPhoto:(NSArray<XMNAssetModel *> *)assets;`      | public方法  | 提供给viewControllers 回调,会调用自身delegate以及block 的对应回调 | 
| `- (void)didFinishPickingVideo:(XMNAssetModel *)asset;`     | public方法   | 提供给viewControllers 唤起对应delegate,block 回调 |
| `- (void)didCancelPickingPhoto` |  public方法 | 提供给viewControllers 唤起对应delegate,block回调 |  

#####1.2.2 XMNAlbumListController

* 继承UITableViewController
* 使用tableView 展示album相册列表
* 点击后跳转到XMNPhotoCollectionController界面

###1.3 XMNPhotoPicker - 模仿QQ选择照片的Sheet,使用block回调

* 推荐使用单例`sharePhotoPicker`
* 支持手势滑动发送图片
* 支持预览图片 - `XMNPhotoPreviewController` 视频-`XMNVideoPreviewController`
* 支持使用系统相机拍照发送图片
* iOS8+支持动态监测系统图片变化

###1.4 照片预览XMNPhotoPreviewController 继承UICollectionController

* 继承UICollectionViewController
* 实现block 回调

###1.5 视频预览XMNVideoPreviewController

* 继承UIViewController
* 实现block回调