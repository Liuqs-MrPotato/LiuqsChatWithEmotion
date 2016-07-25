//
//  LiuqsTextAttachment.m
//  chatWithEmotion
//
//  Created by 刘全水 on 16/7/25.
//  Copyright © 2016年 刘全水. All rights reserved.
//

#import "LiuqsTextAttachment.h"

@implementation LiuqsTextAttachment

- (CGRect)attachmentBoundsForTextContainer:(NSTextContainer *)textContainer proposedLineFragment:(CGRect)lineFrag glyphPosition:(CGPoint)position characterIndex:(NSUInteger)charIndex {
    
    return CGRectMake(0, -3, _emojiSize.width, _emojiSize.height);
}

@end
