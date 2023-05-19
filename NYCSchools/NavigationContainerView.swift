//
//  NavigationContainerView.swift
//  NYCSchools
//
//  Created by Nicky Taylor on 3/17/23.
//

import SwiftUI

struct NavigationContainerView: View {
    @ObservedObject var schoolViewModel: SchoolViewModel
    var body: some View {
        NavigationStack(path: $schoolViewModel.navigationPath) {
            SchoolTableView(schoolViewModel: schoolViewModel)
                .navigationDestination(for: ScoreNavigationObject.self) { scoreNavigationObject in
                    ScoreDetailView(school: scoreNavigationObject.school,
                                    score: scoreNavigationObject.score,
                                    schoolViewModel: schoolViewModel)
                }
        }
    }
}

struct NavigationContainerView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationContainerView(schoolViewModel: SchoolViewModel.preview)
    }
}
