//
//  DataStorageService.m
//  InternshipTrello
//
//  Created by Ivan Suntsov on 29.12.2021.
//

#import "DataStorageService.h"

NS_ASSUME_NONNULL_BEGIN

static NSString *const kModelDefaultName = @"Model";

@interface DataStorageService ()

@property (readonly, strong) NSPersistentContainer *persistentContainer;

@end

@implementation DataStorageService {
    NSString *_modelName;
}

+ (instancetype)shared {
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (instancetype)initWithModelName:(NSString *)model {
    self = [super init];
    if (self) {
        _modelName = model;
    }
    return self;
}

- (void)saveEntityForName:(NSString *)name andSetup:(void (^)(NSManagedObject *))setup {
    NSManagedObject *object = [NSEntityDescription
                               insertNewObjectForEntityForName:name
                                        inManagedObjectContext:[self persistentContainer].viewContext];
    setup(object);
    [self saveContext];
}

- (nullable NSArray<NSManagedObject *> *)getEntitiesForName:(NSString *)name {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:name];
    NSArray<NSManagedObject *> *result = [[self persistentContainer].viewContext executeFetchRequest:request error:nil];
    return result;
}

- (void)clearEntitiesForName:(NSString *)name {
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:name];
    NSBatchDeleteRequest *deleteRequest = [[NSBatchDeleteRequest alloc] initWithFetchRequest:fetchRequest];
    [[self persistentContainer].viewContext executeRequest:deleteRequest error:nil];
    [self saveContext];
}

#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    @synchronized (self) {
        if (_persistentContainer == nil) {
            NSString *modelName = _modelName ?: kModelDefaultName;
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:modelName];
            [_persistentContainer
             loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription,
                                                         NSError *error) {
                NSLog(@"store decription %@", storeDescription);
                if (error != nil) {
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
    }
}

@end

NS_ASSUME_NONNULL_END
