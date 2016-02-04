//
//  XMNPhotoPickerFramework.h
//  XMNPhotoPickerFrameworkExample
//  Created by XMFraker on 16/1/28.
//  Copyright © 2016年 XMFraker. All rights reserved.
//

//  如果您觉得代码还行,请给个star
//  GitHub:  https://github.com/ws00801526/XMNPhotoPickerFramework.git
//  如果您有任何关于本代码的问题
//  您可以在github上咨询我 或者QQ:3057600441

#ifndef XMNPhotoPickerFramework_h
#define XMNPhotoPickerFramework_h


//! Project version number for XMNPhotoPickerFramework.
FOUNDATION_EXPORT double kXMNPhotoPickerFrameworkVersionNumber;

//! Project version string for XMNPhotoPickerFramework.
FOUNDATION_EXPORT const unsigned char kXMNPhotoPickerFrameworkVersionString[];

#if __has_include(<XMNPhotoPickerFramework/XMNPhotoPickerFramework.h>)
#import <XMNPhotoPickerFramework/XMNPhotoManager.h>
#import <XMNPhotoPickerFramework/XMNPhotoPicker.h>
#import <XMNPhotoPickerFramework/XMNPhotoPickerController.h>
#else
#import "XMNPhotoManager.h"
#import "XMNPhotoPicker.h"
#import "XMNPhotoPickerController.h"
#endif


#endif /* XMNPhotoPickerFramework_h */
