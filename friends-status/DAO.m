//
//  DAO.m
//  friends-status
//
//  Created by Galileo Guzman on 04/02/15.
//  Copyright (c) 2015 Galileo Guzman. All rights reserved.
//

#import "DAO.h"

@implementation DAO

-(void)initDatabase{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    _databasePath = [documentsDirectory stringByAppendingPathComponent:@"friends.db"];
    bool databaseAlreadyExists = [[NSFileManager defaultManager] fileExistsAtPath:_databasePath];
    if (sqlite3_open([_databasePath UTF8String], &databaseHandle) == SQLITE_OK)
    {
        //NSLog(@"SE SE CREO LA BD EN EL PATH DE LA APP");
        if (!databaseAlreadyExists)
        {
            NSLog(@"SE PREPARAN LAS SENTENCIAS");
            const char *sqlStatement = "CREATE TABLE IF NOT EXISTS RECORD (ID INTEGER PRIMARY KEY AUTOINCREMENT, SCORE INT, TIMESTAMP TEXT)";
            char *error;
            if (sqlite3_exec(databaseHandle, sqlStatement, NULL, NULL, &error) == SQLITE_OK)
            {
                NSLog(@"Base de datos creada con la tabla");
            }
            else
            {
                NSLog(@"Error %s", error);
            }
        }
        else{
            //NSLog(@"PARECE QUE YA ESTA CREADA");
            //La base de Datos ya esta creada
        }
    }
}
-(void)dealloc{
    sqlite3_close(databaseHandle);
}

@end
