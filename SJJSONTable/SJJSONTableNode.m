//
//  SJJSONTableNode.m
//  SJJSONTable
//
//  Created by Sjoerd Janssen on 3/11/17.
//  Copyright © 2017 Sjoerd Janssen. All rights reserved.
//

#import "SJJSONTableNode.h"

@interface Node()

@property (nonatomic) id item;
@property (nonatomic) NSInteger depth;

@end

@implementation Node

@synthesize item = _item;
@synthesize depth = _depth;

- (instancetype)initWithItem:(id)item depth:(NSInteger)depth {
    self = [super init];
    if (self) {
        self.item = item;
        self.depth = depth;
        self.expanded = false;
    }
    return self;
}

- (id)item {
    return _item;
}

- (NSInteger)depth {
    return _depth;
}

@end
