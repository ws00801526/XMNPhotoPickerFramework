Pod::Spec.new do |s|
  s.name         = "XMNPhotoFramework"
  s.version      = "1.0.4"
  s.summary      = "模仿微信选择图片类库"
  s.description  = "模仿微信选择图片类库 - V1.0.4版本 增加了类似QQ的stick功能 修复部分的内存问题 修复bug"
  s.homepage     = "https://github.com/ws00801526/XMNPhotoPickerFramework"
  s.license      = "MIT"
  s.author       = { "XMFraker" => "3057600441@qq.com" }  
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/ws00801526/XMNPhotoPickerFramework.git", :tag => s.version }
  s.ios.frameworks   = "UIKit", "Foundation"
  s.requires_arc = true
  s.default_subspec = 'Picker'

  s.subspec 'Picker' do |ss|
    ss.source_files = "XMNPhotoPicker/XMNPhotoPicker/**/*.{h,m}"
    ss.resources = ["XMNPhotoPicker/XMNPhotoPicker/PhotoPickerKit.xcassets","XMNPhotoPicker/XMNPhotoPicker/Views/*.xib"]
  end

  s.subspec 'Browser' do |ss|
    ss.source_files = "XMNPhotoBrowser/XMNPhotoBrowser/Controllers/*.{h,m}","XMNPhotoBrowser/XMNPhotoBrowser/Models/*.{h,m}","XMNPhotoBrowser/XMNPhotoBrowser/Views/*.{h,m}","XMNPhotoBrowser/XMNPhotoBrowser/XMNPhotoBrowser.h"
    ss.dependency 'YYWebImage'
  end
end
