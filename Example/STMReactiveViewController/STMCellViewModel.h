//
//  STMCellViewModel.h
//  STMReactiveViewController
//
//  Created by Stefano Mondino on 08/06/15.
//  Copyright (c) 2015 Stefano Mondino. All rights reserved.
//

#import "STMReactiveViewModel.h"

@interface STMCellViewModel : STMReactiveViewModel
- (instancetype) initWithDate:(NSDate*) date;
@property (nonatomic,readonly) NSString* title;
@end
