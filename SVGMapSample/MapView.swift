//
//  MapView.swift
//  SVGMapSample
//
//  Created by 김호성 on 2024.10.05.
//

import UIKit
import Macaw

class MapView: MacawView {
    
    private var map: Group
    
    required init?(coder aDecoder: NSCoder) {
        let svg = try! SVGParser.parse(resource: "korea")
        map = Group(contents: [svg], place: .identity)
        super.init(node: map, coder: aDecoder)
    }
    
    func transformMap(origin: CGPoint, size: CGSize) {
        map.place = Transform().move(-origin.x, -origin.y).scale(min(size.width/map.bounds!.w, size.height/map.bounds!.h), min(size.width/map.bounds!.w, size.height/map.bounds!.h))
    }
}
