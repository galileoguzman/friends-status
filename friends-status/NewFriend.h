//
//  NewFriend.h
//  friends-status
//
//  Created by Galileo Guzman on 05/02/15.
//  Copyright (c) 2015 Galileo Guzman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewFriend : UIViewController<UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (strong, nonatomic) IBOutlet UITextField *txtNombre;
@property (strong, nonatomic) IBOutlet UITextField *txtStatus;
@property (strong, nonatomic) IBOutlet UITextField *txtYoutube;

@property (strong, nonatomic) IBOutlet UIImageView *imgAvatar;
@property (strong, nonatomic) IBOutlet UIButton *btnPicture;


- (IBAction)btnCameraSender:(id)sender;

- (IBAction)btnSaveFriendSender:(id)sender;
@end
