//
//  ThirdViewController.m
//  NomNom
//
//  Created by TIMGO001 on 4/24/18.
//  Copyright © 2018 Joanna Wang. All rights reserved.
//

#import "ThirdViewController.h"

@interface ThirdViewController ()

@end

@implementation ThirdViewController

- (IBAction)Logout:(id)sender {
    // when log out, user should go back to 2nd view controller
    UIViewController *controler = [[UIViewController alloc] init];
    [self.navigationController pushViewController:controler animated:YES];

    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.ref=[[FIRDatabase database]reference];
    NSString *userID = [FIRAuth auth].currentUser.uid;
    // write data to firebase for this particular user
    [[[_ref child:@"users"] child:userID]
     setValue:@{@"restaurantName": @"Name of restaurant"}];
//    [[self.ref child: userID] setValue:@"Name of restaurant"];
    // update data here
//    NSString *key = [[_ref child:@"posts"] childByAutoId].key;
//    NSDictionary *post = @{@"uid": userID,
//                           @"author": username,
//                           @"title": title,
//                           @"body": body};
//    NSDictionary *childUpdates = @{[@"/posts/" stringByAppendingString:key]: post,
//                                   [NSString stringWithFormat:@"/user-posts/%@/%@/", userID, key]: post};
//    [_ref updateChildValues:childUpdates];
//
//    //delete the value
//    [_ref updateChildValues:nil];
    
    
    [[[self.ref child:@"users"] child:userID] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        NSDictionary *dict = snapshot.value;
        NSLog(@"%@",dict);
        //show error message if there is something wrong
    } withCancelBlock:^(NSError * _Nonnull error) {
        NSLog(@"%@", error.localizedDescription);
    }
     ];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)logout:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
