//
//  AddLoanView.swift
//  LoanTracker
//
//  Created by Frank Bara on 7/9/21.
//

import SwiftUI

struct AddLoanView: View {
    
    @ObservedObject var viewModel: AddLoanViewModel
    
    var body: some View {
        
        VStack {
            HStack {
                Button {
                    viewModel.isAddLoanShowing.wrappedValue = false
                } label: {
                    Text("Cancel")
                        .font(.title3)
                        .frame(width: 80, height: 30)
                    
                }
                
                Spacer()
                
                Button {
                    viewModel.saveLoan()
                    viewModel.isAddLoanShowing.wrappedValue = false
                } label: {
                    Text("Done")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .frame(width: 70, height: 30)
                }
                .disabled(viewModel.isValidForm())
            }
            .padding()
            
            Form {
                TextField("Name", text: $viewModel.name)
                    .autocapitalization(.sentences)
                
                TextField("Amount", text: $viewModel.amount)
                    .keyboardType(.numberPad)
                DatePicker("Start Date", selection: $viewModel.startDate, displayedComponents: .date)
                DatePicker("Due Date", selection: $viewModel.dueDate, displayedComponents: .date)
            }
        }
    }
}
