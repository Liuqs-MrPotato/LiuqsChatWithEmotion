//
// Created by zorro on 15/3/7.
// Copyright (c) 2015 tutuge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSAttributedString+EmojiExtension.h"
#import "LiuqsTextAttachment.h"

@implementation NSAttributedString (EmojiExtension)

- (NSString *)getPlainString {
    
    NSMutableString *plainString = [NSMutableString stringWithString:self.string];
    __block NSUInteger base = 0;
    [self enumerateAttribute:NSAttachmentAttributeName inRange:NSMakeRange(0, self.length)
                     options:0
                  usingBlock:^(LiuqsTextAttachment *value, NSRange range, BOOL *stop) {
                      if (value) {
                          [plainString replaceCharactersInRange:NSMakeRange(range.location + base, range.length)
                                                     withString:value.emojiTag];
                          base += value.emojiTag.length - 1;
                      }
                  }];
    return plainString;
}

@end
