//
//  DAOFriend.h
//  friends-status
//
//  Created by Galileo Guzman on 04/02/15.
//  Copyright (c) 2015 Galileo Guzman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "Friend.h"

@interface DAOFriend : NSObject
{
    Friend* friend;
    sqlite3 *databaseHandle;
}

//@property (nonatomic) NSString *databasePath;
//@property (nonatomic) NSInteger *lastRecord;

- (void) initDatabase;
- (BOOL) insertFriend:(Friend*)friendParam;
- (Friend *) getFriend:(Friend*)friendParam;
- (NSMutableArray*) getFriends;
- (BOOL) deleteFriend:(Friend*)friendParam;



@end
