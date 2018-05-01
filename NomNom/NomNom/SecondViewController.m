//
//  SecondViewController.m
//  NomNom
//
//  Created by TIMGO001 on 4/23/18.
//  Copyright © 2018 Joanna Wang. All rights reserved.
//

#import "SecondViewController.h"
#import <Firebase/Firebase.h>

@interface SecondViewController ()

@end

@implementation SecondViewController

- (IBAction)RegisterButton:(id)sender {
    // check if both username and password are empty
    // show alert information if both textfields are empty
    if((!_usernameField.text || [_usernameField.text isEqualToString:@""]) && (!_passwordField.text || [_passwordField.text isEqualToString:@""])){
        NSString * message = @"You need to enter username and password";
        UIAlertController *error = [UIAlertController alertControllerWithTitle:@"Be Careful" message:message preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
        [error addAction:action];
        [self presentViewController:error animated:YES completion:nil];
        
    }
    // check if just username is empty, and show corresponding error message
     else if(!_usernameField.text || [_usernameField.text isEqualToString:@""]){
        NSString * message = @"You need to enter username";
        UIAlertController *error = [UIAlertController alertControllerWithTitle:@"Be Careful" message:message preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
        [error addAction:action];
        [self presentViewController:error animated:YES completion:nil];
        
    }
    // check if password is empty, and show corresponding message
     else if(!_passwordField.text || [_passwordField.text isEqualToString:@""]){
         NSString * message = @"You need to enter password";
         UIAlertController *error = [UIAlertController alertControllerWithTitle:@"Be Careful" message:message preferredStyle:UIAlertControllerStyleAlert];
         UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
         [error addAction:action];
         [self presentViewController:error animated:YES completion:nil];
         
         
     }
    // everything is correct, now you have been registered. Cong!
    else{
    NSLog(@"This line has been activated");
    [[FIRAuth auth] createUserWithEmail:_usernameField.text
                               password:_passwordField.text
                             completion:^(FIRUser *_Nullable user, NSError *_Nullable error) {
                                 NSString * message = @"You have been registered!";
                                 UIAlertController *reminder = [UIAlertController alertControllerWithTitle:@"Congradulations" message:message preferredStyle:UIAlertControllerStyleAlert];
                                 UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
                                 [reminder addAction:action];
                                 [self presentViewController:reminder animated:YES completion:nil];
                                 
                             }];
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    FIRDatabaseReference *ref = [[FIRDatabase database] reference];
    

    //NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //if(![defaults boolForKey:@"Registered"]){
      //  NSLog(@"No registered user");
       // _LogInbtn.hidden = YES;
   // }
   // else{
     //   NSLog(@"This user has already registered");
      //  _Registerbtn.hidden = YES;
    //}
    // Do any additional setup after loading the view.
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

/*
- (IBAction)userna:(id)sender {
}*/
/*
- (IBAction)registerUser:(id)sender {
    if([_usernameField.text isEqualToString:@""] || [_passwordField.text isEqualToString:@""]){
        UIAlertController *error = [UIAlertController alertControllerWithTitle:@"Be Careful" message:@"You need to enter both username and password" preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:error animated:YES completion:nil];
        
    }
    //put code about creating new users here
    NSLog(@"This line has been activated");
    [[FIRAuth auth] createUserWithEmail:_usernameField.text
                               password:_passwordField.text
                             completion:^(FIRUser *_Nullable user, NSError *_Nullable error) {
                                 // ...
                                 
                                 
                             }];
    
 
} */
/*
-(void)registerNewUser{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:_usernameField.text forKey:@"username"];
    [defaults setObject:_passwordField.text forKey:@"password"];
    [defaults setBool:YES forKey:@"Registered"];
    
    [defaults synchronize];
    
    UIAlertController *success = [UIAlertController alertControllerWithTitle:@"Sucess" message:@"Thank you for choosing NomNom" preferredStyle:UIAlertControllerStyleAlert];
    [self presentViewController:success animated:YES completion:nil];
    
    [self performSegueWithIdentifier:@"Log in" sender:self];

}
*/


- (IBAction)loginUser:(id)sender {

    // pass the username and password to firebase by the following code
        [[FIRAuth auth] signInWithEmail:_usernameField.text
                               password:_passwordField.text
                             completion:^(FIRUser *user, NSError *error) {
                                 if(error == NULL){
                                     //read data if user successfully sign in
                                     NSLog(@"You should have logged in");
                                                                         //go to third view controller to display the data
                                     UIStoryboard* storyboard = [UIStoryboard storyboardWithName: @"Main" bundle:nil];
                                     ThirdViewController *thirdviewcontroller = [storyboard instantiateViewControllerWithIdentifier:@"12345"];
                                     
                                     [self presentViewController:thirdviewcontroller
                                                        animated:YES
                                                      completion:nil];
                                    
                                 }
                                 
                                 else{
                                     //if sign in failed, then remind users
                                     NSString * message = @"Something went wrong with sign in";
                                     UIAlertController *error = [UIAlertController alertControllerWithTitle:@"Sorry" message:message preferredStyle:UIAlertControllerStyleAlert];
                                     UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
                                     [error addAction:action];
                                     [self presentViewController:error animated:YES completion:nil];
                                }
                             }];
    }
@end
