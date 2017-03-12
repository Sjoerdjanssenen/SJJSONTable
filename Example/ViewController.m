//
//  ViewController.m
//  Example
//
//  Created by Sjoerd Janssen on 3/9/17.
//  Copyright © 2017 Sjoerd Janssen. All rights reserved.
//

#import "ViewController.h"
#import "SJJSONTableView.h"

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

- (NSInteger)tableView:(UITableView *)tableView childrenOfEntry:(id)entry {
    if (entry == nil) {
        return [self.items count];
    }
    
    return [[entry objectAtIndex:1] count];
}

- (id)tableView:(UITableView *)tableView child:(NSInteger)child ofEntry:(id)entry {
    if (entry == nil) {
        return [self.items objectAtIndex:child];
    }
    
    return [[entry objectAtIndex:1] objectAtIndex:child];
}

- (JSONCell *)tableView:(UITableView *)tableView cellForEntry:(id)entry {
    JSONCell *cell;

    if ([[entry objectAtIndex:1] isKindOfClass:[NSArray class]]) {
        cell = [[JSONCell alloc] initWithLevel:[self.tableView depthForItem:entry] valueType:ArrayValue];
        cell.title.text = [entry objectAtIndex:0];
        cell.detail.text = [NSString stringWithFormat:@"%d items", [[entry objectAtIndex:1] count]];
    } else {
        cell = [[JSONCell alloc] initWithLevel:[self.tableView depthForItem:entry] valueType:TextValue];
        cell.title.text = [entry objectAtIndex:0];
        cell.detail.text = [entry objectAtIndex:1];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    JSONCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    [cell setExpanded:!cell.expanded];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
