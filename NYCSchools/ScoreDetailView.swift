//
//  ScoreDetailView.swift
//  NYCSchools
//
//  Created by Nicky Taylor on 3/17/23.
//

import SwiftUI
import NYCNetworking

struct ScoreDetailView: View {
    
    let school: SchoolModel
    let score: Score
    let schoolViewModel: SchoolViewModel
    var body: some View {
        
        VStack {
            ScrollView {
                
                titleBox()
                resultsBox()
                
            }
        }
    }
    
    func titleBox() -> some View {
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
    
    func resultsBox() -> some View {
        HStack {
            HStack {
                HStack {
                    VStack {
                        resultsRowBoxAlt(title: "SAT Test Results",
                                         text: "")
                        resultsRowBoxAlt(title: "Takers: ",
                                      text: schoolViewModel.scoreTestTakerCount(for: score))
                        lineView()
                        resultsRowBox(title: "Reading",
                                      text: schoolViewModel.scoreCriticalReading(for: score))
                        resultsRowBox(title: "Writing",
                                      text: schoolViewModel.scoreWriting(for: score))
                        resultsRowBox(title: "Math",
                                      text: schoolViewModel.scoreMath(for: score))
                        
                        
                        if let url = URL(string: schoolViewModel.schoolWebsite(for: school)) {
                            HStack {
                                Link("School Website", destination: url)
                                Spacer()
                            }
                            .padding(.leading, 4.0)
                        }
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
    
    func resultsRowBox(title: String, text: String) -> some View {
        HStack {
            VStack {
                HStack(spacing: 4.0) {
                    Text("\(title): ")
                        .font(.system(size: 14.0).bold())
                        .foregroundColor(Color(red: 0.42, green: 0.42, blue: 0.42))
                    Text(text)
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
    
    func resultsRowBoxAlt(title: String, text: String) -> some View {
        HStack {
            VStack {
                HStack(spacing: 4.0) {
                    Text("\(title)")
                        .font(.system(size: 14.0).bold())
                        .foregroundColor(Color(red: 0.96, green: 0.96, blue: 0.96))
                    Text(text)
                        .font(.system(size: 14.0))
                        .foregroundColor(Color(red: 0.92, green: 0.92, blue: 0.92))
                    Spacer()
                }
            }
            .padding(.vertical, 12.0)
            .padding(.horizontal, 12.0)
        }
        .background(RoundedRectangle(cornerRadius: 8.0).stroke().foregroundColor(Color(red: 0.42, green: 0.42, blue: 0.42)))
        .background(RoundedRectangle(cornerRadius: 8.0).foregroundColor(Color(red: 0.35, green: 0.35, blue: 0.35)))
    }
    
    func lineView() -> some View {
        HStack {
            Spacer()
        }
        .frame(height: 1.0)
        .background(Color(red: 0.65, green: 0.65, blue: 0.65))
    }
    
}

struct ScoreDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ScoreDetailView(school: SchoolModel.preview,
                        score: Score.preview,
                        schoolViewModel: SchoolViewModel.preview)
    }
}
