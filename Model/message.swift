//
//  message.swift
//  newSocialApp
//
//  Created by akbar  Rizvi on 1/16/20.
//  Copyright © 2020 akbar  Rizvi. All rights reserved.
//

import Foundation
class Message {
    var id: String
    var from:String
    var to:String
    var text:String
    var height:Double
    var width:Double

init(id: String,from: String,to: String,text: String,height: Double,width: Double) {
    self.id = id
    self.from = from
    self.to = to
    self.text = text
    self.height = height
    self.width = width
}

    static func transformMessage(dict: [String:Any], keyId: String) -> Message? {
        guard let from = dict["from"] as? String,
            let to = dict["to"] as? String else {
        return nil
        
    }
        let text = (dict["text"] as? String) == nil ? "" : (dict["text"]! as! String)
        let height = (dict["height"] as? Double) == nil ? 0 : (dict["height"]! as! Double)
        let width = (dict["width"] as? Double) == nil ? 0 : (dict["width"]! as! Double)
        
        let message = Message(id: keyId, from: from, to: to,  text: text, height: height, width: width)
        return  message
    }

    
    
}

