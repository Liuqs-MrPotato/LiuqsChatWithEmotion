//
//  LiuqsChatViewController.m
//  chatWithEmotion
//
//  Created by 刘全水 on 16/2/16.
//  Copyright © 2016年 刘全水. All rights reserved.


#import "LiuqsChatViewController.h"
#import "LiuqsChtaDetailViewController.h"


@interface LiuqsChatViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic, strong)UITableView *tableView;

@end

@implementation LiuqsChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = bgColor;
    [self creatTableview];

}
-(void)creatTableview
{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, screenW, screenH - 44)];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorInset = UIEdgeInsetsZero;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    cell.imageView.image = [UIImage imageNamed:@"headerImage"];
    cell.textLabel.text = @"点击开始聊天";
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    LiuqsChtaDetailViewController *chatVC = [[LiuqsChtaDetailViewController alloc]init];
    [self.navigationController pushViewController:chatVC animated:YES];
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 64;
}

@end
