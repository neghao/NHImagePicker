//
//  ViewController.m
//  NHImagePickerDemo
//
//  Created by neghao on 2018/3/8.
//  Copyright © 2018年 neghao. All rights reserved.
//

#import "ViewController.h"
#import "NHImagePicker.h"
#import "NHImageViewCell.h"



@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic, strong) NHImagePicker *imagePicker;

@property (nonatomic, strong) NSArray<NHAsseetsInfo *> *assetsDataArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _imagePicker = [[NHImagePicker alloc] initWithPresentingController:self];

    
    [_collectionView registerNib:[UINib nibWithNibName:@"NHImageViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    
}


- (IBAction)FormPhotoLibrary:(UIBarButtonItem *)sender {
    [_imagePicker openPhotoLibrary:^(NSMutableArray<NHAsseetsInfo *> *assetsDataArray) {
 
        _assetsDataArray = assetsDataArray.copy;

        [_collectionView reloadData];
    }];
}


- (IBAction)formCamera:(UIBarButtonItem *)sender {
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NHImageViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    UIImage *image = [_assetsDataArray objectAtIndex:indexPath.item].originalImage;

    [cell setImage:image];
    
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return _assetsDataArray.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(collectionView.bounds.size.width, collectionView.bounds.size.height-64);
}

@end
