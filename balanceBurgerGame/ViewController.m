//
//  ViewController.m
//  balanceBurgerGame
//
//  Created by Yoshinori Murata on 2014/07/04.
//  Copyright (c) 2014年 Yoshinori Murata. All rights reserved.
//

#import "ViewController.h"
//タイトルシーンのtitleSKScene.hをimportする
#import "titleSKScene.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    //SKViewを用意する
    SKView *skView = (SKView *)self.view;
    //SKSceneを作る
    SKScene *scene = [titleSKScene sceneWithSize:skView.bounds.size];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    //SKViewに作ったシーンを表示する
    [skView presentScene:scene];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//-- ステータスバーを非表示
-(BOOL)prefersStatusBarHidden{
    return YES;
}

@end
