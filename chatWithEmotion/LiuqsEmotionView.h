//
//  LiuqsEmotionView.h
//  表情键盘
//
//  Created by 刘全水 on 15/12/15.
//  Copyright © 2015年 刘全水. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LiuqsTextAttachment.h"
#import "NSAttributedString+EmojiExtension.h"

@protocol LiuqsEmotionViewdelegate <NSObject>

-(void)emotionView_sBtnDidClick:(UIButton *)btn;

-(void)gifBtnClick:(UIButton *)btn;

@end

@interface LiuqsEmotionView : UIImageView <UIScrollViewDelegate>

@property(nonatomic, strong)UITextView    *IputView;

@property(strong, nonatomic)UIButton      *sendBtn;

@property(strong,nonatomic)UIButton       *emojiBtn;

@property(assign,nonatomic) id <LiuqsEmotionViewdelegate> delegate;


@end
