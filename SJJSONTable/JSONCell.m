//
//  JSONCell.m
//  kat
//
//  Created by Sjoerd Janssen on 12/10/16.
//  Copyright © 2016 Sjoerd Janssen. All rights reserved.
//

#import "JSONCell.h"

#define DEGREES_TO_RADIANS(x) (M_PI * x / 180.0)

@interface JSONCell ()

@property (nonatomic, strong) UIImageView *arrow;
@property (nonatomic) BOOL hasArrow;

@end

@implementation JSONCell

@synthesize expanded = _expanded;

- (id)initWithLevel:(NSInteger)level valueType:(ValueType)valueType {
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"JSONCell"];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setTintColor:[UIColor darkTextColor]];
        
        self.valueType = valueType;
        self.expanded = false;
        
        [self addArrow:(self.valueType == ArrayValue || self.valueType == DictionaryValue)];
        
        self.title = [[UILabel alloc] initWithFrame:CGRectMake(30, 0, 100, 44)];
        [self addSubview:self.title];
        
        self.detail = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width-145, 0, 100, 44)];
        [self addSubview:self.detail];
        
        [self setLevel:level frame:self.frame];
    }
    return self;
}

- (void)addArrow:(BOOL)boolean {
    [self.arrow removeFromSuperview];
    
    self.hasArrow = boolean;
    
    if (boolean == YES) {
        self.arrow = [[UIImageView alloc] initWithFrame:CGRectMake(5, 6, 32, 32)];
        self.arrow.image = [[UIImage imageNamed:@"arrow"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        self.arrow.tintColor = [UIColor lightGrayColor];
        self.arrow.contentMode = UIViewContentModeCenter;
        self.arrow.contentMode = UIViewContentModeScaleAspectFit;
        self.arrow.transform = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(180));
        [self addSubview:self.arrow];
    }
}

- (void)setExpanded:(BOOL)expanded {
    _expanded = expanded;
    
    [UIView animateWithDuration:0.2
                     animations:^{
                         if (expanded == true) {
                             self.arrow.transform = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(0));
                         } else {
                             self.arrow.transform = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(180));
                         }
                     } completion:^(BOOL finished){}];
}

- (BOOL)expanded {
    return _expanded;
}

- (void)setLevel:(NSInteger)level frame:(CGRect)frame {
    _level = (level < 5) ? level : 4;
    CGFloat sideLevel = self.level*10.0f;
    CGFloat side = 30 + sideLevel;
    self.title.frame = CGRectMake(side, 0, 100, 44);
    self.arrow.frame = CGRectMake(5 + sideLevel, 12, 20, 20);
}

@end
