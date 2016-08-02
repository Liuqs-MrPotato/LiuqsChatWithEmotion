//
//  LiuqsCellFrame.m
//  chatWithEmotion
//
//  Created by 刘全水 on 16/3/2.
//  Copyright © 2016年 刘全水. All rights reserved.
//

#import "LiuqsCellFrame.h"


@implementation LiuqsCellFrame

-(void)setMessage:(LiuqsChatMessage *)message
{
    _message = message;
    
    if ([message.type isEqualToString:@"gif"]) {
        
        self.gifViewFrame = CGRectMake((screenW - 100) / 2, 10, 100, 100);
        
        self.cellHeight = 120;
        
    }else if ([message.type isEqualToString:@"message"]) {
        
//        匹对字符串，获取富文本
        NSMutableAttributedString *text = [LiuqsChangeStrTool changeStrWithStr:message.text Font:[UIFont systemFontOfSize:20] TextColor:[UIColor blackColor]];
        CGSize maxsize = CGSizeMake(screenW - 20, MAXFLOAT);
//        设置富文本的参数
        [text addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17.0f] range:NSMakeRange(0, text.length)];
//        文字自适应
        CGSize TextSize = [text boundingRectWithSize:maxsize options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
//        CGSize TextSize = [self getSizeWithFont:[UIFont systemFontOfSize:17] andText:message.text];

//        self.message.attributedText = (NSMutableAttributedString*)text;
        
        NSString *htmlStr = [LiuqsChangeStrTool changeTextToHtmlStrWithText:message.text];
        
        self.htmlURlStr = htmlStr;
        
        //计算控件frame
        self.emotionLabelFrame = CGRectMake(10, 0, TextSize.width + 7.5, TextSize.height + 2);
        
        //计算cell高度
        self.cellHeight = TextSize.height + 2;
    
    }
}

//动态计算size方法
- (CGSize )getSizeWithFont:(UIFont *)font andText:(NSString *)text{
    
    //动态计算label的宽度
    NSDictionary *dict = @{NSFontAttributeName:font};
    
    CGSize maxsize = CGSizeMake(screenW - 20 , MAXFLOAT);
    
    CGSize size = [text boundingRectWithSize:maxsize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
    
    return size;
}

@end
