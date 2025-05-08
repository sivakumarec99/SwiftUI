//
//  Student+CoreDataProperties.swift
//  Swift_UI_Learn
//
//  Created by JIDTP1408 on 06/05/25.
//
//

import Foundation
import CoreData

extension Student {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Student> {
        return NSFetchRequest<Student>(entityName: "Student")
    }

    @NSManaged public var studentid: UUID?
    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?
    @NSManaged public var dateOfBirth: Date?
    @NSManaged public var gender: String?
    @NSManaged public var grade: String?
    @NSManaged public var email: String?
    @NSManaged public var phoneNumber: String?
    @NSManaged public var address: String?
    @NSManaged public var enrollmentDate: Date?
    @NSManaged public var guardianName: String?
    @NSManaged public var guardianContact: String?
    @NSManaged public var assignedClassID: String?

}

extension Student : Identifiable {

}
