//
//  LiuqsChtaDetailViewController.m
//  chatWithEmotion
//
//  Created by 刘全水 on 16/2/16.
//  Copyright © 2016年 刘全水. All rights reserved.
//

#import "LiuqsChtaDetailViewController.h"
#import "LiuqsToolbarView.h"
#import "LiuqsEmotionView.h"
#import "LiuqsChatMessage.h"
#import "LiuqsCellFrame.h"
#import "LiuqsChatViewCell.h"

@interface LiuqsChtaDetailViewController () <UITextViewDelegate,LiuqsToolBarDelegate,LiuqsEmotionViewdelegate,UIGestureRecognizerDelegate,UITableViewDataSource,UITableViewDelegate>

@property(nonatomic ,strong)UITextView *textView;

@property(nonatomic ,strong)UIButton *emotionBtn;

@property(nonatomic,strong)LiuqsEmotionView *emotionview;

@property(nonatomic,strong)LiuqsToolbarView *toolBarView;

@property(assign,nonatomic)CGFloat keyBoardH;

@property(strong,nonatomic)UITableView *tableView;

@property(strong,nonatomic)NSMutableArray *dataSourceArray;


@end

@implementation LiuqsChtaDetailViewController

//懒加载创建表情键盘
-(LiuqsEmotionView *)emotionview
{
    if (!_emotionview) {
        _emotionview = [[LiuqsEmotionView alloc]initWithFrame:emotionDownFrame];
        self.emotionview.IputView = self.toolBarView.textView;
        self.emotionview.delegate = self;
        [self.view addSubview:self.emotionview];
    }
    return _emotionview;
}

-(NSMutableArray *)dataSourceArray
{
    if (!_dataSourceArray) {
        _dataSourceArray = [NSMutableArray array];
    }
    return _dataSourceArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self createExampleData];
    [self creatTableView];
    [self creatToolBar];
    [self setNoti];
    [self creatNavgationBar];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsCompact];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

- (void)viewDidAppear:(BOOL)animated {

    [super viewDidAppear:animated];
    self.emotionview.IputView = self.toolBarView.textView;
}

- (void)createExampleData {
    
    LiuqsCellFrame   *cellFrame = [LiuqsCellFrame new];
    LiuqsChatMessage *message = [LiuqsChatMessage new];
    for (int i = 1; i < 3; i ++) {
       
        if (i % 2 == 0) {
           
            message.text = @"在村里，Lz辈分比较大，在我还是小屁孩的时候就有大人喊我叔了，这不算糗。 成年之后，鼓起勇气向村花二丫深情表白了(当然是没有血缘关系的)，结果她一脸淡定的回绝了:“二叔！别闹……";
            message.type = @"message";
        }else {
        
            message.text = @"小学六年级书法课后不知是哪个用红纸写了张六畜兴旺贴教室门上，上课语文老师看看门走了，过了一会才来，过了几天去办公室交作业听见语文老师说：看见那几个字我本来是不想进去的，但是后来一想养猪的也得进去喂猪";
            message.type = @"message";
        }
         cellFrame.message = message;
        
        [self.dataSourceArray addObject:cellFrame];
    }
    
    [_tableView reloadData];
}

-(void)creatTableView
{
    UITableView *tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, screenW, screenH-64-self.toolBarView.height)];
    self.tableView = tableview;
    tableview.backgroundColor = [UIColor orangeColor];
    tableview.showsVerticalScrollIndicator = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    tableview.dataSource = self;
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableview.delegate = self;
    tableview.backgroundColor = BACKGROUND_COLOR;
    [self.view addSubview:tableview];
    
    // 单击手势用于退出键盘
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapTable)];
    tap.delegate = self;
    [tableview addGestureRecognizer:tap];
    
}

