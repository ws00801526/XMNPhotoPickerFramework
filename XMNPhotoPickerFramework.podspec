Pod::Spec.new do |s|
  s.name         = "XMNPhotoPickerFramework"
  s.version      = "1.0.1"
  s.summary      = "模仿微信选择图片类库"
  s.description  = "选择图片"
  s.homepage     = "https://github.com/ws00801526/XMNPhotoPickerFramework"
  s.license      = "MIT"
  s.author       = { "XMFraker" => "3057600441@qq.com" }  
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/ws00801526/XMNPhotoPickerFramework", :tag => s.version }
  s.source_files = "XMNPhotoPickerFramework/**/*.{h,m}"
  s.ios.frameworks   = "UIKit", "Foundation"
  s.requires_arc = true
  s.resources = ["XMNPhotoPickerFramework/PhotoPickerKit.xcassets","XMNPhotoPickerFramework/Views/*.xib"]
end
