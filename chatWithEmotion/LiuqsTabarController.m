//
//  LiuqsTabarController.m
//  chatWithEmotion
//
//  Created by 刘全水 on 16/2/16.
//  Copyright © 2016年 刘全水. All rights reserved.
//

#import "LiuqsTabarController.h"
#import "LiuqsNavigationController.h"
#import "LiuqsChatViewController.h"
#import "LiuqsMeViewController.h"

@interface LiuqsTabarController ()

@end

@implementation LiuqsTabarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:pinkColor,NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    [self creatTabBarItem];

}

-(void)creatTabBarItem
{
    LiuqsChatViewController *chatVC = [[LiuqsChatViewController alloc]init];
    [self addChildVC:chatVC title:@"聊天" imageName:@"消息" selImageNameL:@"消息-选中"];
    
    LiuqsMeViewController *meVC = [[LiuqsMeViewController alloc]init];
    [self addChildVC:meVC title:@"我" imageName:@"我" selImageNameL:@"我---选中"];
    
}



-(void)addChildVC:(UIViewController *)VC title:(NSString *)title imageName:(NSString *)iamgeName selImageNameL:(NSString *)selImageName
{
    
    VC.tabBarItem.title = title;
    UIImage *selImage = [[UIImage imageNamed:selImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    [VC.tabBarItem setImage:[UIImage imageNamed:iamgeName]];
    
    [VC.tabBarItem setSelectedImage:selImage];
    LiuqsNavigationController *nav = [[LiuqsNavigationController alloc]initWithRootViewController:VC];
    
    //添加到tablebarcontroller
    [self addChildViewController:nav];
    
    
    
}


@end
