//
//  mainSKScene.m
//  balanceBurgerGame
//
//  Created by Yoshinori Murata on 2014/07/04.
//  Copyright (c) 2014年 Yoshinori Murata. All rights reserved.
//

#import "mainSKScene.h"
//タイトルシーンのtitleSKScene.hをimport
#import "titleSKScene.h"

@interface mainSKScene(){
    //後で使えるように終了ラベルを宣言する
    SKLabelNode *exitSKLabel;
    //落とす具材の番号
    int bgID;
    //バンズ
    SKSpriteNode *buns;
}
@end

@implementation mainSKScene

-(instancetype)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        //背景に色をつける
        self.backgroundColor = [UIColor colorWithRed:0.3 green:0.1 blue:0 alpha:1 ];
        //EXITラベルを作って表示する
        exitSKLabel = [SKLabelNode labelNodeWithFontNamed:@"Futura-Medium"];
        exitSKLabel.text = @"EXIT";
        exitSKLabel.position = CGPointMake(50, size.height - 50);
        [self addChild:exitSKLabel];
        
        //物理シュミレーションの空間を用意する
        self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:CGRectMake(0, 0, size.width, size.height)];
        //支え１を作って画面に登場させる
        SKSpriteNode *stick1 = [SKSpriteNode spriteNodeWithImageNamed:@"stick"];
        stick1.position = CGPointMake(160, 80);
        stick1.size = CGSizeMake(15, 60);
        SKPhysicsBody *pbody1 = [SKPhysicsBody bodyWithRectangleOfSize:stick1.size];
        stick1.physicsBody = pbody1;
        [self addChild:stick1];
        
        //支え2を作って画面に登場させる
        SKSpriteNode *stick2 = [SKSpriteNode spriteNodeWithImageNamed:@"stick"];
        stick2.position = CGPointMake(160, 160);
        stick2.size = CGSizeMake(15, 60);
        SKPhysicsBody *pbody2 = [SKPhysicsBody bodyWithRectangleOfSize:stick2.size];
        stick2.physicsBody = pbody2;
        [self addChild:stick2];
        
        //バンズを作って登場させる
        buns = [SKSpriteNode spriteNodeWithImageNamed:@"bg8"];
        buns.position = CGPointMake(160, 220);
        buns.size = CGSizeMake(160, 25);
        SKPhysicsBody *pbody3 = [SKPhysicsBody bodyWithRectangleOfSize:buns.size];
        buns.physicsBody = pbody3;
        [self addChild:buns];
        //具材番号のリセット
        bgID = 0;
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    //積み上げる具材のファイル名の配列を用意する
    NSArray *bgname = @[@"bg7",@"bg6",@"bg5",@"bg4",@"bg3",@"bg2",@"bg1"];
    //タッチした座標を調べる
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    //EXITラベルにタッチしていたらタイトルシーンにドアを閉じるように切り替える
    if([exitSKLabel containsPoint:location]) {
        titleSKScene *scene = [[titleSKScene alloc] initWithSize:self.size];
        SKTransition *transition = [SKTransition doorsCloseHorizontalWithDuration:1];
        [self.view presentScene:scene transition:transition];
    }else{
        //EXITラベル以外をタッチしたとき、具材IDが具材数より少なければ、
        if (bgID < bgname.count) {
            //具材を作って、画面に登場させる
            SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:bgname[bgID]];
            sprite.position = location;
            sprite.size = CGSizeMake(160, 25);
            SKPhysicsBody *pbody = [SKPhysicsBody bodyWithRectangleOfSize:sprite.size];
            sprite.physicsBody = pbody;
            [self addChild:sprite];
        }
        //具材IDのカウントアップ
        bgID = bgID + 1;
    }
}

//毎回の画面更新時にチェック
-(void)update:(NSTimeInterval)currentTime{
    //ゲーム中のとき
    if (bgID < 99) {
        //バンズが下にオチてしまったら
        if (buns.position.y < 100) {
            //具材IDを99にして落とせなくする＆ゲームオーバーとする
            bgID = 99;
            //GAMEOVERラベルを表示する
            SKLabelNode *endSKLabel = [SKLabelNode labelNodeWithFontNamed:@"Futura-Medium"];
            endSKLabel.text = @"GAMEOVER";
            endSKLabel.position = CGPointMake(160, 300);
            [self addChild:endSKLabel];
        }
    }
}
@end
