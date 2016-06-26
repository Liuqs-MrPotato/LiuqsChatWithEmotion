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

+(NSMutableAttributedString *)changeStrWithStr:(NSString *)string andFont:(UIFont *)font;

@property(strong,nonatomic)UIFont *font;

@end
