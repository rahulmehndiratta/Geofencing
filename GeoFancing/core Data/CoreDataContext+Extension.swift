//
//  CoreDataContext+Extension.swift
//  GeoFancing
//
//  Created by Rahul on 21/12/21.
//

import Foundation
import CoreData


var kThread: UInt8 = 0
extension NSManagedObjectContext
{
    func saveContext() ->  Void
    {
        if (self.hasChanges)
        {
            self.performSafeBlock(block: {
                do {
                    try self.save()
                } catch {
                    print("Unresolved error \(error)")
                    if(self.parent != nil) {
                        self.parent?.saveContext()
                    }
                }
            })
        }
    }
    
    func performSafeBlock(block:@escaping BlockVoid) -> Void
    {
        let thread:Thread? = self.object(forKey: &kThread) as? Thread
        
        if ((self.concurrencyType == .mainQueueConcurrencyType && Thread.isMainThread) || thread == Thread.current) {
            block()
        }
        else
        {
            self.perform({
                if(thread == nil) {
                    self.set(object: Thread.current, forKey: &kThread)
                }
                block()
            })
        }
    }
}
