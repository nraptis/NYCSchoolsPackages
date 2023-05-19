//
//  SchoolTableCellView.swift
//  NYCSchools
//
//  Created by Nicky Taylor on 3/17/23.
//

import SwiftUI

struct SchoolTableCellView: View {
    
    let schoolViewModel: SchoolViewModel
    let school: SchoolModel
    
    var body: some View {
        HStack {
            HStack {
                HStack {
                    VStack {
                        HStack {
                            Text(schoolViewModel.schoolName(for: school))
                                .font(.system(size: 18.0).bold())
                                .foregroundColor(Color(red: 0.36, green: 0.36, blue: 0.36))
                            Spacer()
                        }
                        
                        HStack {
                            VStack {
                                HStack(spacing: 4.0) {
                                    Text(schoolViewModel.schoolPhoneNumber(for: school))
                                        .font(.system(size: 14.0))
                                        .foregroundColor(Color(red: 0.42, green: 0.42, blue: 0.42))
                                    Spacer()
                                }
                            }
                            .padding(.vertical, 12.0)
                            .padding(.horizontal, 12.0)
                        }
                        .background(RoundedRectangle(cornerRadius: 8.0).stroke().foregroundColor(Color(red: 0.72, green: 0.72, blue: 0.72)))
                        .background(RoundedRectangle(cornerRadius: 8.0).foregroundColor(Color(red: 0.90, green: 0.98, blue: 0.98)))
                        
                    }
                    .padding(.vertical, 12.0)
                    .padding(.horizontal, 12.0)
                    
                }
                
                .background(RoundedRectangle(cornerRadius: 12.0).stroke().foregroundColor(Color(red: 0.72, green: 0.72, blue: 0.72)))
                .background(RoundedRectangle(cornerRadius: 12.0).foregroundColor(Color(red: 0.86, green: 0.96, blue: 0.96)))
                .padding(.horizontal, 12.0)
            }
            
            
        }
    }
}

struct SchoolTableCellView_Previews: PreviewProvider {
    static var previews: some View {
        SchoolTableCellView(schoolViewModel: SchoolViewModel.preview,
                            school: SchoolModel.preview)
    }
}
