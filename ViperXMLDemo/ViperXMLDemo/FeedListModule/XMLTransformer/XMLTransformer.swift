//
//  XMLTransformer.swift
//  XMLParser
//
//

import Foundation

class XMLTransformer: NSObject {
    
    // Private var for parser
    private let parser: XMLParser
    private var arrayOfDictionary  = Array<Dictionary<String, AnyObject>>()
    private var dictionaryOfItem = Dictionary<String, AnyObject>()
    private var elementName: String = String()
    
    // Var to hold feed items
    var feedItems: [FeedModel]?
    init(data: Data) {
        parser = XMLParser(data: data)
        super.init()
        parser.delegate = self
    }
}

extension XMLTransformer {
    func transform() -> [FeedModel]? {
        if parser.parse() {
            self.feedItems = arrayOfDictionary.compactMap(FeedModel.init)
        }
        return self.feedItems
    }
}

extension XMLTransformer: XMLParserDelegate {
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        if elementName == "item" {
            dictionaryOfItem.removeAll()
        }
        if let imageURLString = attributeDict["url"]
        {
            dictionaryOfItem[elementName] = imageURLString as AnyObject
        }
        self.elementName = elementName
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item" {
            self.arrayOfDictionary.append(dictionaryOfItem)
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let data = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        if (!data.isEmpty) {
            dictionaryOfItem[self.elementName] = data as AnyObject
        }
    }}


