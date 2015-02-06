//
//  DAOFriend.m
//  friends-status
//
//  Created by Galileo Guzman on 04/02/15.
//  Copyright (c) 2015 Galileo Guzman. All rights reserved.
//

#import "DAOFriend.h"

NSString *databasePath;
NSInteger *lastRecord;

@implementation DAOFriend

-(void)initDatabase{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    databasePath = [documentsDirectory stringByAppendingPathComponent:@"db.db"];
    bool databaseAlreadyExists = [[NSFileManager defaultManager] fileExistsAtPath:databasePath];
    if (sqlite3_open([databasePath UTF8String], &databaseHandle) == SQLITE_OK)
    {
        if (!databaseAlreadyExists)
        {
            const char *sqlStatement = "create table if not exists friends (id integer primary key autoincrement, name text, status text, youtube text, imagen blob)";
            char *error;
            if (sqlite3_exec(databaseHandle, sqlStatement, NULL, NULL, &error) == SQLITE_OK)
            {
                NSLog(@"Base de datos creada con la tabla");
            }
            else
            {
                NSLog(@"Error %s", sqlite3_errmsg(databaseHandle));
            }
        }
        else{
            NSLog(@"Error %s", sqlite3_errmsg(databaseHandle));
        }
    }
    else{
        NSLog(@"Error %s", sqlite3_errmsg(databaseHandle));
    }
}
-(void)dealloc{
    sqlite3_close(databaseHandle);
}


- (BOOL) insertFriend:(Friend *)friendParam{
    
    NSLog(@"InserFriend Method");
    
    if (sqlite3_open([databasePath UTF8String], &databaseHandle) == SQLITE_OK)
    {
        NSLog(@"Base de datos Abierta");
        NSString *statementInsert = [NSString stringWithFormat:@"insert into friends (name, status, youtube, imagen) values(\"%@\", \"%@\", \"%@\", \"%@\")", friendParam.nameFriend, friendParam.statusFriend, friendParam.linkYoutube, friendParam.avatar];
        
        //NSLog(@"STM %@", statementInsert);
        
        char *error;
        if (sqlite3_exec(databaseHandle, [statementInsert UTF8String], NULL, NULL, &error) == SQLITE_OK){
            NSLog(@"RECORD AGREGADO CORRECTAMENTE");
        }
        else
        {
            NSLog(@"Error: %s", sqlite3_errmsg(databaseHandle));
        }
    }
    else
    {
        NSLog(@"Error al abrir la bd %s", sqlite3_errmsg(databaseHandle));
    }
    
    
    return NO;
}

- (Friend *) getFriend:(Friend*)friendParam{
    
    NSString *statementSelect = [NSString stringWithFormat:@"SELECT * FROM FRIENDS WHERE ID= %d",(int)friendParam.idFriend];
    
    sqlite3_stmt *statement;
    
    if (sqlite3_open([databasePath UTF8String], &databaseHandle) == SQLITE_OK){
        if(sqlite3_prepare_v2(databaseHandle, [statementSelect UTF8String], -1, &statement, NULL) == SQLITE_OK){
            while (sqlite3_step(statement) == SQLITE_ROW) {
                
                Friend *f = [[Friend alloc]
                             initWithID:[NSNumber numberWithInt:sqlite3_column_int(statement, 0)]
                             withName:[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 1)]
                             andStatusFriend:[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 2)]
                             andLinkYoutube:[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 3)]
                             andAvatar:(__bridge NSData *)(sqlite3_column_blob(statement, 4))];
                return f;
            }
            sqlite3_finalize(statement);
        }else
        {
            NSLog(@"Error %s", sqlite3_errmsg(databaseHandle));
        }
    }else{
        NSLog(@"Error al abrir la base de datos");
    }
    
    return nil;
}
- (NSMutableArray*) getFriends{
    
    NSMutableArray *friends = [[NSMutableArray alloc] init];
    
    const char *statementSelect = "select * from friends";
    
    sqlite3_stmt *statement;
    
    if (sqlite3_open([databasePath UTF8String], &databaseHandle) == SQLITE_OK){
        
        if(sqlite3_prepare_v2(databaseHandle, statementSelect, -1, &statement, NULL) == SQLITE_OK){
            
            while (sqlite3_step(statement) == SQLITE_ROW) {
                
                const void *blob = sqlite3_column_blob(statement, 4);
                NSInteger bytes = sqlite3_column_bytes(statement, 4);
                
                Friend *f = [[Friend alloc]
                             initWithID:[NSNumber numberWithInt:sqlite3_column_int(statement, 0)]
                             withName:[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 1)]
                             andStatusFriend:[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 2)]
                             andLinkYoutube:[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 3)]
                             andAvatar:[NSData dataWithBytes:blob length:bytes]];
                
                [friends addObject:f];
            }
            sqlite3_finalize(statement);
        }else
        {
            NSLog(@"Error %s", sqlite3_errmsg(databaseHandle));
        }
    }else{
        NSLog(@"Error %s", sqlite3_errmsg(databaseHandle));
    }
    
    NSLog(@"Contenido friends en bd %d", (int) friends.count);
    return friends;
    
}
- (BOOL) deleteFriend:(Friend*)friendParam{
    
    NSString *statementDelete = [NSString stringWithFormat:@"DELETE * FROM FRIENDS WHERE ID= %d",(int)friend.idFriend];
    
    sqlite3_stmt *statement;
    
    if (sqlite3_open([databasePath UTF8String], &databaseHandle) == SQLITE_OK){
        if(sqlite3_prepare_v2(databaseHandle, [statementDelete UTF8String], -1, &statement, NULL) == SQLITE_OK){
            if (sqlite3_step(statement) == SQLITE_OK){
                NSLog(@"Registro borrado");
            }
            sqlite3_finalize(statement);
        }else
        {
            NSLog(@"Error %s", sqlite3_errmsg(databaseHandle));
            return NO;
        }
    }else{
        NSLog(@"Error al abrir la base de datos");
        return NO;
    }
    
    return YES;
}


@end
