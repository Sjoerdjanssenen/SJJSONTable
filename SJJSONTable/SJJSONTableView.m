//
//  SJJSONTableView.m
//  SJJSONTable
//
//  Created by Sjoerd Janssen on 3/9/17.
//  Copyright © 2017 Sjoerd Janssen. All rights reserved.
//

#import "SJJSONTableView.h"
#import "Node.h"

@interface SJJSONTableView ()

@property (nonatomic, strong) NSMutableArray *items;

@end

@implementation SJJSONTableView

@synthesize presenter = _presenter;

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height-144, self.frame.size.width, 40)];
        
        self.items = [@[] mutableCopy];
        
        self.delegate = self;
        self.dataSource = self;
        self.tableFooterView = footerView;
    }
    return self;
}

- (void)setPresenter:(id)presenter {
    _presenter = presenter;
    
    NSInteger amount = [self.presenter tableView:self childrenOfEntry:nil];
    
    for (int i = 0; i < amount; i++) {
        Node *node = [[Node alloc] initWithItem:[self.presenter tableView:self child:i ofEntry:nil] depth:0];
        [self.items addObject:node];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.items count];
}

- (JSONCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Node *node = [self.items objectAtIndex:indexPath.row];
    
    return (JSONCell *)[self.presenter tableView:tableView cellForEntry:node.item];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    Node *node = [self.items objectAtIndex:indexPath.row];
    NSInteger children = [self.presenter tableView:self childrenOfEntry:node.item];
    
    if (children > 0) {
        if (node.expanded) {
            [self deleteRowsForNode:node indexPath:indexPath];
        } else {
            [self insertRowsForNode:node indexPath:indexPath];
        }
        
        [node setExpanded:!node.expanded];
    }
    
    [self.presenter tableView:self didSelectRowAtIndexPath:indexPath];
}

- (NSInteger)depthForItem:(id)item {
    NSUInteger index = [self.items indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
        if (((Node *)obj).item == item) {
            *stop = YES;
            return YES;
        }
        return NO;
    }];
    
    return ((Node *)[self.items objectAtIndex:index]).depth;
}

- (void)insertRowsForNode:(Node *)node indexPath:(NSIndexPath *)indexPath {
    NSInteger rows = [self.presenter tableView:self childrenOfEntry:node.item];
    
    for (int i = 0; i < rows; i++) {
        Node *entry = [[Node alloc] initWithItem:[self.presenter tableView:self child:i ofEntry:node.item]
                                          depth:node.depth+1];
        [self.items insertObject:entry atIndex:indexPath.row+i+1];
    }
    
    NSMutableArray *indexPaths = [@[] mutableCopy];
    
    for (int i = (indexPath.row+1); i < (rows+(indexPath.row+1)); i++) {
        [indexPaths addObject:[NSIndexPath indexPathForRow:i inSection:0]];
    }
    
    [self insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationMiddle];
}

- (void)deleteRowsForNode:(Node *)node indexPath:(NSIndexPath *)indexPath {
    NSInteger rows = [self.presenter tableView:self childrenOfEntry:node.item];
    
    NSMutableArray *indexPaths = [@[] mutableCopy];
    BOOL result = false; int i = (indexPath.row+1);
    
    while (result == false) {
        Node *temp = [self.items objectAtIndex:indexPath.row+1];
        
        if (temp.depth > node.depth) {
            [self.items removeObjectAtIndex:indexPath.row+1];
            [indexPaths addObject:[NSIndexPath indexPathForRow:i inSection:0]];
        } else {
            result = true;
        }
        
        i++;
    }
    
    [self deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationMiddle];
}

@end
