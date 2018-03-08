//
//  NHImagePicker.m
//  NHImagePickerDemo
//
//  Created by neghao on 2018/3/8.
//  Copyright © 2018年 neghao. All rights reserved.
//

#import "NHImagePicker.h"
#import <AssetsLibrary/AssetsLibrary.h>


@interface NHImagePicker()
@property (nonatomic, strong) UIViewController *presentingViewController;
@property (nonatomic, strong) ALAssetsLibrary *assetsLibrary;
@property (nonatomic, strong) NSMutableArray<NHAsseetsInfo *> *assetsDataArray;
@end

@implementation NHImagePicker


- (instancetype)initWithPresentingController:(UIViewController *)controller {
    self = [super init];
    if (self) {
        self.presentingViewController = controller;
        _assetsDataArray = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (void)openPhotoLibrary:(void(^)(NSMutableArray<NHAsseetsInfo *> *assetsDataArray))complete {
    
    ALAuthorizationStatus status = [ALAssetsLibrary authorizationStatus];

    if (status == ALAuthorizationStatusDenied) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Attention" message:@"Please give this app permission to access your photo library in your settings app!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        
    } else if (status == ALAuthorizationStatusNotDetermined) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Attention" message:@"Please settings app!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        
    } else {
        _assetsLibrary = [[ALAssetsLibrary alloc] init];
        __weak typeof(self) weakself = self;
        [_assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
            
            NSLog(@"number of assets = %ld",(long)group.numberOfAssets);

            [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
                
                if(result == nil) {
                    return;
                }
                
                NSLog(@"number of ALAsset = %ld",index);

              ALAssetRepresentation *representation = [result defaultRepresentation];
                
                UIImage *thumbnailImage = [UIImage imageWithCGImage:[result thumbnail]];
                UIImage *originalImage = [UIImage imageWithCGImage:[representation fullResolutionImage]];

                
                NHAsseetsInfo *info = [[NHAsseetsInfo alloc] init];
                info.thumbnail = thumbnailImage;
                info.originalImage = originalImage;
                info.isSelected = NO;
                info.imageURLString = [[representation url] absoluteURL];
                
                [weakself.assetsDataArray addObject:info];
                
                complete(weakself.assetsDataArray);
                
            }];
            
            
            
        } failureBlock:^(NSError *error) {
            NSLog(@"%@",error.localizedDescription);
        }];
    }

}



@end
