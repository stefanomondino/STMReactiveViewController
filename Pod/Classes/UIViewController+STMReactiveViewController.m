//
//  UIViewController+STMReactiveViewController.m
//  Pods
//
//  Created by Stefano Mondino on 05/03/15.
//
//

#import "UIViewController+STMReactiveViewController.h"
#import <EXTScope.h>
@implementation UIViewController (STMReactiveViewController)

- (void) performSegueWithIdentifier:(NSString *)identifier parameters:(NSDictionary*) dictionary {
    [[[[[[self rac_signalForSelector:@selector(prepareForSegue:sender:)]
       take:1]
      map:^id(RACTuple* value) {
          UIStoryboardSegue* segue = value.first;
          return segue.destinationViewController;
      }] flattenMap:^RACStream *(UIViewController* vc) {
          if ([vc isKindOfClass:[UINavigationController class]]) {
              return [[[vc rac_signalForSelector:@selector(viewDidLoad)]
                       take:1]
                      map:^id(id value) {
                          UINavigationController* nav = (UINavigationController*)vc;
                          return nav.viewControllers.firstObject;
                      }];
          }
          else {
              return [RACSignal return:vc];
          }
      }]
      take:1]
     subscribeNext:^(UIViewController* destinationViewController) {
          [dictionary enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
              if ([destinationViewController respondsToSelector:NSSelectorFromString(key)]){
                  [destinationViewController setValue:[obj isKindOfClass:[NSNull class]]? nil:obj forKeyPath:key];
              }
          }];
      }];
    [self performSegueWithIdentifier:identifier sender:self];
}

- (void) performSegueWithIdentifier:(NSString *)identifier viewModel:(id) viewModel {
    [self performSegueWithIdentifier:identifier parameters:@{@"viewModel":viewModel}];
}

- (RACSignal*) rac_viewWillAppear {
    return [self rac_signalForSelector:@selector(viewWillAppear:)];
}

- (RACSignal*) rac_viewDidAppear {
    return [self rac_signalForSelector:@selector(viewDidAppear:)];
}

- (RACSignal*) rac_firstViewWillAppear {
    return [[self rac_viewWillAppear] take:1];
}

- (RACSignal*) rac_firstViewDidAppear {
    return [[self rac_signalForSelector:@selector(viewDidAppear:)] take:1];
}

- (RACSignal*) rac_showAlertControllerWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray*) otherButtonTitles style:(UIAlertControllerStyle) style {
    @weakify(self);
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self);
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:style];
        
        [alert addAction:[UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            [subscriber sendNext:@(0)];
        }]];
        for (NSInteger i = 1; i<= otherButtonTitles.count;i++) {
            __block NSInteger j = i;
            [alert addAction:[UIAlertAction actionWithTitle:otherButtonTitles[i-1] style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [subscriber sendNext:@(j)];
            }]];
        }
        
        [self presentViewController:alert animated:YES completion:nil];
        return  [RACDisposable disposableWithBlock:^{
            ;
        }];
    }];
}

- (RACSignal*) rac_showAlertWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray*) otherButtonTitles{
     @weakify(self);
    BOOL isAlertControllerCompatible =  [UIAlertController class] != nil;
    return [[RACSignal defer:^RACSignal *{
         @strongify(self);
        if (isAlertControllerCompatible) {
             return [self rac_showAlertControllerWithTitle:title message:message cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles style:UIAlertControllerStyleAlert];
        }
        else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:cancelButtonTitle otherButtonTitles: nil];
            for (NSString* title in otherButtonTitles) {
                [alert addButtonWithTitle:title];
            }
            alert.cancelButtonIndex = 0;
            [alert show];
            return [alert rac_buttonClickedSignal];
        }
        return [RACSignal empty];
    }] take:1];
    
}

- (RACSignal*) rac_showActionSheetWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray*) otherButtonTitles{
    @weakify(self);
    BOOL isAlertControllerCompatible =  [UIAlertController class] != nil;
    return [[RACSignal defer:^RACSignal *{
        @strongify(self);
        if (isAlertControllerCompatible) {
            return [self rac_showAlertControllerWithTitle:title message:message cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles style:UIAlertControllerStyleActionSheet];
        }
        else {
            
            UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:title delegate:nil cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles: nil];
            for (NSString* title in otherButtonTitles) {
                [actionSheet addButtonWithTitle:title];
            }
            [actionSheet addButtonWithTitle:cancelButtonTitle];
            actionSheet.cancelButtonIndex = otherButtonTitles.count;
            [actionSheet showInView:self.view];
            return [[actionSheet rac_buttonClickedSignal] map:^id(NSNumber* value) {
                return @(([value integerValue]+1)%(otherButtonTitles.count+1));
            }];
           
        }
        return [RACSignal empty];
    }] take:1];
    
}

@end
