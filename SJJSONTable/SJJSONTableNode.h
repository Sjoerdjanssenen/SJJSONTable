//
//  SJJSONTableNode.h
//  SJJSONTable
//
//  Created by Sjoerd Janssen on 3/11/17.
//  Copyright © 2017 Sjoerd Janssen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Node : NSObject

@property (nonatomic) BOOL expanded;

- (instancetype)initWithItem:(id)item depth:(NSInteger)depth;
- (id)item;
- (NSInteger)depth;

@end
