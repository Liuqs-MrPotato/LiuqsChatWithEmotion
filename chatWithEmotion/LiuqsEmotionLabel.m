//
//  LiuqsEmotionLabel.m
//  chatWithEmotion
//
//  Created by 刘全水 on 16/7/26.
//  Copyright © 2016年 刘全水. All rights reserved.
//

#import "LiuqsEmotionLabel.h"
#import <ImageIO/ImageIO.h>
#import "UIImageView+PlayGIF.h"
#import "UIImage+GIF.h"

@implementation LiuqsEmotionLabel

- (void)setAttributedText:(NSAttributedString *)attributedText {
    
    [super setAttributedText:attributedText];
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {

        if (obj){ [obj removeFromSuperview];}
    }];
    
    [self.attributedText enumerateAttribute:NSAttachmentAttributeName inRange:NSMakeRange(0, self.attributedText.length) options:0 usingBlock:^(LiuqsTextAttachment *value, NSRange range, BOOL * _Nonnull stop) {
        
        if (value) {
            
//            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
            
                NSString *imageName = [NSString stringWithFormat:@"%@.png",value.imageName];
                
                UIImageView *emojiView = [self imageViewWithImageName:imageName frame:value.emotionRect];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [self addSubview:emojiView];
//                });
            });
        }
    }];
}

- (UIImageView *)imageViewWithImageName:(NSString *)imageName frame:(CGRect)frame {

    UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:imageName ofType:nil];
    
    NSData *imageData = [NSData dataWithContentsOfFile:path];
    
    imageView.image = [UIImage imageWithData:imageData];
    
    return imageView;
}

- (UIImageView *)imageViewWithGIFName:(NSString *)imageName frame:(CGRect)frame {
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];

    NSString *path = [[NSBundle mainBundle] pathForResource:imageName ofType:nil];

    NSData *gifData = [NSData dataWithContentsOfFile:path];
    // GIF动画图片数组
    NSMutableArray *frames = nil;
    // 图像源引用
    CGImageSourceRef src = CGImageSourceCreateWithData((__bridge CFDataRef)gifData, NULL);
    // 动画时长
    CGFloat animationTime = 0.f;
    if (src) {
        // 获取gif图片的帧数
        size_t count = CGImageSourceGetCount(src);
        // 实例化图片数组
        frames = [NSMutableArray arrayWithCapacity:count];
        
        for (size_t i = 0; i < count; i++) {
            // 获取指定帧图像
            CGImageRef image = CGImageSourceCreateImageAtIndex(src, i, NULL);
            
            // 获取GIF动画时长
            NSDictionary *properties = (__bridge NSDictionary *)CGImageSourceCopyPropertiesAtIndex(src, i, NULL);
            
            NSDictionary *frameProperties = [properties objectForKey:(NSString *)kCGImagePropertyGIFDictionary];
            
            NSNumber *delayTime = [frameProperties objectForKey:(NSString *)kCGImagePropertyGIFUnclampedDelayTime];
            
            animationTime += [delayTime floatValue] + 0.08;
            
            if (image) {
                
                [frames addObject:[UIImage imageWithCGImage:image]];
                
                CGImageRelease(image);
            }
        }
        CFRelease(src);
    }
    [imageView setImage:[frames objectAtIndex:0]];
    
    [imageView setBackgroundColor:[UIColor clearColor]];
    
    [imageView setAnimationImages:frames];
    
    [imageView setAnimationDuration:animationTime];
    
    [imageView startAnimating];
    
    imageView.image = [UIImage imageWithData:gifData];
    
    return imageView;
}

@end
