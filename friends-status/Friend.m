//
//  Friend.m
//  friends-status
//
//  Created by Galileo Guzman on 04/02/15.
//  Copyright (c) 2015 Galileo Guzman. All rights reserved.
//

#import "Friend.h"
#import "DAO.h"

@implementation Friend

@synthesize idFriend;
@synthesize nameFriend;
@synthesize statusFriend;
@synthesize linkYoutube;
@synthesize avatar;

-(id)initWithID:(NSNumber *)aID withName:(NSString *)name andStatusFriend:(NSString *)status andLinkYoutube:(NSString *)youtube andAvatar:(NSData *)image{
    
    self = [super init];
    
    if (self) {
        self.idFriend = aID;
        self.nameFriend = name;
        self.statusFriend = status;
        self.linkYoutube = youtube;
        self.avatar = image;
    }
    
    return self;
}

-(Friend *)getFriend{
    Friend *friend = [[Friend alloc] init];
    
    return friend;
}

@end
