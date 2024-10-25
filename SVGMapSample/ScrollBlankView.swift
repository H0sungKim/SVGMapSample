//
//  ScrollBlankView.swift
//  SVGMapSample
//
//  Created by 김호성 on 2024.10.25.
//

import UIKit

class ScrollBlankView: UIView {
    var belowView: UIView?
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        belowView?.touchesBegan(touches, with: event)
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        belowView?.touchesMoved(touches, with: event)
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        belowView?.touchesEnded(touches, with: event)
    }
}
