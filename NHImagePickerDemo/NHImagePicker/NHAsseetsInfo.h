//
//  NHAsseetsInfo.h
//  NHImagePickerDemo
//
//  Created by neghao on 2018/3/8.
//  Copyright © 2018年 neghao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface NHAsseetsInfo : NSObject

@property (nonatomic, strong) UIImage *thumbnail;
@property (nonatomic, strong) UIImage *originalImage;
@property (nonatomic, strong) NSString *imageURLString;
@property (nonatomic, strong) NSString *describe;
@property (nonatomic) BOOL isSelected;
@property (nonatomic) BOOL currectlySelected;

@end
