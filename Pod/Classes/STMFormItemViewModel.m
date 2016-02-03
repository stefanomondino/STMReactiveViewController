//
//  STMFormItemViewModel.m
//  Pods
//
//  Created by Stefano Mondino on 16/10/15.
//
//

#import "STMFormItemViewModel.h"

@implementation STMFormItemViewModel

@synthesize cellIdentifier,title,value,isValid,keypath;
@synthesize validationBlock = _validationBlock;

- (void)setValidationBlock:(BOOL (^)(id))validationBlock {
    _validationBlock = validationBlock;
    self.value = self.value;//Triggers validation after validationBlock set
}
@end
