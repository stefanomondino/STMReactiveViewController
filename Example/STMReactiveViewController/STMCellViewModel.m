//
//  STMCellViewModel.m
//  STMReactiveViewController
//
//  Created by Stefano Mondino on 08/06/15.
//  Copyright (c) 2015 Stefano Mondino. All rights reserved.
//

#import "STMCellViewModel.h"
@interface STMCellViewModel()
@end
@implementation STMCellViewModel
- (instancetype) initWithTitle:(NSString*) title {

    if (self = [super init]){
        self.title = title;
        return self;
    }
    return nil;
}
@end