-(void)tapTable
{
    [self.textView resignFirstResponder];
    self.toolBarView.toolBarEmotionBtn.selected = NO;
    if (self.textView.text.length == 0) {
        [UIView animateWithDuration:emotionTipTime animations:^{
            self.emotionview.frame = emotionDownFrame;
            self.toolBarView.frame = toolBarFrameDown;
        }];
    }else
    {
      self.emotionview.frame = emotionDownFrame;
        self.toolBarView.frame = CGRectMake(0, screenH - self.toolBarView.height, screenW, self.toolBarView.height);
    }
    [UIView animateWithDuration:emotionTipTime animations:^{
        self.tableView.height = screenH - self.toolBarView.height - 64;
    }];
}

-(void)creatNavgationBar
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    UIButton *BackBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    BackBtn.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    [BackBtn addTarget:self action:@selector(backBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
    [BackBtn setImage:[UIImage imageNamed:@"navigationbar_back_highlighted"] forState:UIControlStateNormal];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:BackBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    
}

-(void)backBtnDidClick
{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)setNoti
{
    // 键盘frame将要改变就会接受到通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    // 键盘将要收起时候发出通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

//键盘弹出
-(void)keyboardWillChangeFrame:(NSNotification *)noti
{
    CGRect keyBoardFrame = [[(NSDictionary *)noti.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    CGFloat height = keyBoardFrame.origin.y + keyBoardFrame.size.height;

    if (height > screenH) {
        
        self.toolBarView.toolBarEmotionBtn.selected = YES;
        [UIView animateWithDuration:emotionTipTime animations:^{
            self.toolBarView.frame = CGRectMake(0, screenH - self.toolBarView.height - self.emotionview.height, screenW, self.toolBarView.height);
        }];
        
    }else
    {
        [UIView animateWithDuration:emotionTipTime animations:^{
            self.toolBarView.frame = CGRectMake(0, screenH - self.toolBarView.height - keyBoardFrame.size.height, screenW, self.toolBarView.height);
        }];
    }
    self.keyBoardH = keyBoardFrame.size.height;
}

//键盘弹回
-(void)keyboardWillHide:(NSNotification *)noti
{
    self.keyBoardH = 0;
}

//创建toolbar
-(void)creatToolBar
{
    LiuqsToolbarView *toolBarView = [[LiuqsToolbarView alloc]init];
    self.toolBarView = toolBarView;
    toolBarView.textView.delegate = self;
    toolBarView.delegate = self;
    self.textView = toolBarView.textView;
    [self.view addSubview:toolBarView];
}

#pragma mark - textView代理方法
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    self.toolBarView.toolBarEmotionBtn.selected = NO;
    self.emotionview.frame = emotionUpFrame;
    [UIView animateWithDuration:emotionTipTime animations:^{
     self.tableView.height = screenH - self.keyBoardH - self.toolBarView.height - 64;
        if (self.tableView.contentSize.height > self.tableView.height) {
            [self.tableView setContentOffset:CGPointMake(0, self.tableView.contentSize.height - self.tableView.bounds.size.height + 3) animated:NO];
        }
    }];
    
    
}

-(void)textViewDidChange:(UITextView *)textView
{
    if (self.toolBarView.textView.contentSize.height <= TextViewH) {
        self.toolBarView.textView.height = TextViewH;
    }else if (self.toolBarView.textView.contentSize.height >= 90)
    {
        self.toolBarView.textView.height = 90;
    }else
    {
        self.toolBarView.textView.height = self.toolBarView.textView.contentSize.height;
    }
    
    self.toolBarView.height = screenW * 10 / 320 + self.toolBarView.textView.height;
    
    
    if (self.keyBoardH < self.emotionview.height) {
        
        self.toolBarView.y = screenH - self.toolBarView.height - self.emotionview.height;
    }else
    {
        self.toolBarView.y = screenH - self.toolBarView.height - self.keyBoardH;
    }
    if (textView.text.length > 0) {
        self.emotionview.sendBtn.selected = YES;
    }else
    {
        self.emotionview.sendBtn.selected = NO;
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        NSString *messageText = [[_textView.textStorage getPlainString] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        [self sendMessageWithText:messageText];
        return NO;
    }
    return YES;
}


#pragma mark - ToolBar代理方法
-(void)ToolbarEmotionBtnDidClicked:(UIButton *)emotionBtn
{
    if (emotionBtn.selected) {
        emotionBtn.selected = NO;
        [self.textView becomeFirstResponder];
        self.tableView.height = screenH - self.keyBoardH - self.toolBarView.height - 64;
    }else
    {
        [self.textView resignFirstResponder];
        emotionBtn.selected = YES;
        [UIView animateWithDuration:emotionTipTime animations:^{
            self.emotionview.frame = emotionUpFrame;
            self.toolBarView.frame = CGRectMake(0, screenH - self.toolBarView.height - self.emotionview.height, screenW, self.toolBarView.height);
            self.tableView.height = screenH - self.emotionview.height - self.toolBarView.height - 64;
            if (self.tableView.contentSize.height > self.tableView.height) {
                [self.tableView setContentOffset:CGPointMake(0, self.tableView.contentSize.height - self.tableView.bounds.size.height + 3) animated:NO];
            }
        }];
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.tabBarController.tabBar.hidden = YES;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    self.tabBarController.tabBar.hidden = NO;
}

-(void)backBtnClicked
{
    [self.navigationController popViewControllerAnimated:YES];
}

///发送文本消息
-(void)sendMessageWithText:(NSString *)text
{
    //text为空时
    if (text.length == 0) {
        
        //了解一下编码格式
        text = @"[吐舌]  彩笔，怎么可以输入空格呢？[抓狂]";
    }
    LiuqsCellFrame *model = [self creatNormalMessageWithText:text];
    [self.dataSourceArray addObject:model];
    self.textView.text = nil;
    [self textViewDidChange:self.textView];
     NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.dataSourceArray.count - 1 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

///创建消息模型添加到数据源数组
-(LiuqsCellFrame *)creatNormalMessageWithText:(NSString *)text
{
    LiuqsCellFrame *cellFrame = [[LiuqsCellFrame alloc]init];
    LiuqsChatMessage *message = [[LiuqsChatMessage alloc]init];
    message.text = text;
    message.type = @"message";
    cellFrame.message = message;
    return cellFrame;
}
//发送动态表情消息
-(void)sendMessageWithGifName:(NSString *)name
{
    LiuqsCellFrame *model = [[LiuqsCellFrame alloc]init];
    LiuqsChatMessage *message = [[LiuqsChatMessage alloc]init];
    message.gifName = name;
    message.type = @"gif";
    model.message = message;
    [self.dataSourceArray addObject:model];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.dataSourceArray.count - 1 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}


#pragma mark - emotionView代理方法

-(void)emotionView_sBtnDidClick:(UIButton *)btn
{
    if (btn.tag == 3456) {
        //解析处理
        NSString *messageText = [[_textView.textStorage getPlainString] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        //发送按钮事件
        [self sendMessageWithText:messageText];
    }else
    {
        [self textViewDidChange:self.textView];
        //判断输入框有内容让发送按钮变颜色
        if (self.emotionview.IputView.text.length > 0) {
            self.emotionview.sendBtn.selected = YES;
        }else
        {
            self.emotionview.sendBtn.selected = NO;
        }
    }
}

-(void)gifBtnClick:(UIButton *)btn
{
    //根据按钮拿到表情的图片名字
    NSString *string = [NSString stringWithFormat:@"2_%ld",(long)btn.tag];
    _emotionview.emojiBtn.selected = NO;
    [self sendMessageWithGifName:string];
}
#pragma mark - tableview代理方法和数据源方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSourceArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LiuqsChatViewCell *cell = [LiuqsChatViewCell cellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.cellFrame = [self.dataSourceArray objectAtIndex:indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LiuqsCellFrame *cellFrame = [self.dataSourceArray objectAtIndex:indexPath.row];
    return cellFrame.cellHeight;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}


@end
