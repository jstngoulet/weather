//
// Generated by CocoaPods-Keys
// on 16/09/2021
// For more information see https://github.com/orta/cocoapods-keys
//

#import <Foundation/NSDictionary.h>
#import "WeatherKeys.h"

@interface WeatherKeys ()

@property (nonatomic, copy) NSString *openWeatherAPIKey;


@end

@implementation WeatherKeys

- (instancetype)init
{
    if (!(self = [super init])) { return nil; }

    
    
      char openWeatherAPIKeyCString[33] = { [WeatherKeysData characterAtIndex:585], [WeatherKeysData characterAtIndex:158], [WeatherKeysData characterAtIndex:331], [WeatherKeysData characterAtIndex:299], [WeatherKeysData characterAtIndex:676], [WeatherKeysData characterAtIndex:511], [WeatherKeysData characterAtIndex:415], [WeatherKeysData characterAtIndex:409], [WeatherKeysData characterAtIndex:599], [WeatherKeysData characterAtIndex:377], [WeatherKeysData characterAtIndex:115], [WeatherKeysData characterAtIndex:329], [WeatherKeysData characterAtIndex:47], [WeatherKeysData characterAtIndex:817], [WeatherKeysData characterAtIndex:231], [WeatherKeysData characterAtIndex:551], [WeatherKeysData characterAtIndex:715], [WeatherKeysData characterAtIndex:839], [WeatherKeysData characterAtIndex:278], [WeatherKeysData characterAtIndex:165], [WeatherKeysData characterAtIndex:104], [WeatherKeysData characterAtIndex:588], [WeatherKeysData characterAtIndex:423], [WeatherKeysData characterAtIndex:149], [WeatherKeysData characterAtIndex:54], [WeatherKeysData characterAtIndex:289], [WeatherKeysData characterAtIndex:742], [WeatherKeysData characterAtIndex:137], [WeatherKeysData characterAtIndex:452], [WeatherKeysData characterAtIndex:397], [WeatherKeysData characterAtIndex:583], [WeatherKeysData characterAtIndex:223], '\0' };
    
    _openWeatherAPIKey = 
        
          [NSString stringWithCString:openWeatherAPIKeyCString encoding:NSUTF8StringEncoding];
        
      
    

    return self;
}

static NSString *WeatherKeysData = @"WcOO1u1qZQKDUBsgB1AvJnQ5RTMiLQaylpXh9BXNPfZ+JPecK05Bti0YCGQNnFOZMK1TXkPuQ4bdKXLR/ElrS4O6+QazUOnnwQuM7RPtctfyG49LT+Ucf9tbp43iOzsKIxeA4TtCO0OSYDxFVfozz6j4AGhowDdDGmhtB9EhNipbiX5zfMC0H3D9YdKNIfWSQ29UCZvMKU0jKxYNBJEy/cDv0ZyAYHi2FH01iKf1GSxy2cTscjbgIG7nAXT5D9gjDLLXBY00CTz7TXABafhtM62/9P8flI6J49jF7HMJ4mYaRIAM5euOXTXS14xZNwqIw9+pQvXDS47frZcxdZYANPwk9LNLTdM3QQfiRGwbFSP9/TwW3eTy9FBS96qtevS5dx1+SmTkSYT+I9HAnchxTEjDldWVrZMbrIGaEBI0nwOa3esaXzwk8n3uI8LmPHEo2Y+n22qeem5laiCPRZSOkP6+hgyjxngOQ2zDuNxe0b1mxPm8AGiRd7kLHN0iVqK4DTEygZyYKoQVVr6v4Huzjqcr63mel5+kIiF5OEf5zZ++Rk2GhecJ8wJYLIwmVNrESv9QY2BaA0336mhndx9omhU0lHKkzuvs9slS2yuTpaO0MWSoPgNZaFpUUqZpnSz1CIo/33ZNTXgHhlZCQH9TgyYv4yXR4LNw6VVn1UWe+zSgRlDnNsfxM1b0av0v/YHtQ465uuBT7ci7ITdmY9bnMr4gvTNTQLBtwox5YCa/whzHudA2K3+xqSTTSj0z86aiL1dJl09nEiqxnFcMGA9u7RObFGQZKkCoJdw+4LeL8xa1m0uZL9AYDYHY5lCKnlr8OZ5LfnC4sVgDSpeMUHx7sg==\\\"";

- (NSString *)description
{
  return [@{
            @"openWeatherAPIKey": self.openWeatherAPIKey,
  } description];
}

- (id)debugQuickLookObject
{
  return [self description];
}

@end
