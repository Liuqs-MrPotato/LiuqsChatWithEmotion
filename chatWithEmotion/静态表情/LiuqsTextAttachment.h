//
//  LiuqsTextAttachment.h
//  chatWithEmotion
//
//  Created by 刘全水 on 16/7/25.
//  Copyright © 2016年 刘全水. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    //gif
    LiuqsEmotionTypeGif,
    //静态图
    LiuqsEmotionTypePng,
    
} LiuqsEmotionType;

@interface LiuqsTextAttachment : NSTextAttachment

@property(nonatomic, copy)   NSString *imageName;

@property(nonatomic, strong) NSString *emojiTag;

@property(nonatomic, assign) CGSize   emojiSize;

@property(nonatomic, assign) CGRect   emotionRect;

@property(nonatomic, assign) LiuqsEmotionType emotionType;

@end
