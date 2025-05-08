//
//  StudentFormView.swift
//  Swift_UI_Learn
//
//  Created by JIDTP1408 on 06/05/25.
//

import Foundation
import SwiftUI

struct StudentFormView: View {
    @StateObject private var viewModel = StudentViewModel()
    @Environment(\.managedObjectContext) private var context
    @Environment(\.dismiss) private var dismiss

    let genderOptions = ["Male", "Female", "Other"]

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Student Info")) {
                    TextField("First Name", text: $viewModel.firstName)
                    TextField("Last Name", text: $viewModel.lastName)
                    DatePicker("Date of Birth", selection: $viewModel.dateOfBirth, displayedComponents: .date)
                    Picker("Gender", selection: $viewModel.gender) {
                        ForEach(genderOptions, id: \.self) { gender in
                            Text(gender)
                        }
                    }
                    TextField("Grade", text: $viewModel.grade)
                }

                Section(header: Text("Contact")) {
                    TextField("Email", text: $viewModel.email)
                    TextField("Phone Number", text: $viewModel.phoneNumber)
                    TextField("Address", text: $viewModel.address)
                }

                Section(header: Text("Guardian Info")) {
                    TextField("Guardian Name", text: $viewModel.guardianName)
                    TextField("Guardian Contact", text: $viewModel.guardianContact)
                }

                Section(header: Text("Enrollment")) {
                    DatePicker("Enrollment Date", selection: $viewModel.enrollmentDate, displayedComponents: .date)
                    TextField("Assigned Class ID", text: $viewModel.assignedClassID)
                }

                Button("Save Student") {
                    saveStudent()
                }
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .center)
            }
            .navigationTitle("New Student")
        }
    }

    private func saveStudent() {
        let student = Student(context: context)
        student.studentid = UUID()
        student.firstName = viewModel.firstName
        student.lastName = viewModel.lastName
        student.dateOfBirth = viewModel.dateOfBirth
        student.gender = viewModel.gender
        student.grade = viewModel.grade
        student.email = viewModel.email
        student.phoneNumber = viewModel.phoneNumber
        student.address = viewModel.address
        student.enrollmentDate = viewModel.enrollmentDate
        student.guardianName = viewModel.guardianName
        student.guardianContact = viewModel.guardianContact
        student.assignedClassID = viewModel.assignedClassID

        do {
            try context.save()
            viewModel.reset()
            dismiss()
        } catch {
            print("Failed to save student: \(error.localizedDescription)")
        }
    }
}
