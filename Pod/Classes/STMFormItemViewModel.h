//
//  STMFormItemViewModel.h
//  Pods
//
//  Created by Stefano Mondino on 16/10/15.
//
//

#import <Foundation/Foundation.h>

@protocol STMFormItemViewModel <NSObject>
@property (nonatomic,strong) NSString* cellIdentifier;
@property (nonatomic,strong) NSString* title;
@property (nonatomic,strong) id value;
@property (nonatomic, copy) BOOL (^validationBlock)(id value);
@property (nonatomic,assign) BOOL isValid;
@end

@interface STMFormItemViewModel : NSObject <STMFormItemViewModel>
- (void)setValidationBlock:(BOOL (^)(id))validationBlock ;
@end
