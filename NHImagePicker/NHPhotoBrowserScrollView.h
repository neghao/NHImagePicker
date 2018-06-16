//
//  NHPhotoBrowserScrollView.h
//  NHImagePickerDemo
//
//  Created by neghao on 2018/3/13.
//  Copyright © 2018年 neghao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NHAsseetsInfo.h"


@interface NHPhotoBrowserScrollView : UIScrollView
@property (nonatomic, strong) NHAsseetsInfo *photoInfo;
@property (nonatomic, strong) UIImage *photoImage;

@end
