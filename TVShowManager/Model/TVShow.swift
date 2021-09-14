//
//  TVShow.swift
//  TVShowManager
//
//  Created by Sourabh Singh on 14/09/21.
//

import Foundation
import Parse

class TVShow: PFObject, PFSubclassing {
    @NSManaged var title: String
    @NSManaged var years: Int
    @NSManaged var seasons: Int
    
    static func parseClassName() -> String {
        return "TVShow"
    }
    
    override class func query() -> PFQuery<PFObject>? {
        let query = PFQuery(className: TVShow.parseClassName())
        query.order(byDescending: "createdAt")
        return query
    }

    init(title: String, years: Int, seasons: Int) {
      super.init()
      
      self.title = title
      self.years = years
      self.seasons = seasons
    }
    
    override init() {
      super.init()
    }
}

