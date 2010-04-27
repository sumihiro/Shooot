//
//  LinkedList.m
//  Shooot
//
//  Created by 上田 澄博 on 10/04/27.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "LinkedList.h"


@implementation LinkedList

- (id) init
{
	self = [super init];
	if (self != nil) {
		cursor = 0;
		objects = [[NSMutableArray alloc] init];
	}
	return self;
}

- (void) dealloc
{
	[objects release];
	
	[super dealloc];
}

#pragma mark -
-(void)add:(id)obj {
	[objects addObject:obj];
}

-(void)reset {
	cursor = 0;
}

-(BOOL)hasNext {
	return [objects count] > cursor;
}

-(id)next {
	id obj = [objects objectAtIndex:cursor];
	++ cursor;
	return obj;
}

-(void)remove {
	-- cursor;
	[objects removeObjectAtIndex:cursor];
}

-(void)removeAll {
	cursor = 0;
	[objects removeAllObjects];
}

@end
