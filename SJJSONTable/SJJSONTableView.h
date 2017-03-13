//
//  SJJSONTableView.h
//  SJJSONTable
//
//  Created by Sjoerd Janssen on 3/9/17.
//  Copyright © 2017 Sjoerd Janssen. All rights reserved.
//

#import <UIKit/UIKit.h>

// Views
#import "JSONCell.h"

@protocol SJJSONTableViewDelegate <NSObject>

- (UITableViewCell *)tableView:(UITableView *)tableView cellForNode:(id)node;
- (NSInteger)tableView:(UITableView *)tableView childrenOfNode:(id)node;
- (id)tableView:(UITableView *)tableView child:(NSInteger)child ofNode:(id)node;
- (void)tableView:(UITableView *)tableView didSelectNode:(id)node;
- (void)willExpandNodeAtIndexPath:(NSIndexPath *)indexPath;
- (void)willCollapseNodeAtIndexPath:(NSIndexPath *)indexPath;
- (CGFloat)tableView:(UITableView *)tableView heightForNode:(id)node;

@end

@interface SJJSONTableView : UITableView <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, assign) id presenter;

- (id)initWithFrame:(CGRect)frame;
- (NSInteger)depthForItem:(id)item;

@end
