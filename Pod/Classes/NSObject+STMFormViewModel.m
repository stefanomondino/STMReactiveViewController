//
//  NSObject+STMFormViewModel.m
//  Pods
//
//  Created by Stefano Mondino on 16/10/15.
//
//

#import "NSObject+STMFormViewModel.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
@implementation NSObject (STMFormViewModel)
#pragma mark Forms
- (id<STMFormItemViewModel>) formItemWithKeypath:(NSString* ) keypath title:(NSString*)title cellIdentifier:(NSString*) cellIdentifier {
    return [self formItemWithKeypath:keypath title:title cellIdentifier:cellIdentifier itemClass:[STMFormItemViewModel class]];
}
- (id<STMFormItemViewModel>) formItemWithKeypath:(NSString* ) keypath title:(NSString*)title cellIdentifier:(NSString*) cellIdentifier itemClass:(Class) itemClass {
    return [self formItemWithKeypath:keypath title:title cellIdentifier:cellIdentifier itemClass:itemClass validationBlock:^BOOL(id value) {return YES;}];
}
- (id<STMFormItemViewModel>) formItemWithKeypath:(NSString* ) keypath title:(NSString*)title cellIdentifier:(NSString*) cellIdentifier itemClass:(Class) itemClass validationBlock:(BOOL (^)(id value))validationBlock{
    
    NSAssert([itemClass conformsToProtocol:@protocol(STMFormItemViewModel)],@"Provided class MUST conform to STMFormItemViewModel protocol");
    
    id<STMFormItemViewModel> vm = [itemClass new];
    vm.title = title;
    vm.keypath = keypath;
    vm.cellIdentifier = cellIdentifier;
    vm.validationBlock = validationBlock;
    RAC(vm,value) = [[self rac_valuesForKeyPath:keypath observer:self] distinctUntilChanged];
    [self rac_liftSelector:@selector(setValue:forKeyPath:) withSignals:[RACObserve(vm, value) distinctUntilChanged],[RACSignal return:keypath], nil];
    RAC(vm, isValid) = [RACObserve(vm, value) map:^id(id value) {
        return @(vm.validationBlock(value));
    }];
    
    return vm;
}
@end
