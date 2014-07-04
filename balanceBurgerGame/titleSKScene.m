//
//  titleSKScene.m
//  balanceBurgerGame
//
//  Created by Yoshinori Murata on 2014/07/04.
//  Copyright (c) 2014年 Yoshinori Murata. All rights reserved.
//

#import "titleSKScene.h"
//メインシーンのmainSKScene.hをimportする
#import "mainSKScene.h"

@interface titleSKScene(){
    //スタート用のラベルを用意する
    SKLabelNode *startSKLabel;
}
@end

@implementation titleSKScene

-(instancetype)initWithSize:(CGSize)size{
    if (self = [super initWithSize:size]) {
        //背景に色を設定する
        self.backgroundColor = [UIColor colorWithRed:0.4 green:0.6 blue:0.2 alpha:1];
        //タイトルを作って追加する（画面中央より50上の位置）
        SKLabelNode *mySKLabel = [SKLabelNode labelNodeWithFontNamed:@"Futura-Medium"];
        mySKLabel.text = @"BALANCE BURGER";
        mySKLabel.position = CGPointMake(size.width/2, size.height + 50);
        [self addChild:mySKLabel];
        //スタートラベルを作って追加する（画面中央より100下の位置）
        startSKLabel = [SKLabelNode labelNodeWithFontNamed:@"Futura-medium"];
        startSKLabel.text = @"START";
        startSKLabel.position = CGPointMake(size.width/2, size.height/2 - 100);
        [self addChild:startSKLabel];
    }
    return self;
}

//スタートラベルがタッチされたとき、メインシーンに切り替える
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    //タッチした座標を取得して、
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    //スタートラベルをタッチしていたら、
    if ([startSKLabel containsPoint:location]){
        //メインシーンを作り、
        mainSKScene *scene = [[mainSKScene alloc] initWithSize:self.size];
        //ドアが開くように切り替える
        SKTransition *transition = [SKTransition doorsOpenHorizontalWithDuration:1];
        [self.view presentScene:scene transition:transition];
    }
}

@end
