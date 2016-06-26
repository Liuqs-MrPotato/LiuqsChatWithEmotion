//
//  LiuqsToolbarView.m
//  chatWithEmotion
//
//  Created by 刘全水 on 16/3/1.
//  Copyright © 2016年 刘全水. All rights reserved.
//

#import "LiuqsToolbarView.h"

#define Vgap screenW * 5 / 320
#define Lgap screenW * 10 / 320

@implementation LiuqsToolbarView

-(instancetype)init
{
    if (self = [super init]) {
        
        self.frame = toolBarFrameDown;
        self.userInteractionEnabled = YES;
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screenW, 0.5)];
        lineView.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:lineView];
        self.backgroundColor = bgColor;
    
        UITextView *textView = [[UITextView alloc]initWithFrame:CGRectMake(Lgap, Vgap, TextViewW, TextViewH)];
        self.textView = textView;
        textView.backgroundColor = [UIColor whiteColor];
        textView.returnKeyType = UIReturnKeySend;
        textView.layer.cornerRadius = 8;
        textView.layer.borderWidth = 0.5f;
        textView.scrollEnabled = YES;
        [_textView scrollRangeToVisible:NSMakeRange(_textView.text.length, 1)]; 
        textView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        [self addSubview:textView];
        
        UIButton *emotionBtn = [[UIButton alloc]initWithFrame:CGRectMake(emotionBtnX, Vgap, emotionBtnW, emotionBtnH)];
        self.toolBarEmotionBtn = emotionBtn;
        [emotionBtn setImage:[UIImage imageNamed:@"emotionBtn_no"] forState:UIControlStateNormal];
        [emotionBtn setImage:[UIImage imageNamed:@"emotionBtn_se"] forState:UIControlStateSelected];
        [emotionBtn addTarget:self action:@selector(emotionBtnDidClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:emotionBtn];

    }
    return self;
}

-(void)emotionBtnDidClicked:(UIButton *)emotionBtn
{
    
    if ([self.delegate respondsToSelector:@selector(ToolbarEmotionBtnDidClicked:)]) {
        [self.delegate ToolbarEmotionBtnDidClicked:emotionBtn];
    }
}

@end
