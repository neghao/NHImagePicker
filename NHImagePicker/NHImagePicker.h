//
//  NHImagePicker.h
//  NHImagePickerDemo
//
//  Created by neghao on 2018/3/8.
//  Copyright © 2018年 neghao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NHAsseetsInfo.h"


@interface NHImagePicker : NSObject

-(instancetype)initWithPresentingController:(UIViewController *)controller;

- (void)openPhotoLibrary:(void(^)(NSMutableArray<NHAsseetsInfo *> *assetsDataArray))complete;

@end
