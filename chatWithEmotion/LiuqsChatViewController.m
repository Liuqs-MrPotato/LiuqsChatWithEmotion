//
//  LiuqsChatViewController.m
//  chatWithEmotion
//
//  Created by 刘全水 on 16/2/16.
//  Copyright © 2016年 刘全水. All rights reserved.


#import "LiuqsChatViewController.h"
#import "LiuqsChtaDetailViewController.h"

#define _emojiTags  @[@"[微笑]", @"[玫瑰]",@"[强]", @"[握手]",@"[拥抱]",@"[咖啡]",@"[抱拳]",@"[OK]",@"[鼓掌]",@"[疑问]",@"[嘘]",@"[憨笑]",@"[偷笑]",@"[调皮]", @"[呲牙]",@"[流泪]",@"[奋斗]",@"[饭]",@"[爱心]",@"[拳头]",@"[难过]",@"[愉快]",@"[亲亲]",@"[色]",@"[得意]",@"[害羞]",@"[再见]",@"[坏笑]",@"[太阳]",@"[月亮]",@"[礼物]",@"[蛋糕]",@"[西瓜]",@"[啤酒]",@"[乒乓]",@"[篮球]",@"[足球]",@"[嘴唇]",@"[心碎]",@"[胜利]",@"[NO]",@"[撇嘴]", @"[发呆]",@"[左哼哼]",@"[右哼哼]",@"[哈欠]",@"[鄙视]",@"[委屈]",@"[快哭了]",@"[阴险]",@"[闭嘴]",@"[吓]",@"[可怜]",@"[睡]",@"[大哭]",@"[尴尬]",@"[惊讶]",@"[冷汗]",@"[抓狂]",@"[吐]",@"[白眼]",@"[傲慢]",@"[饥饿]",@"[困]",@"[惊恐]",@"[流汗]",@"[悠闲]",@"[咒骂]", @"[晕]",@"[疯了]",@"[衰]",@"[敲打]",@"[擦汗]",@"[抠鼻]",@"[糗大了]",@"[酷]",@"[猪头]"]


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
    
    //用来写plist
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
//    
//    NSString *path = [paths objectAtIndex:0];
//    
//    NSString *filename = [path stringByAppendingPathComponent:@"LiuqsEmotionTags.plist"];//获取路径
//    
//    [_emojiTags writeToFile:filename atomically:YES];
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 64;
}

@end
