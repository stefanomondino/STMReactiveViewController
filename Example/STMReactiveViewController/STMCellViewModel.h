//
//  STMCellViewModel.h
//  STMReactiveViewController
//
//  Created by Stefano Mondino on 08/06/15.
//  Copyright (c) 2015 Stefano Mondino. All rights reserved.
//

#import "STMReactiveViewModel.h"

@interface STMCellViewModel : STMReactiveViewModel
- (instancetype) initWithTitle:(NSString*) string;
@property (nonatomic,strong) NSString* title;
@end
