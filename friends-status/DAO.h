//
//  DAO.h
//  friends-status
//
//  Created by Galileo Guzman on 04/02/15.
//  Copyright (c) 2015 Galileo Guzman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface DAO : NSObject
{
    sqlite3 *databaseHandle;
}

@property (nonatomic) NSString *databasePath;
@property (nonatomic) NSInteger *lastRecord;

@end
