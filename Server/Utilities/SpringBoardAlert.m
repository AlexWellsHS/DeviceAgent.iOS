
#import "SpringBoardAlert.h"

@interface SpringBoardAlert ()

- (instancetype)initWithAlertTitleFragment:(NSString *)alertTitleFragment
                        dismissButtonTitle:(NSString *)acceptButtonTitle
                              shouldAccept:(BOOL)shouldAccept;

- (BOOL)matchesAlertTitle:(NSString *)alertTitle;

@property(copy, readonly) NSString *alertTitleFragment;

@end

@implementation SpringBoardAlert

- (instancetype)initWithAlertTitleFragment:(NSString *)alertTitleFragment
                        dismissButtonTitle:(NSString *)dismissButtonTitle
                              shouldAccept:(BOOL)shouldAccept {

    self = [super init];
    if (self) {
        _alertTitleFragment = alertTitleFragment;
        _defaultDismissButtonMark = dismissButtonTitle;
        _shouldAccept = shouldAccept;
    }
    return self;
}

- (BOOL)matchesAlertTitle:(NSString *)alertTitle {
    return [[alertTitle lowercaseString]
            containsString:[self.alertTitleFragment
                            lowercaseString]];
}

@end
