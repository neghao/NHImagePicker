//
//  NHImageViewCell.m
//  NHImagePickerDemo
//
//  Created by neghao on 2018/3/8.
//  Copyright © 2018年 neghao. All rights reserved.
//

#import "NHImageViewCell.h"
#import "NHPhotoBrowserScrollView.h"

@interface NHImageViewCell ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet NHPhotoBrowserScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic, weak) UIPinchGestureRecognizer *pinchGesture;

@end

@implementation NHImageViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
//    UIImageView *imageView = [[UIImageView alloc] init];
//    imageView.contentMode = UIViewContentModeCenter;
//    [_scrollView addSubview:imageView];
//    _scrollView.delegate = self;
//    _scrollView.bounces = NO;
//    _imageView = imageView;
//
//    // 比例
//    _scrollView.maximumZoomScale = 1;
//    _scrollView.minimumZoomScale = 1;
//
//    UIPinchGestureRecognizer *pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(changeImageScale:)];
////    [_scrollView addGestureRecognizer:pinchGesture];
//    _pinchGesture = pinchGesture;
    
}


- (void)setImage:(UIImage *)image {
    
    
//     image = [UIImage imageNamed:@"1092.jpg"];

//    NSURL *url = [NSURL URLWithString:@"http://c.hiphotos.baidu.com/image/pic/item/024f78f0f736afc33b1dbe65b119ebc4b7451298.jpg"];
//    NSData *data= [NSData dataWithContentsOfURL:url];
//     image = [UIImage imageWithData:data];
    
    
    CGFloat imageWidth = image.size.width;
    CGFloat imageHeight = image.size.height;
    
    [_scrollView setPhotoImage:image];

}

@end
