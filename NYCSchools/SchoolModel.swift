//
//  SchoolModel.swift
//  NYCSchools
//
//  Created by Nicky Taylor on 3/17/23.
//

import Foundation
import NYCDatabase

struct SchoolModel {
    
    public let dbn: String
    public let schoolName: String?
    
    public let website: String?
    public let phoneNumber: String?
    
    public let primaryAddressLine1: String?
    public let city: String?
    public let zip: String?
    public let stateCode: String?
    
    init(dbn: String, schoolName: String?, website: String?, phoneNumber: String?, primaryAddressLine1: String?, city: String?, zip: String?, stateCode: String?) {
        self.dbn = dbn
        self.schoolName = schoolName
        self.website = website
        self.phoneNumber = phoneNumber
        self.primaryAddressLine1 = primaryAddressLine1
        self.city = city
        self.zip = zip
        self.stateCode = stateCode
    }
    
    init(schoolEntity: SchoolEntity) {
        self.init(dbn: schoolEntity.dbn ?? "",
                  schoolName: schoolEntity.schoolName ?? "",
                  website: schoolEntity.website ?? "",
                  phoneNumber: schoolEntity.phoneNumber ?? "",
                  primaryAddressLine1: schoolEntity.primaryAddressLine1 ?? "",
                  city: schoolEntity.city ?? "",
                  zip: schoolEntity.zip ?? "",
                  stateCode: schoolEntity.stateCode ?? "")
    }
}

extension SchoolModel: Identifiable {
    var id: String { dbn }
}

extension SchoolModel {
    public static var preview: SchoolModel {
        SchoolModel(dbn: "02M260",
                    schoolName: "Clinton School Writers & Artists, M.S. 260",
                    website: "www.theclintonschool.net",
                    phoneNumber: "212-524-4360",
                    primaryAddressLine1: "10 East 15th Street",
                    city: "Manhattan",
                    zip: "10003",
                    stateCode: "NY")
    }
}
