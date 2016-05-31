
//你应该知道你敲了多少行代码
//find . "(" -name "*.m" -or -name "*.strings" -or -name "*.h" ")" -print | xargs wc -l
//
//  AppDelegate.h
//  高仿BiLibili
//
//  Created by 黄人煌 on 16/4/29.
//  Copyright © 2016年 黄人煌. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

- (void)setUpLoginViewController;


@end

