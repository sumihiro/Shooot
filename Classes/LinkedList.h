//
//  LinkedList.h
//  Shooot
//
//  Created by 上田 澄博 on 10/04/27.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface LinkedList : NSObject {
	NSMutableArray *objects;
	NSInteger cursor;
}

-(void)reset;
-(void)add:(id)obj;
-(BOOL)hasNext;
-(id)next;
-(void)remove;
-(void)removeAll;

@end
