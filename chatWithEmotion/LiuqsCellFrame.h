//
//  LiuqsCellFrame.h
//  chatWithEmotion
//
//  Created by 刘全水 on 16/3/2.
//  Copyright © 2016年 刘全水. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LiuqsChatMessage.h"

@interface LiuqsCellFrame : NSObject

@property(nonatomic, strong)LiuqsChatMessage *message;

@property(nonatomic, assign)CGFloat  cellHeight;

@property(nonatomic, assign)CGRect   gifViewFrame;

@property(nonatomic, assign)CGRect   emotionLabelFrame;

@property(nonatomic, assign)CGRect   headIconFrame;

@property(nonatomic, copy)  NSString *htmlURlStr;

@end
