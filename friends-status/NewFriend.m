//
//  NewFriend.m
//  friends-status
//
//  Created by Galileo Guzman on 05/02/15.
//  Copyright (c) 2015 Galileo Guzman. All rights reserved.
//

#import "NewFriend.h"
#import "Friend.h"
#import "DAOFriend.h"
#define kOFFSET_FOR_KEYBOARD 100.0


@interface NewFriend ()

@end

@implementation NewFriend

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    // unregister for keyboard notifications while not visible.
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
}

-(void)keyboardWillShow {
    // Animate the current view out of the way
    if (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
    else if (self.view.frame.origin.y < 0)
    {
        [self setViewMovedUp:NO];
    }
}

-(void)keyboardWillHide {
    if (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
    else if (self.view.frame.origin.y < 0)
    {
        [self setViewMovedUp:NO];
    }
}

-(void)textFieldDidBeginEditing:(UITextField *)sender
{
    if ([sender isEqual:self.txtNombre] ||  [sender isEqual:self.txtStatus] || [sender isEqual:self.txtYoutube])
    {
        //move the main view, so that the keyboard does not hide it.
        if  (self.view.frame.origin.y >= 0)
        {
            [self setViewMovedUp:YES];
        }
    }
}

//method to move the view up/down whenever the keyboard is shown/dismissed
-(void)setViewMovedUp:(BOOL)movedUp
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3]; // if you want to slide up the view
    
    CGRect rect = self.view.frame;
    if (movedUp)
    {
        // 1. move the view's origin up so that the text field that will be hidden come above the keyboard
        // 2. increase the size of the view so that the area behind the keyboard is covered up.
        rect.origin.y -= kOFFSET_FOR_KEYBOARD;
        rect.size.height += kOFFSET_FOR_KEYBOARD;
    }
    else
    {
        // revert back to the normal state.
        rect.origin.y += kOFFSET_FOR_KEYBOARD;
        rect.size.height -= kOFFSET_FOR_KEYBOARD;
    }
    self.view.frame = rect;
    
    [UIView commitAnimations];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)btnCameraSender:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Fotografia"
                                       message:@"Elegir fotografía de"
                                      delegate:self
                             cancelButtonTitle:@"Cancelar"
                             otherButtonTitles:@"Camara", @"Carrete", nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    
    if(buttonIndex == 0)
    {
        NSLog(@"Cancelar");
    }
    else if(buttonIndex == 1)
    {
        NSLog(@"Camara");
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else if(buttonIndex == 2)
    {
        NSLog(@"Carrete");
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    [self presentViewController:picker animated:YES completion:NULL];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.imgAvatar.image = chosenImage;
    self.btnPicture.hidden = YES;
    [picker dismissViewControllerAnimated:YES completion:NULL];
}


- (IBAction)btnSaveFriendSender:(id)sender {
    
    if ([self.txtNombre.text isEqual:@""] || [self.txtStatus.text isEqual:@""] || [self.txtYoutube.text isEqual:@""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Campos requeridos" message:@"Verifica que hayas ingresado toda la información" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        
        [alert show];
    }else{
        Friend *f = [[Friend alloc] init];
        DAOFriend *data = [[DAOFriend alloc] init];
        
        f.nameFriend = self.txtNombre.text;
        f.statusFriend = self.txtStatus.text;
        f.linkYoutube = self.txtYoutube.text;
        f.avatar = UIImagePNGRepresentation(self.imgAvatar.image);
        
        NSLog(@"boton guardar");
        [data insertFriend:f];
        //[self performSegueWithIdentifier:@"backToHome" sender:self];
    }
}

@end
