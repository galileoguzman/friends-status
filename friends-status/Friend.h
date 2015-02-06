//
//  Friend.h
//  friends-status
//
//  Created by Galileo Guzman on 04/02/15.
//  Copyright (c) 2015 Galileo Guzman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Friend : NSObject
{
    NSNumber *idFriend;
    NSString *nameFriend;
    NSString *statusFriend;
    NSString *linkYoutube;
    NSData *avatar;
}
@property (nonatomic) NSNumber* idFriend;
@property (nonatomic, strong) NSString* nameFriend;
@property (nonatomic, strong) NSString* statusFriend;
@property (nonatomic, strong) NSString* linkYoutube;
@property (nonatomic, strong) NSData* avatar;

-(id)initWithID:(NSNumber*)aID withName:(NSString*)name andStatusFriend:(NSString*)status andLinkYoutube:(NSString*)youtube andAvatar:(NSData*)image;

-(Friend *)getFriend;

@end
