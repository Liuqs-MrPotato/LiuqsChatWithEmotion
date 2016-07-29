//
//  LiuqsChangeStrTool.m
//  表情键盘
//
//  Created by 刘全水 on 15/12/30.
//  Copyright © 2015年 刘全水. All rights reserved.
//

#import "LiuqsChangeStrTool.h"

#define checkStr @"\\[[a-zA-Z0-9\\u4e00-\\u9fa5]+\\]"

static CGSize                    _emotionSize;
static UIFont                    *_font;
static UIColor                   *_textColor;
static NSArray                   *_matches;
static NSString                  *_string;
static NSDictionary              *_emojiImages;
static NSMutableArray            *_imageDataArray;
static NSMutableAttributedString *_attStr;
static NSMutableAttributedString *_resultStr;

@implementation LiuqsChangeStrTool

+ (NSMutableAttributedString *)changeStrWithStr:(NSString *)string Font:(UIFont *)font TextColor:(UIColor *)textColor {
    
    _font      = font;
    _string    = string;
    _textColor = textColor;
    [self initProperty];
    [self executeMatch];
    [self setImageDataArray];
    [self setResultStrUseReplace];
    return _resultStr;
}

+ (void)initProperty {
    
    // 读取并加载对照表
    NSString *path = [[NSBundle mainBundle] pathForResource:@"LiuqsEmoji" ofType:@"plist"];

    _emojiImages = [NSDictionary dictionaryWithContentsOfFile:path];
    
    //设置文本参数
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    
    [paragraphStyle setLineSpacing:4.0f];
    
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:_textColor,NSForegroundColorAttributeName,_font,NSFontAttributeName,paragraphStyle,NSParagraphStyleAttributeName,nil];
    
    CGSize maxsize = CGSizeMake(1000, MAXFLOAT);
    
    _emotionSize = [@"/" boundingRectWithSize:maxsize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
    
    _attStr = [[NSMutableAttributedString alloc]initWithString:_string attributes:dict];
}


+ (void)executeMatch {
    
    //比对结果
    NSString *regexString = checkStr;
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regexString options:NSRegularExpressionCaseInsensitive error:nil];
    
    NSRange totalRange = NSMakeRange(0, [_string length]);
    
    _matches = [regex matchesInString:_string options:0 range:totalRange];
}

+ (void)setImageDataArray {
    
    NSMutableArray *imageDataArray = [NSMutableArray array];
    //遍历结果
    for (int i = (int)_matches.count - 1; i >= 0; i --) {
        
        NSMutableDictionary *record = [NSMutableDictionary dictionary];
        
        LiuqsTextAttachment *attachMent = [[LiuqsTextAttachment alloc]init];
        
        attachMent.emojiSize = CGSizeMake(_emotionSize.height, _emotionSize.height);
        
        NSTextCheckingResult *match = [_matches objectAtIndex:i];
        
        NSRange matchRange = [match range];
        
        NSString *tagString = [_string substringWithRange:matchRange];
        
        NSString *imageName = [_emojiImages objectForKey:tagString];
        
        if (imageName == nil || imageName.length == 0) break;
        
        NSString *cheakStr = [imageName substringWithRange:NSMakeRange(1, 2)];
       
        if ([cheakStr intValue] > 60) {
            
            NSString *path = [[NSBundle mainBundle] pathForResource:imageName ofType:@"gif"];
            
            NSData *gifData = [NSData dataWithContentsOfFile:path];
            
            attachMent.contents = gifData;
            
            attachMent.fileType = @"gif";
            
//            attachMent.imageName = imageName;
            
//            attachMent.emotionType = LiuqsEmotionTypeGif;
            
        }else {
        
//            attachMent.emotionType = LiuqsEmotionTypePng;
            
            attachMent.image = [UIImage imageNamed:imageName]; 
        }
        
        NSAttributedString *imageStr = [NSAttributedString attributedStringWithAttachment:attachMent];
        
        [record setObject:[NSValue valueWithRange:matchRange] forKey:@"range"];
        
        [record setObject:imageStr forKey:@"image"];
        
        [imageDataArray addObject:record];
    }
    _imageDataArray = imageDataArray;
}

+ (void)setResultStrUseReplace{
    
    NSMutableAttributedString *result = _attStr;
    
    for (int i = 0; i < _imageDataArray.count ; i ++) {
        
        NSRange range = [_imageDataArray[i][@"range"] rangeValue];
        
        NSDictionary *imageDic = [_imageDataArray objectAtIndex:i];
        
        NSMutableAttributedString *imageStr = [imageDic objectForKey:@"image"];
        
        [result replaceCharactersInRange:range withAttributedString:imageStr];
    }
    _resultStr = result;
}


+ (NSString *)changeTextToHtmlStrWithText:(NSString *)text {

    _string = text;
    // 读取并加载对照表
    NSString *path = [[NSBundle mainBundle] pathForResource:@"LiuqsEmoji" ofType:@"plist"];
    
    _emojiImages = [NSDictionary dictionaryWithContentsOfFile:path];
    
    return nil;
}

+ (void)getHtmlStrimg {

    //比对结果
    NSString *regexString = checkStr;
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regexString options:NSRegularExpressionCaseInsensitive error:nil];
    
    NSRange totalRange = NSMakeRange(0, [_string length]);
    
    __block NSRange lastRange = NSMakeRange(0, 0);
    
    __block NSString *htmlStr;
    
    [regex enumerateMatchesInString:_string options:0 range:totalRange usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
        
        NSRange currentRange = [result range];
        
        NSString *tagString = [_string substringWithRange:currentRange];
        
        NSString *imageName = [_emojiImages objectForKey:tagString];
        
        if (currentRange.location == 0) {//开头就是表情 [哈哈]。。。。
            
            // 创建表情字符创拼接
        }else if (lastRange.location == 0){//开头是文字的，你好[哈哈]。。。。
            //先拼接上一段文字然后创建表情字符串拼接
        
        }else if (lastRange.location + 1 != currentRange.location) {//表情中间加文字 你好[哈哈]你好。。。。
            //先拼接上一段文字然后创建表情字符串拼接
        }else if (lastRange.location + 1 == currentRange.location) {//表情中间不加文字 。。。[哈哈][哈哈]。。。
            //创建表情拼接
        }
        
    }];
}


@end
