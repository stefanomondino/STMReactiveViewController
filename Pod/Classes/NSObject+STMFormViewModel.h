//
//  NSObject+STMFormViewModel.h
//  Pods
//
//  Created by Stefano Mondino on 16/10/15.
//
//

#import <Foundation/Foundation.h>
#import "STMFormItemViewModel.h"
@interface NSObject (STMFormViewModel)
- (STMFormItemViewModel*) formItemWithKeypath:(NSString* ) keypath title:(NSString*)title cellIdentifier:(NSString*) cellIdentifier;
- (STMFormItemViewModel*) formItemWithKeypath:(NSString* ) keypath title:(NSString*)title cellIdentifier:(NSString*) cellIdentifier itemClass:(Class) itemClass;
- (id<STMFormItemViewModel>) formItemWithKeypath:(NSString* ) keypath title:(NSString*)title cellIdentifier:(NSString*) cellIdentifier itemClass:(Class) itemClass validationBlock:(BOOL (^)(id value))validationBlock;
@end
