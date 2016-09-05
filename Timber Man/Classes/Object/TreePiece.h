//
//  TreePiece.h
//  Timber Man
//
//  Created by Jin on 7/12/14.
//  Copyright 2014 Jin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
typedef enum
{
    LEFT_TREE_PIECE,
    RIGHT_TREE_PIECE
}TREE_PIECE_SIDE;


typedef enum
{
    TREE_PURE_PIECE=0,
    TREE_BRANCH_PIECE=1
}TREE_PIECE_KIND;

@interface TreePiece : CCSprite
{
    CCLayer                  *parentLayer;
    
}
@property(nonatomic)TREE_PIECE_SIDE     mSide;
@property(nonatomic)TREE_PIECE_KIND     mKind;
-(void)flyOver;
-(id)initWithLayer:(CCLayer *)layer withSide:(int)side  withType:(int)treeWithBranch;
@end
