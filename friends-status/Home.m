//
//  ViewController.m
//  friends-status
//
//  Created by Galileo Guzman on 04/02/15.
//  Copyright (c) 2015 Galileo Guzman. All rights reserved.
//

#import "Home.h"
#import "DAOFriend.h"
#import "CeldaFriend.h"
#import "Friend.h"

NSMutableArray *arrayFriends;

@interface Home ()

@end

@implementation Home

- (void)viewDidLoad {
    [super viewDidLoad];
    // Codigo para agregar boton dinamicamente en el encabezado del navigation controller
    
    UIBarButtonItem *btnNewFriend = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(btnNewFriendSender:)];
    
    self.navigationItem.rightBarButtonItem = btnNewFriend;
    
    DAOFriend *db = [[DAOFriend alloc] init];
    
    [db initDatabase];
    arrayFriends = [db getFriends];
    NSLog(@"Cargo la vista");
}

- (void)btnNewFriendSender:(id)sender{
    [self performSegueWithIdentifier:@"goToNewFriend" sender:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return arrayFriends.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 64;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"friendCell";
    
    CeldaFriend *cell = (CeldaFriend *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[CeldaFriend alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    Friend *f = arrayFriends[indexPath.row];
    
    cell.lblNameFriend.text = f.nameFriend;
    cell.lblStatusFriend.text = f.statusFriend;
    cell.imgAvatarFriend.image = [UIImage imageWithData:f.avatar];
    //NSLog(@"NS DATA %@", f.avatar);
    
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Friend *f = arrayFriends[indexPath.row];
    
    [self performSegueWithIdentifier:@"goToDetail" sender:self];
    
    
}



@end
