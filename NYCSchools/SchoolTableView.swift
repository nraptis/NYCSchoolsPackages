//
//  ContentView.swift
//  NYCSchools
//
//  Created by Nicky Taylor on 3/17/23.
//

import SwiftUI

struct SchoolTableView: View {
    
    @ObservedObject var schoolViewModel: SchoolViewModel
    var body: some View {
        VStack {
            List(schoolViewModel.schools) { school in
                Button {
                    schoolViewModel.clickSchoolCell(for: school)
                } label: {
                    SchoolTableCellView(schoolViewModel: schoolViewModel,
                                        school: school)
                    .padding(.vertical, 6.0)
                }
                .listRowInsets(EdgeInsets())
            }
            .listStyle(.plain)
        }
        .alert("No test scores found!", isPresented: $schoolViewModel.testScoreError) {
            Button("Okay") { }
        }
    }
}

struct SchoolTableView_Previews: PreviewProvider {
    static var previews: some View {
        SchoolTableView(schoolViewModel: SchoolViewModel.preview)
    }
}
