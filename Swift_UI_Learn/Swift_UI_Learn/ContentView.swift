//
//  ContentView.swift
//  Swift_UI_Learn
//
//  Created by JIDTP1408 on 05/05/25.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Student.studentid, ascending: true)],
        animation: .default)
    private var students: FetchedResults<Student>
    
    // navigation
    @State private var path = NavigationPath()
    @State private var showStudentForm = false


    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 12) {
                    ForEach(students) { student in
                        VStack(alignment: .leading, spacing: 8) {
                            Text("\(student.firstName ?? "") \(student.lastName ?? "")")
                                .font(.headline)
                            Text("Grade: \(student.grade ?? "N/A")")
                                .font(.subheadline)
                            Text("Email: \(student.email ?? "")")
                                .font(.caption)
                                .foregroundColor(.gray)
                            HStack {
                                Spacer()
                                Button(role: .destructive) {
                                    deleteStudent(student)
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                        .font(.caption)
                                        .foregroundColor(.red)
                                }
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.blue.opacity(0.5), lineWidth: 1)
                                .background(Color.white.cornerRadius(12))
                                .shadow(radius: 2)
                        )
                        .padding(.horizontal)
                        .transition(.move(edge: .bottom))
                        .onTapGesture {
                            // Placeholder for edit action
                            print("Edit student: \(student.firstName ?? "") \(student.lastName ?? "")")
                        }
                        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                            Button(role: .destructive) {
                                if let index = students.firstIndex(of: student) {
                                    deleteItems(offsets: IndexSet(integer: index))
                                }
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                    }
                    .onDelete(perform: deleteItems)
                }
                .padding()
            }
            .sheet(isPresented: $showStudentForm) {
                StudentFormView()
                    .environment(\.managedObjectContext, viewContext)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: addItem) {
                        Label("Add Student", systemImage: "plus")
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
            }
            Text("Select an item")
        }
    }

    private func addItem() {
        showStudentForm = true
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { students[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    private func deleteStudent(_ student: Student) {
        if let index = students.firstIndex(of: student) {
            deleteItems(offsets: IndexSet(integer: index))
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
