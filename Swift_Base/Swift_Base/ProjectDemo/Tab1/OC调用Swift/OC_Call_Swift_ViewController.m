//
//  OC_To_Swift_ViewController.m
//  Swift_Base
//
//  Created by 王爽 on 2024/11/16.
//

#import "OC_Call_Swift_ViewController.h"
#import "Swift_Base-Swift.h"

@interface OC_Call_Swift_ViewController ()

@end

@implementation OC_Call_Swift_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    testSwift();
}

void testSwift(void) {
    Car * car = [[Car alloc] initWithPrice:250000.0 band:@"奥迪"];
    [car test];
    [car run];
    [Car run];
}

@end
