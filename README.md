![SJJSONTable](http://sjrd.co/wp-content/uploads/2017/03/json-e1489330582876.png)

# SJJSONTable
> A UITableView implementation specifically meant for displaying JSON or trees.

[![Build Status](https://travis-ci.org/Sjoerdjanssenen/SJJSONTable.svg?branch=master)](https://travis-ci.org/Sjoerdjanssenen/SJJSONTable)
[![Packagist](https://img.shields.io/packagist/l/doctrine/orm.svg)]()
[![CocoaPods Compatible](https://img.shields.io/cocoapods/v/EZSwiftExtensions.svg)](https://img.shields.io/cocoapods/v/LFAlertController.svg)  
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square)](http://makeapullrequest.com)

SJJSONTable is a subclass of UITableViewCell that provides you with APIs to display JSON in a table.

![An example app](http://i.imgur.com/o4NRI1m.gif)

## Features

- [x] Feature 1
- [x] Feature 2
- [x] Feature 3
- [x] Feature 4
- [x] Feature 5

## Requirements

- iOS 8.0+
- Xcode 7.3

## Installation

#### CocoaPods
You can use [CocoaPods](http://cocoapods.org/) to install `SJJSONTable` by adding it to your `Podfile`:

```ruby
platform :ios, '8.0'
use_frameworks!
pod 'SJJSONTable'
```

To get the full benefits import `YourLibrary` wherever you import UIKit

``` swift
import UIKit
import SJJSONTable
```

## Getting started

You can start by creating a `SJJSONTable` - just as you do with a `UITableView`.

```objective-c
SJJSONTable *table = [[SJJSONTable alloc] init];
table.presenter = self;
[self.view addSubview:table];
```

After that, you can add the APIs required to make the table work. First, set the amount of children for a given node. If node is nil, it's the root.

```objective-c
- (NSInteger)tableView:(UITableView *)tableView childrenOfEntry:(id)node {
    return (node == nil) ? 5 : 3;
}
```

After adding that method, you can start returning children for a given node.

```objective-c
- (id)tableView:(UITableView *)tableView child:(NSInteger)child ofEntry:(id)node {
    if (node == nil) {
        return [self.data objectAtIndex:child];
    }
    
    return [node.children objectAtIndex:child];
}
```

Then create the cell for a node.

```objective-c
- (UITableViewCell *)tableView:(UITableView *)tableView cellForEntry:(id)node  {
    ....
    return cell;
}
```

And handle the selection, collapsing and/or expanding of nodes.

```objective-c
- (void)tableView:(UITableView *)tableView didSelectNode:(id)node {
    NSLog(@"Selected node: %@", node);
}

- (void)willExpandNodeAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"Will expand node at indexPath: %@", indexPath);
}

- (void)willCollapseNodeAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"Will collapse node at indexPath: %@", indexPath);
}
```

You're done!

## Contribute

We would love for you to contribute to **SJJSONTable**, check the ``LICENSE`` file for more info.

## Meta

Sjoerd Janssen – [@sjoerdjanssenen](https://twitter.com/sjoerdjanssenen) – sjoerdjanssen@me.com

Distributed under the MIT license. See ``LICENSE`` for more information.

Arrow icon in the example project made by [Dave Gandy](http://www.flaticon.com/authors/dave-gandy) from www.flaticon.com 

[https://github.com/sjoerdjanssenen](https://github.com/sjoerdjanssenen/)

[swift-image]:https://img.shields.io/badge/swift-3.0-orange.svg
[swift-url]: https://swift.org/
[license-image]: https://img.shields.io/badge/License-MIT-blue.svg
[license-url]: LICENSE
[travis-image]: https://img.shields.io/travis/dbader/node-datadog-metrics/master.svg?style=flat-square
[travis-url]: https://travis-ci.org/dbader/node-datadog-metrics
[codebeat-image]: https://codebeat.co/badges/c19b47ea-2f9d-45df-8458-b2d952fe9dad
[codebeat-url]: https://codebeat.co/projects/github-com-vsouza-awesomeios-com
