//
//  ViewController.swift
//  SVGMapSample
//
//  Created by 김호성 on 2024.10.05.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var scrollBlankView: ScrollBlankView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var mapView: MapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollBlankView.belowView = mapView
        scrollView.delegate = self
//        mapView.contentMode = .scaleAspectFit
    }
}

extension ViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return scrollBlankView
    }
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        print("Zoom")
//        print(scrollView.contentSize)
//        print(scrollView.zoomScale)
        
        mapView.transformMap(origin: scrollView.contentOffset, scale: scrollView.zoomScale)
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("Scroll")
        mapView.transformMap(origin: scrollView.contentOffset, scale: scrollView.zoomScale)
    }
}
