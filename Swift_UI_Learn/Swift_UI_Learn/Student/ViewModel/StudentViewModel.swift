//
//  StudentViewModel.swift
//  Swift_UI_Learn
//
//  Created by JIDTP1408 on 06/05/25.
//

import Foundation
import SwiftUI

class StudentViewModel: ObservableObject {
    @Published var firstName = ""
    @Published var lastName = ""
    @Published var dateOfBirth = Date()
    @Published var gender = "Male"
    @Published var grade = ""
    @Published var email = ""
    @Published var phoneNumber = ""
    @Published var address = ""
    @Published var enrollmentDate = Date()
    @Published var guardianName = ""
    @Published var guardianContact = ""
    @Published var assignedClassID = ""

    func reset() {
        firstName = ""
        lastName = ""
        dateOfBirth = Date()
        gender = "Male"
        grade = ""
        email = ""
        phoneNumber = ""
        address = ""
        enrollmentDate = Date()
        guardianName = ""
        guardianContact = ""
        assignedClassID = ""
    }
}
