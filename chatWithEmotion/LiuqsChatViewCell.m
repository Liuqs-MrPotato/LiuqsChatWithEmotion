//
//  LiuqsChatViewCell.m
//  chatWithEmotion
//
//  Created by 刘全水 on 16/3/2.
//  Copyright © 2016年 刘全水. All rights reserved.
//

#import "LiuqsChatViewCell.h"
#define margin screenW * 5 / 320
#define headH screenW * 35 / 320

@implementation LiuqsChatViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"LiuqsChatCell";
    LiuqsChatViewCell *cell = [[LiuqsChatViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    return cell;
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.gifView = [[UIImageView alloc]init];
        [self.contentView addSubview:self.gifView];
        
        self.lineView = [[UIImageView alloc]init];
        self.lineView.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:self.lineView];
        
        self.emotionLabel = [[LiuqsEmotionLabel alloc]init];
        self.emotionLabel.numberOfLines = 0;
        [self.contentView addSubview:self.emotionLabel];
        
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress)];
        self.gifView.userInteractionEnabled = YES;
        [self.gifView addGestureRecognizer:longPress];
    }
    return self;
}


-(void)longPress
{
    NSLog(@"*******");
    
}

-(void)setCellFrame:(LiuqsCellFrame *)cellFrame
{
    _cellFrame = cellFrame;
    self.gifView.frame = cellFrame.gifViewFrame;
    self.gifView.gifPath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@.gif",cellFrame.message.gifName] ofType:nil];
    [self.gifView startGIFWithRunLoopMode:NSRunLoopCommonModes];
    self.lineView.frame = CGRectMake(0, self.cellFrame.cellHeight - 1, screenW, 1);
    self.emotionLabel.attributedText = cellFrame.message.attributedText;
    self.emotionLabel.frame = cellFrame.emotionLabelFrame;

}






@end
