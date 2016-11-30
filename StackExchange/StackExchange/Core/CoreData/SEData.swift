//
//  DataCache.swift
//  StackExchange
//
//  Created by Alexandre Malkov on 30/11/2016.
//  Copyright © 2016 Alexandre Malkov. All rights reserved.
//

import Foundation
import CoreData

extension SEData {
    
    static func getItem(forURL url: String, addItemIfNeeded: Bool = false) -> SEData? {
        do {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: SEData.self))
            fetchRequest.predicate = NSPredicate(format: "url = %@", url)
            if let fetchResults = try DataController.getContext().fetch(fetchRequest) as? [SEData] {
                if fetchResults.count > 0 {
                    return fetchResults[0]
                }
            }
        } catch let error {
            print("ERROR: \(error)")
        }
        
        if addItemIfNeeded {
            let seData = NSEntityDescription.insertNewObject(forEntityName: String(describing: SEData.self), into: DataController.getContext()) as? SEData
            seData?.url = url
            return seData
        } else {
            return nil
        }
    }
    
    static func getAllItems() -> [SEData] {
        do {
            let fetchRequest: NSFetchRequest<SEData> = SEData.fetchRequest()
            return try DataController.getContext().fetch(fetchRequest)
        } catch let error {
            print("ERROR: \(error)")
        }
        return [SEData]()
    }
    
    static func getData(forURL url: String) -> Data? {
        if let seData = getItem(forURL: url) {
            return seData.data as? Data
        }
        
        return nil
    }
    
    static func saveData(data: Data, forURL url: String) {
        let seData = getItem(forURL: url, addItemIfNeeded: true)
        seData?.data = data as NSData
        
    }
    
    static func deleteAll() {
        do {
            let fetchRequest: NSFetchRequest<SEData> = SEData.fetchRequest()
            let allDataItems = try DataController.getContext().fetch(fetchRequest)
            for dataItem in allDataItems {
                DataController.getContext().delete(dataItem)
            }
        } catch let error {
            print("ERROR: \(error)")
        }
    }
}
