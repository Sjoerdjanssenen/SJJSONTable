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

- (JSONCell *)tableView:(UITableView *)tableView cellForEntry:(id)entry;
- (NSInteger)tableView:(UITableView *)tableView childrenOfEntry:(id)entry;
- (id)tableView:(UITableView *)tableView child:(NSInteger)child ofEntry:(id)entry;
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface SJJSONTableView : UITableView <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, assign) id presenter;

- (id)initWithFrame:(CGRect)frame;
- (NSInteger)depthForItem:(id)item;

@end
