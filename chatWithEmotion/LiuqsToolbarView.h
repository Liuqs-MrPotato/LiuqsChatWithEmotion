//
//  LiuqsToolbarView.h
//  chatWithEmotion
//
//  Created by 刘全水 on 16/3/1.
//  Copyright © 2016年 刘全水. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LiuqsToolBarDelegate <NSObject>

///代理方法，点击表情按钮触发方法
-(void)ToolbarEmotionBtnDidClicked:(UIButton *)emotionBtn;


@end

@interface LiuqsToolbarView : UIImageView 

///toolbar代理
@property(assign,nonatomic)id <LiuqsToolBarDelegate> delegate;

///toolbar上面的输入框
@property(strong,nonatomic)UITextView *textView;

///表情按钮
@property(strong,nonatomic)UIButton *toolBarEmotionBtn;

@end
