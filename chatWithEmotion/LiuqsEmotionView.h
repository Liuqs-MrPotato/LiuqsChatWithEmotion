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

///发送，删除等按钮的代理事件，用tag值区按钮！
-(void)emotionView_sBtnDidClick:(UIButton *)btn;
///gif表情的代理事件！
-(void)gifBtnClick:(UIButton *)btn;

@end

@interface LiuqsEmotionView : UIImageView <UIScrollViewDelegate>

///textView，输入框
@property(nonatomic, strong)UITextView    *IputView;
///发送按钮
@property(strong, nonatomic)UIButton      *sendBtn;
///底部条的按钮
@property(strong,nonatomic)UIButton       *emojiBtn;

@property(assign,nonatomic) id <LiuqsEmotionViewdelegate> delegate;


@end
