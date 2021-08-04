//
//  SimulasiDataManager.swift
//  Esmeka-MC3
//
//  Created by Dheo Gildas Varian on 30/07/21.
//

import Foundation
import CoreData

struct SimulasiDataManager {
    static var shared = SimulasiDataManager()
    private init() {}
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Esmeka_MC3")
        
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error)")
            }
        }
        return container
    }()
    
    func saveContext() {
        let context = SimulasiDataManager.shared.persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let error = error as NSError
                fatalError("Unresolved error \(error)")
            }
        }
    }
    /*
    func fetchSimulasi() -> [InterviewModel]?{
        let context = SimulasiDataManager.shared.persistentContainer.viewContext
        let fetchInterview = NSFetchRequest<NSManagedObject>(entityName: "InterviewEntity")
        
        do{
            var interview: [InterviewModel] = []
            let statusArray = try context.fetch(fetchInterview)
            for status in statusArray as! [InterviewEntity] {
                interview.append(InterviewModel(interviewId: Int(status.interview_id), duration: Int(status.interview_duration), interviewTitle: status.interview_title!, interviewDate: status.interview_date!, interviewURLPath: status.interview_video_url_path!))
            }
            return interview
        } catch {
            print("could not fetch \(error.localizedDescription)")
            return nil
        }
    }
 */
}
