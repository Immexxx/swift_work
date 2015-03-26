//
//  TinyPixDocument.swift
//  TinyPix
//
//  Created by yeshaokai on 2/28/15.
//  Copyright (c) 2015 yeshaokai. All rights reserved.
//

import UIKit

class TinyPixDocument: UIDocument {
    private var bitmap: [Byte]
    override init(fileURL: NSURL) {
        bitmap = [0x01,0x02,0x04,0x08,0x10,0x20,0x40,0x80]
        super.init(fileURL:fileURL)
    }
    func stateAt(#row: Int,column: Int) -> Bool{
        let rowByte = bitmap[row]
        let result = Byte(1 << column) & rowByte
        return result != 0
    }
    func setState(state: Bool, atRow row: Int, column: Int) {
        var rowByte = bitmap[row]
        if state {
            rowByte |= Byte(1 << column)
            
        }else {
            rowByte &= ~Byte(1 << column)
        }
        bitmap[row] = rowByte
    }
    func toggleStateAt(#row: Int, column: Int) {
        let state = stateAt(row: row, column: column)
        setState(!state, atRow: row, column: column)
    }
    override func contentsForType(typeName: String, error outError: NSErrorPointer) -> AnyObject? {
        println("saving document to url \(fileURL)")
        let bitmapData = NSData( bytes:bitmap, length: bitmap.count)
        return bitmapData
    }
    override func loadFromContents(contents: AnyObject, ofType typeName: String, error outError: NSErrorPointer) -> Bool {
        println("load document from url \(fileURL)")
        let bitmapData = contents as NSData
        bitmapData.getBytes(UnsafeMutablePointer<Byte>(bitmap),length: bitmap.count)
        return true
    }
}
