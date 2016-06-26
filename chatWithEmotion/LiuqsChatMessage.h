//
//  LiuqsChatMessage.h
//  chatWithEmotion
//
//  Created by 刘全水 on 16/3/2.
//  Copyright © 2016年 刘全水. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LiuqsChatMessage : NSObject

@property(copy,nonatomic)NSString *text;

@property(copy,nonatomic)NSString *type;

@property(copy,nonatomic)NSString *gifName;

@property(nonatomic, copy)NSAttributedString *attributedText;


@end
