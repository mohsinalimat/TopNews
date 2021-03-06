//
//  Source of API.swift
//  Top News
//
//  Created by Egor on 08.08.17.
//  Copyright © 2017 Egor. All rights reserved.
//

import Foundation
import UIKit


class ApiObject: NSObject, NSCoding{
    let url: String
    let image: String
    var state: Bool
    
    init(url: String,image: String, state: Bool) {
        self.url = url
        self.image = image
        self.state = state
    }
    
    required convenience init?(coder decoder: NSCoder) {
        guard let url = decoder.decodeObject(forKey: "url") as? String,
            let image = decoder.decodeObject(forKey: "image") as? String
        else {return nil}
        
        let state = decoder.decodeBool(forKey: "state")
        
        
        self.init(url: url ,image: image, state: state)

    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.url, forKey: "url")
        aCoder.encode(self.image, forKey: "image")
        aCoder.encode(self.state, forKey: "state")
    }
}



class SourceOfAPI{
    
    //MARK: - All news api
    static var APIStorage:[ApiObject] = [
        ApiObject(url: "https://newsapi.org/v1/articles?source=ars-technica&sortBy=top&apiKey=082c01aeef3b4346aafa45f69267d9af", image: "ars-technica", state: false),
        ApiObject(url:"https://newsapi.org/v1/articles?source=bbc-news&sortBy=top&apiKey=082c01aeef3b4346aafa45f69267d9af", image: "bbc-news",state: false),
        ApiObject(url: "https://newsapi.org/v1/articles?source=bild&sortBy=top&apiKey=082c01aeef3b4346aafa45f69267d9af", image: "bild", state: false ),
        ApiObject(url: "https://newsapi.org/v1/articles?source=bbc-sport&sortBy=top&apiKey=082c01aeef3b4346aafa45f69267d9af", image: "bbc-sport",state: false),
        ApiObject(url: "https://newsapi.org/v1/articles?source=bloomberg&sortBy=top&apiKey=082c01aeef3b4346aafa45f69267d9af", image: "bloomberg",state: false),
        ApiObject(url: "https://newsapi.org/v1/articles?source=breitbart-news&sortBy=top&apiKey=082c01aeef3b4346aafa45f69267d9af",image: "breitbart",state:false),
        ApiObject(url:"https://newsapi.org/v1/articles?source=business-insider&sortBy=top&apiKey=082c01aeef3b4346aafa45f69267d9af",image:"business-insider",state: false),
        ApiObject(url: "https://newsapi.org/v1/articles?source=cnn&sortBy=top&apiKey=082c01aeef3b4346aafa45f69267d9af", image: "cnn", state: false),
        ApiObject(url: "https://newsapi.org/v1/articles?source=cnbc&sortBy=top&apiKey=082c01aeef3b4346aafa45f69267d9af", image: "cnbc", state: false),
        ApiObject(url: "https://newsapi.org/v1/articles?source=espn&sortBy=top&apiKey=082c01aeef3b4346aafa45f69267d9af", image: "espn", state: false),
        ApiObject(url: "https://newsapi.org/v1/articles?source=focus&sortBy=top&apiKey=082c01aeef3b4346aafa45f69267d9af", image: "focus", state: false),
        ApiObject(url: "https://newsapi.org/v1/articles?source=fortune&sortBy=top&apiKey=082c01aeef3b4346aafa45f69267d9af", image: "fortune", state: false),
        ApiObject(url: "https://newsapi.org/v1/articles?source=google-news&sortBy=top&apiKey=082c01aeef3b4346aafa45f69267d9af", image: "google", state: false),
        ApiObject(url: "https://newsapi.org/v1/articles?source=independent&sortBy=top&apiKey=082c01aeef3b4346aafa45f69267d9af", image: "idependent", state: false),
        ApiObject(url: "ttps://newsapi.org/v1/articles?source=polygon&sortBy=top&apiKey=082c01aeef3b4346aafa45f69267d9af", image: "polygon", state: false),
        ApiObject(url: "https://newsapi.org/v1/articles?source=the-new-york-times&sortBy=top&apiKey=082c01aeef3b4346aafa45f69267d9af", image: "times", state: false),
        ApiObject(url: "https://newsapi.org/v1/articles?source=techcrunch&sortBy=top&apiKey=082c01aeef3b4346aafa45f69267d9af", image: "techcrunch", state: false),
        ApiObject(url: "https://newsapi.org/v1/articles?source=recode&sortBy=top&apiKey=082c01aeef3b4346aafa45f69267d9af", image: "recode", state: false)
        ]
        


    class func sortByState() -> [ApiObject]{
        loadAPI()
        return SourceOfAPI.APIStorage.filter({ ApiObject -> Bool in
            ApiObject.state
        })
    }
    
    class func saveAPI(){
        let encodeData = NSKeyedArchiver.archivedData(withRootObject: self.APIStorage)
        UserDefaults.standard.set(encodeData, forKey: "APIStorage")
    }
    
    class func loadAPI(){
        if let data = UserDefaults.standard.object(forKey: "APIStorage"),
            let task = NSKeyedUnarchiver.unarchiveObject(with: data as! Data) as? [ApiObject]{
                self.APIStorage = task
        }
    }
}


