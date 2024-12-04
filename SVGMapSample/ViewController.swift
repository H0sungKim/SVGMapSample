//
//  ViewController.swift
//  SVGMapSample
//
//  Created by 김호성 on 2024.12.04.
//

import UIKit
import Macaw
import SnapKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = .white
        addComponents()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.layoutIfNeeded()
        
        scrollView.maximumZoomScale = scrollView.bounds.height / worldMapView.map.bounds!.h * 10
        scrollView.minimumZoomScale = scrollView.bounds.height / worldMapView.map.bounds!.h
        scrollView.zoomScale = scrollView.minimumZoomScale
    }
    
    private lazy var worldMapView: WorldMapView = {
        let svg = try! SVGParser.parse(resource: "world")
        let map = Group(contents: [svg], place: .identity)
        let view = WorldMapView(frame: map.bounds!.toCG())
        view.delegate = self
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.maximumZoomScale = 10
        scrollView.minimumZoomScale = 1
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.bouncesZoom = true
        scrollView.bounces = true
        scrollView.delegate = self
        return scrollView
    }()
    
    private func addComponents() {
        view.addSubview(scrollView)
        scrollView.addSubview(worldMapView)
        
        scrollView.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
        
        worldMapView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(worldMapView.map.bounds!.w)
            make.height.equalTo(worldMapView.map.bounds!.h)
        }
        
    }
    
    func focusOnCountry(with country: CountryEnum) {
        let scrollViewSize = scrollView.bounds.size
        guard let countryBounds = worldMapView.getCountryBounds(country: country) else { return }
        
        let zoomScaleX = scrollViewSize.width / countryBounds.width
        let zoomScaleY = scrollViewSize.height / countryBounds.height
        let newZoomScale = min(zoomScaleX, zoomScaleY, scrollView.maximumZoomScale)
        
        scrollView.setZoomScale(newZoomScale, animated: true)
        
        worldMapView.contentScaleFactor = scrollView.zoomScale
        
        let offsetX = (countryBounds.midX * newZoomScale) - (scrollViewSize.width / 2)
        let offsetY = (countryBounds.midY * newZoomScale) - (scrollViewSize.height / 2)
        
        let newContentOffset = CGPoint(x: max(offsetX, 0), y: max(offsetY, 0))
        scrollView.setContentOffset(newContentOffset, animated: true)
    }
}

extension ViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return worldMapView
    }
    
    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        // 확대 끝나고 해상도 높이기
        worldMapView.contentScaleFactor = scrollView.zoomScale+3
    }
}

extension ViewController: MapDelegate {
    
    func onClick(country: CountryEnum?) {
        if let country = country {
            // 나라 클릭됐을 때, 구현할 것
            print("onClicked\nID: \(country.rawValue), name: \(country.name), flag: \(country.flag)")
            focusOnCountry(with: country)
        } else {
            // 바다 클릭됐을 때, 구현할 것
            print("onClickedSea")
        }
    }
}
