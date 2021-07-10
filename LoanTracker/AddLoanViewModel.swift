//
//  AddLoanViewModel.swift
//  LoanTracker
//
//  Created by Frank Bara on 7/9/21.
//

import SwiftUI

final class AddLoanViewModel: ObservableObject {
    
   @Published var name = ""
   @Published var amount = ""
   @Published var startDate = Date()
   @Published var dueDate = Date()
    var isAddLoanShowing: Binding<Bool>
    
    init(isAddLoanShowing: Binding<Bool>) {
        self.isAddLoanShowing = isAddLoanShowing
    }
    
    func saveLoan() {
        let newLoan = Loan(context: PersistenceController.shared.viewContext)
        newLoan.id = UUID().uuidString
        newLoan.name = name
        newLoan.totalAmount = Double(amount) ?? 0.0
        newLoan.startDate = startDate
        newLoan.dueDate = dueDate
        
        PersistenceController.shared.save()
    }
    
    func isValidForm() -> Bool {
        return name.isEmpty || amount.isEmpty 
    }
}


