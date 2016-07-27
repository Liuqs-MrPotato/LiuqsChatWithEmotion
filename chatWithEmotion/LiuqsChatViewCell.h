//
//  LiuqsChatViewCell.h
//  chatWithEmotion
//
//  Created by 刘全水 on 16/3/2.
//  Copyright © 2016年 刘全水. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LiuqsCellFrame.h"
#import "LiuqsChatMessage.h"
#import "LiuqsEmotionLabel.h"

@interface LiuqsChatViewCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property(nonatomic ,strong)UIImageView *gifView;

@property(nonatomic ,strong)UIImageView *lineView;

@property(nonatomic ,strong)LiuqsCellFrame *cellFrame;

@property(nonatomic ,strong)LiuqsEmotionLabel *emotionLabel;

@property(nonatomic, assign)BOOL isAsync;

@property(nonatomic, strong)LiuqsChatMessage *message;

@property(nonatomic,strong)UIButton *headIcon;

@property(nonatomic,strong)UILabel *timeLabel;


@end
