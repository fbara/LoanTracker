//
//  ContentView.swift
//  LoanTracker
//
//  Created by Frank Bara on 7/8/21.
//

import SwiftUI
import CoreData

struct LoansView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Loan.startDate, ascending: true)],
        animation: .default)
    private var loans: FetchedResults<Loan>
    
    var body: some View {
        NavigationView {
            List {
                ForEach(loans) { loan in
                    Text(loan.name ?? "Unknown")
                }
                .onDelete(perform: deleteItems)
            }
            .listStyle(PlainListStyle())
            .navigationTitle("All Loans")
            .navigationBarItems(trailing:
                Button {
                    addItem()
                } label: {
                    Image(systemName: "plus")
                        .font(.title)
                })
        }
        .accentColor(Color(.label))
    }
    
    private func addItem() {
        withAnimation {
            let newLoan = Loan(context: viewContext)
            newLoan.name = "Test loan"
            newLoan.totalAmount = 100000
            newLoan.startDate = Date()
            newLoan.dueDate = Date()
            
            do {
                try viewContext.save()
            } catch {
                print("Could not save to Core Data: \(error.localizedDescription)")
            }
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { loans[$0] }.forEach(viewContext.delete)
            
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoansView()
    }
}
