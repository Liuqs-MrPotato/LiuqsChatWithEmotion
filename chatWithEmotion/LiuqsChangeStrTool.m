//
//  LiuqsChangeStrTool.m
//  表情键盘
//
//  Created by 刘全水 on 15/12/30.
//  Copyright © 2015年 刘全水. All rights reserved.
//

#import "LiuqsChangeStrTool.h"
#import "EmotionCodeTable.h"


@implementation LiuqsChangeStrTool

+(NSMutableAttributedString *)changeStrWithStr:(NSString *)string andFont:(UIFont *)font
{
    //设置行间距
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    [paragraphStyle setLineSpacing:1.0];
    //计算表情高度
    NSDictionary *dict = @{NSFontAttributeName:font,NSParagraphStyleAttributeName:paragraphStyle};
    
    //根据字体获取文字高度，用来设置表情的大小
    CGSize maxsize = CGSizeMake(1000, MAXFLOAT);
    CGSize size = [@"/" boundingRectWithSize:maxsize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
    //正则验证
    NSString *regexString = @"\\[[a-zA-Z0-9\\u4e00-\\u9fa5]+\\]";
    //最终要返回的富文本
    NSMutableAttributedString * attStr = [[NSMutableAttributedString alloc]initWithString:string attributes:dict];
    
    //根据正则匹对字符串中的表情（编码）和位置
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regexString options:NSRegularExpressionCaseInsensitive error:nil];
    
    NSArray *matches = [regex matchesInString:string options:0 range:NSMakeRange(0, [string length])];
    
    //用来存放表情图片
    NSMutableArray *imageDataArray = [NSMutableArray array];
    
    // 用下面的办法来遍历每一条匹配记录
    for (int i = (int)matches.count - 1; i >= 0; i --) {
        
        //用来记录表情对应的位置
        NSMutableDictionary *record = [NSMutableDictionary dictionary];
        
        //创建附件
        NSTextAttachment *attachMent = [[NSTextAttachment alloc]init];
        //设置附件的大小
        attachMent.bounds = CGRectMake(0, -4, size.height, size.height);
        
        NSTextCheckingResult *match = [matches objectAtIndex:i];
        
        NSRange matchRange = [match range];
        
        NSString *tagString = [string substringWithRange:matchRange];
        
        NSString *imageName = [_emojiImages objectForKey:tagString];
        
        UIImage *image = [UIImage imageNamed:imageName];
        
        if (image == nil) {
           //图片不存在，不做操作
            
        }else
        {
            //图片存在就记录表情的位置
            attachMent.image = image;
            NSAttributedString *imageStr = [NSAttributedString attributedStringWithAttachment:attachMent];
            
            [record setObject:[NSValue valueWithRange:matchRange] forKey:@"range"];
            
            [record setObject:imageStr forKey:@"image"];
            
            [imageDataArray addObject:record];
        }
    }
        
        for (int i = 0; i < imageDataArray.count ; i ++) {
            
            //根据记录的位置换图
    
            NSRange range = [imageDataArray[i][@"range"] rangeValue];
            
            NSDictionary *imageDic = [imageDataArray objectAtIndex:i];
            
            NSMutableAttributedString *imageStr = [imageDic objectForKey:@"image"];
            
            [attStr replaceCharactersInRange:range withAttributedString:imageStr];
        
        }
    
    return attStr;
}



    
@end
