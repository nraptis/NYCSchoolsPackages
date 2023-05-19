//
//  Score.swift
//  
//
//  Created by Nicky Taylor on 3/17/23.
//

import Foundation

public struct Score: Decodable {
    public let numOfSatTestTakers: String?
    public let satMathAvgScore: String?
    public let satCriticalReadingAvgScore: String?
    public let satWritingAvgScore: String?
}

extension Score {
    public static var preview: Score {
        Score(numOfSatTestTakers: "29",
              satMathAvgScore: "404",
              satCriticalReadingAvgScore: "355",
              satWritingAvgScore: "363")
    }
}
