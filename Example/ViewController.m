//
//  ViewController.m
//  Example
//
//  Created by Sjoerd Janssen on 3/9/17.
//  Copyright © 2017 Sjoerd Janssen. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) SJJSONTableView *tableView;
@property (nonatomic, strong) NSArray *items;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"Example";
    
    self.items  =   @[
                        @[@"Item 0",    @[
                                            @[@"Firstname", @"Sjoerd"],
                                            @[@"Lastname", @"Janssen"],
                                            @[@"Age", @"26"],
                                            @[
                                                @"Tags", @[
                                                @[@"Tag", @"PHP"],
                                                @[@"Tag", @"Objective-C"],
                                                ]
                                            ]
                                        ]
                        ],
                        @[@"Item 1",    @[
                                            @[@"Firstname", @"Jeroen"],
                                            @[@"Lastname", @"Boumans"],
                                            @[@"Age", @"28"]
                                        ]
                        ],
                        @[@"Item 2",    @[]],
                        @[@"Item 3",    @[]]
                    ];
    
    self.tableView = [[SJJSONTableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.tableView.presenter = self;
    [self.view addSubview:self.tableView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForNode:(id)node {
    return 44.0f;
}

- (NSInteger)tableView:(UITableView *)tableView childrenOfNode:(id)node {
    if (node == nil) {
        return [self.items count];
    }
    
    return [[node objectAtIndex:1] count];
}

- (id)tableView:(UITableView *)tableView child:(NSInteger)child ofNode:(id)node {
    if (node == nil) {
        return [self.items objectAtIndex:child];
    }
    
    return [[node objectAtIndex:1] objectAtIndex:child];
}

- (JSONCell *)tableView:(UITableView *)tableView cellForNode:(id)node {
    JSONCell *cell;

    if ([[node objectAtIndex:1] isKindOfClass:[NSArray class]]) {
        cell = [[JSONCell alloc] initWithLevel:[self.tableView depthForItem:node] valueType:ArrayValue];
        cell.title.text = [node objectAtIndex:0];
        cell.detail.text = [NSString stringWithFormat:@"%d items", [[node objectAtIndex:1] count]];
    } else {
        cell = [[JSONCell alloc] initWithLevel:[self.tableView depthForItem:node] valueType:TextValue];
        cell.title.text = [node objectAtIndex:0];
        cell.detail.text = [node objectAtIndex:1];
    }
    
    return cell;
}

- (void)willExpandNodeAtIndexPath:(NSIndexPath *)indexPath {
    JSONCell *cell = [self cellForRowAtIndexPath:indexPath];
    [cell setExpanded:YES];
}

- (void)willCollapseNodeAtIndexPath:(NSIndexPath *)indexPath {
    JSONCell *cell = [self cellForRowAtIndexPath:indexPath];
    [cell setExpanded:NO];
}

- (void)tableView:(UITableView *)tableView didSelectNode:(id)node {
    NSLog(@"Selected a node!");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
