#import "AppDelegate.h"
#import "MBFingerTipWindow.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (UIWindow *)window {
    if (!_window) {
        MBFingerTipWindow *ftWindow = [[MBFingerTipWindow alloc]
                                       initWithFrame:[[UIScreen mainScreen] bounds]];
        NSArray *arguments = [[NSProcessInfo processInfo] arguments];
        ftWindow.alwaysShowTouches = [arguments containsObject:@"FINGERTIPS"];
        _window = ftWindow;
    }
    return _window;
}

- (BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSURL *customURL = launchOptions[UIApplicationLaunchOptionsURLKey];
    if (customURL) {
        return [@"calabash" isEqualToString:customURL.scheme];
    } else {
        return NO;
    }
}

- (BOOL)application:(UIApplication *)app
            openURL:(NSURL *)url
            options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    return [@"calabash" isEqualToString:url.scheme];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSLog(@"Application did finish launching");
    return YES;
}

- (UIInterfaceOrientationMask)application:(UIApplication *)application
   supportedInterfaceOrientationsForWindow:(UIWindow *)window {
    return UIInterfaceOrientationMaskAll;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    NSLog(@"Application will resign active");
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    NSLog(@"Application did enter background");
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    NSLog(@"Application will enter foreground");
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    NSLog(@"Application did become active");
}

- (void)applicationWillTerminate:(UIApplication *)application {
    NSLog(@"Application will terminate");
}

@end
