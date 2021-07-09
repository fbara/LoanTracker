//
//  LoanCellView.swift
//  LoanTracker
//
//  Created by Frank Bara on 7/9/21.
//

import SwiftUI

struct LoanCellView: View {
    
    let name: String
    let amount: Double
    let date: Date
    
    var body: some View {
        
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Text(name)
                Text(amount.toCurrency)
            }
            Spacer()
            Text(date.longDate)
        }
        
    }
}

struct LoanCellView_Previews: PreviewProvider {
    static var previews: some View {
        LoanCellView(name: "Test name", amount: 1000, date: Date())
    }
}
