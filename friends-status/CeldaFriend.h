//
//  CeldaFriend.h
//  friends-status
//
//  Created by Galileo Guzman on 06/02/15.
//  Copyright (c) 2015 Galileo Guzman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CeldaFriend : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *imgAvatarFriend;
@property (strong, nonatomic) IBOutlet UILabel *lblNameFriend;
@property (strong, nonatomic) IBOutlet UILabel *lblStatusFriend;

@end
