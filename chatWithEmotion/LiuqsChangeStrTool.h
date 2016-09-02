//
//  LiuqsChangeStrTool.h
//  表情键盘
//
//  Created by 刘全水 on 15/12/30.
//  Copyright © 2015年 刘全水. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LiuqsChangeStrTool : NSObject

///转码方法，会返回一个富文本！需要传入文本，字体，或者字体颜色，不给默认为黑色！可以根据需求改这个方法！
+ (NSMutableAttributedString *)changeStrWithStr:(NSString *)string Font:(UIFont *)font TextColor:(UIColor *)textColor;

///这个是研究新方式加载，目前还有问题！
+ (NSString *)changeTextToHtmlStrWithText:(NSString *)text;

@end
