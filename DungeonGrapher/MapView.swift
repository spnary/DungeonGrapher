//
//  MapView.swift
//  DungeonGrapher
//
//  Created by Stephen Nary on 6/25/19.
//  Copyright © 2019 Stephen Nary. All rights reserved.
//

import Cocoa
import DungeonGenerator

class MapView: NSView {
    

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        let chamberFactory = ChamberFactory()
        var room = chamberFactory.generate(at: Point(0, 0))
        let eastRoom = chamberFactory.generate(at: Point(room.size.width, room.size.height/2))
        room.adjacentRooms[.east] = eastRoom
        let context = NSGraphicsContext.current?.cgContext
        
        drawRoom(room, inContext: context)
 
    }
    
    func drawRoom(_ room: Room, inContext context: CGContext?) {
        print("drawing room: \(room)")
        context?.setStrokeColor(NSColor.gray.cgColor)
        context?.setFillColor(.white)
        let rect = CGRect(x: room.origin.x, y: room.origin.y, width: room.size.width, height: room.size.height)
        context?.fill(rect)
        context?.stroke(rect, width: 5)
        for (_, adjacentRoom) in room.adjacentRooms {
            guard let adjacentRoom = adjacentRoom else { continue }
            drawRoom(adjacentRoom, inContext: context)
        }
    }
    
}
