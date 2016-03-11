//
//  MovieItem.swift
//  RottenTomatoesApp
//
//  Created by Tejal Par on 9/15/14.
//

import Foundation

class MovieItem{

    var title: String?
    var description: String?
    var imageURL: NSURL?
    var origimgURLString: String?
    
    init(json: NSDictionary) {
        title = json["title"] as! String?
        description = json["description"] as! String?
        
        let imageURLStr = json["description"] as! String?
        imageURL = imageURLStr == nil ? nil : NSURL(string:imageURLStr!)
        
        if description != nil {
            stripHTML(&description!)
        }
    }
    
    init() {
        title = ""
        description = ""
        origimgURLString = ""
    }
    
    func stripHTML(inout str: String) {
        while str.rangeOfString("<[^>]+>", options: NSStringCompareOptions.RegularExpressionSearch, range: nil, locale: nil) != nil {
            let r = str.rangeOfString("<[^>]+>", options: NSStringCompareOptions.RegularExpressionSearch, range: nil, locale: nil)
            str = str.stringByReplacingCharactersInRange(r!, withString: "")
        }
        str = str.stringByReplacingOccurrencesOfString("&#039;", withString: "'", options: [], range: nil)
        str = str.stringByReplacingOccurrencesOfString("&quot;", withString: "'", options: [], range: nil)
    }
}
