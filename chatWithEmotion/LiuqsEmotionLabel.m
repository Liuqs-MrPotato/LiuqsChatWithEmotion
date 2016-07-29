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

//- (void)setAttributedText:(NSAttributedString *)attributedText {
//    
//    [super setAttributedText:attributedText];
//
//    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        
//        if (obj){ [obj removeFromSuperview];}
//    }];
//    
//    [self.attributedText enumerateAttribute:NSAttachmentAttributeName inRange:NSMakeRange(0, self.attributedText.length) options:0 usingBlock:^(LiuqsTextAttachment *value, NSRange range, BOOL * _Nonnull stop) {
//        
//        if (value && value.emotionType == LiuqsEmotionTypeGif) {
//            
//            UIImageView *emojiView = [[UIImageView alloc]initWithFrame:value.emotionRect];
//            
//            NSString *gifName = [NSString stringWithFormat:@"%@.gif",value.imageName];
//            
//            emojiView.image = [UIImage imageNamed:gifName];
//            
//            [self addSubview:emojiView];
//            
//            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
//            
//                NSMutableArray *images = [self getAnimationImageWithGifName:gifName];
//                
//                [emojiView setAnimationImages:[images objectAtIndex:0]];
//                
//                [emojiView setAnimationDuration:[[images objectAtIndex:1] floatValue]];
//                
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    
//                    [emojiView startAnimating];
//                });
//            });
//        }
//    }];
//}
//
//- (NSMutableArray<UIImage *> *)getAnimationImageWithGifName:(NSString *)imageName {
//
//    
//    NSMutableArray *result = [NSMutableArray array];
//    // 加载gif文件数据
//    NSString *path = [[NSBundle mainBundle] pathForResource:imageName ofType:nil];
//    
//    // 获取gif二进制数据
//    NSData *gifData = [NSData dataWithContentsOfFile:path];
//    
//    // GIF动画图片数组
//    NSMutableArray *frames = nil;
//    // 图像源引用
//    CGImageSourceRef src = CGImageSourceCreateWithData((__bridge CFDataRef)gifData, NULL);
//    // 动画时长
//    CGFloat animationTime = 0.f;
//    
//    if (src) {
//        // 获取gif图片的帧数
//        size_t count = CGImageSourceGetCount(src);
//        // 实例化图片数组
//        frames = [NSMutableArray arrayWithCapacity:count];
//        
//        for (size_t i = 0; i < count; i++) {
//            // 获取指定帧图像
//            CGImageRef image = CGImageSourceCreateImageAtIndex(src, i, NULL);
//            
//            // 获取GIF动画时长
//            NSDictionary *properties = (__bridge NSDictionary *)CGImageSourceCopyPropertiesAtIndex(src, i, NULL);
//            NSDictionary *frameProperties = [properties objectForKey:(NSString *)kCGImagePropertyGIFDictionary];
//            NSNumber *delayTime = [frameProperties objectForKey:(NSString *)kCGImagePropertyGIFUnclampedDelayTime];
//            animationTime += [delayTime floatValue] + 0.08;
//            
//            if (image) {
//                [frames addObject:[UIImage imageWithCGImage:image]];
//                CGImageRelease(image);
//            }
//        }
//        CFRelease(src);
//    }
//    
//    NSNumber *time = [NSNumber numberWithFloat:animationTime];
//    
//    [result addObject:frames];
//    
//    [result addObject:time];
//    
//    return result;
//}



@end
