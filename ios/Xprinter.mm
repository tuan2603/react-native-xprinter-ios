#import "Xprinter.h"
#import "POSPrinterSDK.h"

@implementation Xprinter {
    POSWIFIManager *_wifiManager;
    BOOL _connectionResolveInvoked;
    RCTPromiseResolveBlock _connectionResolve;
    RCTPromiseRejectBlock _connectionReject;
}

RCT_EXPORT_MODULE()


- (instancetype)init {
    self = [super init];
    if (self) {
        // Initialize wifiManager and set its delegate to self
        _wifiManager = [POSWIFIManager sharedInstance];
        _wifiManager.delegate = self;
    }
    return self;
}


// Example method
// See // https://reactnative.dev/docs/native-modules-ios
RCT_EXPORT_METHOD(multiply:(double)a
                  b:(double)b
                  resolve:(RCTPromiseResolveBlock)resolve
                  reject:(RCTPromiseRejectBlock)reject)
{
    NSNumber *result = @(a * b);

    resolve(result);
}

RCT_EXPORT_METHOD(connect:(NSString *)ipAddress
                  resolve:(RCTPromiseResolveBlock)resolve
                  reject:(RCTPromiseRejectBlock)reject)
{
    _connectionResolve = resolve;
    _connectionReject = reject;
    
    if (_wifiManager.isConnect) {
        [_wifiManager disconnect];
    }
    
    [_wifiManager connectWithHost:ipAddress port:9100];

}

- (void)resetConnectionFlags {
    _connectionResolveInvoked = NO;
    _connectionResolve = nil;
    _connectionReject = nil;
}


//connected success
- (void)POSwifiConnectedToHost:(NSString *)host port:(UInt16)port {
    NSLog(@"connected success");
    if (_connectionResolve && !_connectionResolveInvoked) {
        _connectionResolve(@(YES));
        _connectionResolveInvoked = YES;
        [self resetConnectionFlags];
    }
}

//disconnected
- (void)POSwifiDisconnectWithError:(NSError *)error {
    NSLog(@"disconnected");
    if (error) {
        if (_connectionReject && !_connectionResolveInvoked) {
            _connectionReject(@"0", @"error", error);
            _connectionResolveInvoked = YES;
            [self resetConnectionFlags];
        }
    } else {
        if (_connectionResolve && !_connectionResolveInvoked) {
            _connectionResolve(@(NO));
            _connectionResolveInvoked = YES;
            [self resetConnectionFlags];
        }
    }
}




// Don't compile this code when we build for the old architecture.
#ifdef RCT_NEW_ARCH_ENABLED
- (std::shared_ptr<facebook::react::TurboModule>)getTurboModule:
    (const facebook::react::ObjCTurboModule::InitParams &)params
{
    return std::make_shared<facebook::react::NativeXprinterSpecJSI>(params);
}
#endif

@end
