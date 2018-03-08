//
//  NHImageViewCell.h
//  NHImagePickerDemo
//
//  Created by neghao on 2018/3/8.
//  Copyright © 2018年 neghao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NHImageViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end
