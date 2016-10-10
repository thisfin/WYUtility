//
//  SearchCellControllerFactory.m
//  Pods
//
//  Created by wenyou on 15/8/27.
//
//

#import "WYCellControllerFactory.h"


@implementation WYCellControllerFactory {
    NSMutableDictionary *_controllerMap;
}

- (void)reset {
    [_controllerMap removeAllObjects];
}

- (void)registerController:(id<WYCellControllerProtocol>)controller {
    if (_controllerMap == nil) {
        _controllerMap = [[NSMutableDictionary alloc] init];
    }
    
    [_controllerMap setObject:controller forKey:[controller supportDataType]];
}

- (id<WYCellControllerProtocol>)getControllerFromDataType:(NSString *)supportDataType {
    return _controllerMap[supportDataType];
}

- (NSArray *)allControllers {
    return [_controllerMap allValues];
}
@end
