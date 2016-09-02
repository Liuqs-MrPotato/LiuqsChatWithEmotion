//
//  LiuqsTextAttachment.m
//  chatWithEmotion
//
//  Created by 刘全水 on 16/7/25.
//  Copyright © 2016年 刘全水. All rights reserved.
//

#import "LiuqsTextAttachment.h"

#define emotionRate 1.0

@implementation LiuqsTextAttachment

//在这个方法里返回附件的位置
- (CGRect)attachmentBoundsForTextContainer:(NSTextContainer *)textContainer proposedLineFragment:(CGRect)lineFrag glyphPosition:(CGPoint)position characterIndex:(NSUInteger)charIndex {
    
//    self.emotionRect = CGRectMake(position.x, position.y + 0.5, _emojiSize.width * emotionRate, _emojiSize.height * emotionRate);
    
    return CGRectMake(0, -4, _emojiSize.width * emotionRate, _emojiSize.height * emotionRate);
}


@end
