//
//  JSONCell.h
//  kat
//
//  Created by Sjoerd Janssen on 12/10/16.
//  Copyright © 2016 Sjoerd Janssen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ValueType) {
    TextValue           =   0,
    FileValue           =   1,
    NumberValue         =   2,
    BOOLValue           =   3,
    ArrayValue          =   4,
    DictionaryValue     =   5
};

@interface JSONCell : UITableViewCell <UITextFieldDelegate>

@property (nonatomic) BOOL expanded;

@property (nonatomic, strong) UILabel *title, *detail;
@property (nonatomic) NSInteger level;
@property (nonatomic, strong) UIImageView *type;

@property (nonatomic) ValueType valueType;

- (id)initWithLevel:(NSInteger)level valueType:(ValueType)valueType;

- (void)addArrow:(BOOL)boolean;
- (void)setLevel:(NSInteger)level frame:(CGRect)frame;

@end
