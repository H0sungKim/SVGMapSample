//
//  ViewController.swift
//  SVGMapSample
//
//  Created by 김호성 on 2024.10.05.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var scrollBlankView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var mapView: MapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        mapView.transformMap(origin: scrollView.contentOffset, size: scrollView.contentSize)
    }
}

extension ViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        print("Move")
        mapView.transformMap(origin: scrollView.contentOffset, size: scrollView.contentSize)
        return scrollBlankView
    }
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        print("Zoom")
        mapView.transformMap(origin: scrollView.contentOffset, size: scrollView.contentSize)
    }
}
