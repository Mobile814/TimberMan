//
//  Tree.h
//  Timber Man
//
//  Created by Jin on 7/12/14.
//  Copyright 2014 Jin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
typedef enum
{
    LEFT_TREE,
    RIGHT_TREE
}TREE_SIDE;
typedef enum
{
    TREE_PURE=0,
    TREE_BRANCH=1
}TREE_KIND;
@interface Tree : CCSprite
{
    CCLayer           *parentLayer;
}
@property(nonatomic)TREE_SIDE        mSide;
@property(nonatomic)int              mIdx;
@property(nonatomic)TREE_KIND        mKind;
-(void)changeMe:(float)yPos;
-(void)moveDown;
-(void)moveFail;
-(id)initWithLayer:(CCLayer *)layer withIdx:(int)idx;
@end
