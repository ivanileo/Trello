//
//  DataStorageService.h
//  InternshipTrello
//
//  Created by Ivan Suntsov on 29.12.2021.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

#import "Board.h"

NS_ASSUME_NONNULL_BEGIN

/**
 * Service for saving entities of any type.
 */
@interface DataStorageService : NSObject

/**
 * Returns shared singleton object of DataStorageService.
 */
+ (instancetype)shared;

/**
 * Creates DataStorageService object with specific model name.
 *
 * @param model name of model.
 */
- (instancetype)initWithModelName:(NSString *)model;

/**
 * Saves entity of certain class in CoreData.
 *
 * @param name name of class of objects that will be saved.
 * @param setup closure for setting properties of object that will be saved.
 */
- (void)saveEntityForName:(NSString *)name andSetup:(void (^)(NSManagedObject *))setup;

/**
 * Clears all entities of certain class in CoreData.
 *
 * @param name name of class of objects that will be saved.
 */
- (void)clearEntitiesForName:(NSString *)name;

/**
 * Returns all entities of certain class in CoreData.
 *
 * @param name name of class of objects that will be saved.
 */
- (nullable NSArray<NSManagedObject *> *)getEntitiesForName:(NSString *)name;

@end

NS_ASSUME_NONNULL_END
