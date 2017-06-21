
#import "Query.h"
#import "CBX-XCTest-Umbrella.h"
#import "XCTest+CBXAdditions.h"
#import "Application.h"
#import "CoordinateQueryConfiguration.h"
#import "QuerySpecifierFactory.h"
#import "CoordinateQuery.h"
#import "CBXException.h"
#import "JSONUtils.h"
#import "XCTest+CBXAdditions.h"

@implementation Query

+ (JSONKeyValidator *)validator {
    NSArray *specifierNames = [QuerySpecifierFactory supportedSpecifierNames];
    return [JSONKeyValidator withRequiredKeys:@[]
                                 optionalKeys:specifierNames];
}

- (BOOL)isCoordinateQuery {
    return NO;
}

- (CoordinateQuery *)asCoordinateQuery {
    return [CoordinateQuery withQueryConfiguration:self.queryConfiguration.asCoordinateQueryConfiguration];
}

+ (instancetype)withQueryConfiguration:(QueryConfiguration *)queryConfig {
    Query *e = [self new];
    e.queryConfiguration = queryConfig;
    return e;
}

- (NSArray<XCUIElement *> *)execute {
    if (self.queryConfiguration.selectors.count == 0) {
        @throw [CBXException withMessage:@"Query must have at least one "
                "specifier"];
    }

    if (![Application currentApplication]) {
        @throw [CBXException withMessage:@"Current application is nil. Cannot "
                "perform queries until POST /session route is called"];
    }

    XCUIApplication *application = [Application currentApplication];
    XCUIElementQuery *query = [application cbxQueryForDescendantsOfAnyType];

    for (QuerySpecifier *specifier in self.queryConfiguration.selectors) {
        query = [specifier applyToQuery:query];
    }

    return [query allElementsBoundByIndex];
}

- (NSArray <XCUIElement *> *)executeWithApplication:(XCUIApplication *)application {

    if (_queryConfiguration.selectors.count == 0) {
        return nil;
    }

    if (!application.running) {
        @throw [CBXException withFormat:@"Application %@ is not running", application];
    }

    XCUIElementQuery *query = [application cbxQueryForDescendantsOfAnyType];

    for (QuerySpecifier *specifier in self.queryConfiguration.selectors) {
        query = [specifier applyToQuery:query];
    }

    return [query allElementsBoundByIndex];
}

- (NSDictionary *)toDict {
    return self.queryConfiguration.raw;
}

- (NSString *)toJSONString {
    return [JSONUtils objToJSONString:[self toDict]];
}

- (NSString *)description {
    return [[self toDict] ?: @{} description];
}

- (id)objectForKeyedSubscript:(NSString *)key {
    return self.queryConfiguration[key];
}

@end
