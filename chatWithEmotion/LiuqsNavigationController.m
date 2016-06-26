//
//  LiuqsNavigationController.m
//  chatWithEmotion
//
//  Created by 刘全水 on 16/2/16.
//  Copyright © 2016年 刘全水. All rights reserved.
//

#import "LiuqsNavigationController.h"

@interface LiuqsNavigationController ()

@end

@implementation LiuqsNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.interactivePopGestureRecognizer.delegate =(id)self;
   
}

-(void)leftAction
{
    
}

@end
