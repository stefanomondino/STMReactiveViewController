//
//  STMCellViewModel.m
//  STMReactiveViewController
//
//  Created by Stefano Mondino on 08/06/15.
//  Copyright (c) 2015 Stefano Mondino. All rights reserved.
//

#import "STMCellViewModel.h"
@interface STMCellViewModel()
@property (nonatomic,strong) NSDate * date;
@property (nonatomic,strong) NSDateFormatter* formatter;
@end
@implementation STMCellViewModel
- (instancetype) initWithDate:(NSDate*) date {

    if (self = [super init]){
        self.date = date;
        self.formatter = [NSDateFormatter new];
        self.formatter.dateFormat = [NSDateFormatter dateFormatFromTemplate:@"dd/MM/yyyy HH:mm:ss" options:0 locale:[NSLocale currentLocale]];
        return self;
    }
    return nil;
}
- (NSString *)title {
    return [self.formatter stringFromDate:self.date];
}
@end
