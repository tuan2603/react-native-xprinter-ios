
#ifdef RCT_NEW_ARCH_ENABLED
#import "RNXprinterSpec.h"

@interface Xprinter : NSObject <NativeXprinterSpec>
#else
#import <React/RCTBridgeModule.h>

@interface Xprinter : NSObject <RCTBridgeModule>
#endif

@end
