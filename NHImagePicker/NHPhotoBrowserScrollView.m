//
//  NHPhotoBrowserScrollView.m
//  NHImagePickerDemo
//
//  Created by neghao on 2018/3/13.
//  Copyright © 2018年 neghao. All rights reserved.
//

#import "NHPhotoBrowserScrollView.h"
#import "NHPhotoBrowserImageView.h"
#import "NHPhotoBorwserTapView.h"


@interface NHPhotoBrowserScrollView ()<UIScrollViewDelegate>{
    CGFloat _maxScale;
    CGFloat _minScale;
    CGFloat _zoomScaleFromInit;
    BOOL _isBigScale;
    BOOL _isNotFirst;
}
@property (nonatomic, strong) NHPhotoBrowserImageView *photoImageView;

@end

@implementation NHPhotoBrowserScrollView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initConfig];
        [self initializeSubviews];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initConfig];
    [self initializeSubviews];
}

/**
 初始化配置
 */
- (void)initConfig {
    self.contentSize = CGSizeZero;
    self.backgroundColor = [UIColor blackColor];
    self.showsVerticalScrollIndicator = NO;
    self.showsHorizontalScrollIndicator = NO;
    self.decelerationRate = UIScrollViewDecelerationRateFast;
    self.delegate = self;
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
}


/**
 初始化子视图
 */
- (void)initializeSubviews {
    _photoImageView = [[NHPhotoBrowserImageView alloc] init];
    _photoImageView.contentMode = UIViewContentModeCenter;
    [self addSubview:_photoImageView];
    _photoImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
}


- (void)setPhotoInfo:(NHAsseetsInfo *)photoInfo {
    _photoInfo = photoInfo;
    [self setPhotoImage:photoInfo.originalImage];
    
}

- (void)setPhotoImage:(UIImage *)photoImage {
    _photoImage = photoImage;
    [_photoImageView setImage:photoImage];
    [self displayImage];
    
}


- (void)displayImage {
    self.maximumZoomScale = 1;
    self.minimumZoomScale = 1;
    self.zoomScale = 1;
    
    self.contentSize = CGSizeZero;
    [_photoImageView setHidden:NO];
    
    // Setup photo frame
    CGRect photoImageViewFrame;
    photoImageViewFrame.origin = CGPointZero;
    photoImageViewFrame.size = _photoImage.size;
    _photoImageView.frame = photoImageViewFrame;
    self.contentSize = _photoImage.size;

    NSLog(@"photoImageViewFrame: %@",NSStringFromCGRect(photoImageViewFrame));
    
    [self setMaxMinZoomScalesForCurrentBounds];
    
}

- (void)setMaxMinZoomScalesForCurrentBounds {

    if (!_photoImage) {
        return;
    }
    
    // Reset
    self.maximumZoomScale = 1;
    self.minimumZoomScale = 1;
    self.zoomScale = 1;
    
    // Sizes
    CGSize boundsSize = self.bounds.size;
    CGSize imageSize = _photoImageView.frame.size;
    
    
    CGFloat xMaxScale = boundsSize.width / imageSize.width;
    CGFloat yMaxScale = boundsSize.height / imageSize.height;
    _minScale = MIN(xMaxScale, yMaxScale);
    
    
    if (xMaxScale > 1.f && yMaxScale > 1.f) {
        _minScale = 1.0;
    }
    
    _maxScale = _minScale * 2;
    
    
    self.maximumZoomScale = _maxScale;
    self.minimumZoomScale = _minScale;
    self.zoomScale = _minScale;
    _zoomScaleFromInit = _minScale;
    _photoImageView.frame = CGRectMake(0, 0, _photoImageView.width, _photoImageView.height);
    
    
    [self setNeedsLayout];
}


- (void)layoutSubviews {
    [super layoutSubviews];
    [self makeSubviewsConstraints];
}


/**
 添加子视图约束
 */
- (void)makeSubviewsConstraints {
    
    // 让图片居中显示
    CGSize boundsSize = self.bounds.size;
    CGRect frameToCenter = _photoImageView.frame;
    
    // Horizontally
    if (frameToCenter.size.width < boundsSize.width) {
        frameToCenter.origin.x = floorf((boundsSize.width - frameToCenter.size.width) / 2.0);
    } else {
        frameToCenter.origin.x = 0;
    }
    
    // Vertically
    if (frameToCenter.size.height < boundsSize.height) {
        frameToCenter.origin.y = floorf((boundsSize.height - frameToCenter.size.height) / 2.0);
    } else {
        frameToCenter.origin.y = 0;
    }
    
    if (!CGRectEqualToRect(_photoImageView.frame, frameToCenter))
    {
        _photoImageView.frame = frameToCenter;
    }
    
}


#pragma mark - UIScrollViewDelegate
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return _photoImageView;
}


- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    [self setNeedsLayout];
    [self layoutIfNeeded];
}










@end
