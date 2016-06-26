//
//  UIImage+Extension.h
//
//  Created by 👄 on 15/6/4.
//  Copyright (c) 2015年 ；. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)

+(UIImage *)resizableImage:(NSString *)name;
+(UIImage*) createImageWithColor:(UIColor*) color;

+ (UIImage *) image: (UIImage *) image fillSize: (CGSize) viewsize;

+ (UIImage *) image: (UIImage *) image centerInSize: (CGSize) viewsize;
+ (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize;
+ (CGSize) fitSize: (CGSize)thisSize inSize: (CGSize) aSize;

+ (UIImage *)fixOrientation:(UIImage *)aImage;

+ (CGSize)downloadImageSizeWithURL:(id)imageURL;

+(UIImage *)resizebleImageWithName:(NSString *)imageName;

+ (UIImage *)image:(UIImage*)image byScalingToSize:(CGSize)targetSize;

+ (UIImage *)resizeImage:(NSString *)imageName;



@end
