//
//  WaterholesViewController.swift
//  Etoscha
//
//  Created by Björn Roxin on 18.01.21.
//

import UIKit

class MapViewController: UIViewController {
    //MARK: Constants
    private let minimumZoomScale : CGFloat = 0.15
    private let maximumZoomScale : CGFloat = 2.0
    private let zoomIncrementFactor : CGFloat = 4
    
    
    //MARK: Views
    private var scrollView = UIScrollView()
    private var mapImage = UIImageView()
    private var contentView = UIView()
    private var tapGestures = [UITapGestureRecognizer]()
    
    var focusCamp : Accommodations?
    private var markerWidth : CGFloat {
        return (image?.size.width ?? 640) / 20
    }
    private var markerHeight : CGFloat {
        return (image?.size.height ?? 1100) / 20
    }
    
    private var image : UIImage? {
        get {
            //return UIImage(named: "2019-09-13Etoscha800000Miller0-0-0")
            return mapImage.image
        }
        set {
            mapImage.image = newValue
        }
    }
    
    private let imageURL : URL = Bundle.main.url(forResource: "2019-09-13Etoscha800000Miller0-0-0", withExtension: "png")!
    
    override func viewDidLayoutSubviews() {
        scrollView.contentSize = mapImage.frame.size
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if focusCamp != nil {
            scrollView.setZoomScale(minimumZoomScale*2, animated: true)
            scrollView.setContentOffset(getCenterPoint(to: focusCamp!), animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Appearance.backgroundColor
        setupDefaultNavBar()
        fetchImage()
        setupScrollView()
        setUpMapImage()
        setupContentView()

        //let value = UIInterfaceOrientation.landscapeLeft.rawValue
        //UIDevice.current.setValue(value, forKey: "orientation")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //AppUtility.lockOrientation(.landscape, andRotateTo: .landscapeLeft)
        AppUtility.lockOrientation(.all)
        tabBarController?.tabBar.isHidden = true
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        AppUtility.lockOrientation(.portrait,andRotateTo: .portrait)
        tabBarController?.tabBar.isHidden = false
    }
    
    @objc private func waterholeViewTaped(_ sender: UITapGestureRecognizer){
        let view = sender.view
        let loc = sender.location(in: view)
        let subview = view?.hitTest(loc, with: nil)
        if subview != nil {
            if let arrayIndex = contentView.subviews.firstIndex(of: subview!){
                let index = abs(arrayIndex.distance(to: 0)) - 1 // -1 because the mapImage is first subview
                assert(index < Accommodations.allCases.count, "Index \(index) out of bounds \(Accommodations.allCases.count)")
                let accommodationClicked = Accommodations.allCases[index]
                let vc = CampController()
                vc.campName = accommodationClicked
                focusCamp = nil //reset focus to keep current scrollview zoom settings
                navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    @objc private func doubleClicked(){
        let zoomFactor = (maximumZoomScale - minimumZoomScale)/10
        let newZoomScale = scrollView.zoomScale + zoomIncrementFactor * zoomFactor
        
        if (newZoomScale >= maximumZoomScale) {
            scrollView.setZoomScale(maximumZoomScale, animated: true)
        }else {
            scrollView.setZoomScale(newZoomScale, animated: true)
        }
    }
    private func setupScrollView(){
        //Etoscha.setupScrollView(for: scrollView, parent: self.view)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isDirectionalLockEnabled = true
        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        scrollView.isDirectionalLockEnabled = false
        scrollView.minimumZoomScale = minimumZoomScale
        scrollView.maximumZoomScale = maximumZoomScale
        scrollView.delegate = self
        
        //Add gesture
        let zoomGesture = UITapGestureRecognizer(target: self, action: #selector(doubleClicked))
        zoomGesture.numberOfTapsRequired = 2
        scrollView.addGestureRecognizer(zoomGesture)
    }

    
    private func setupContentView(){
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
        NSLayoutConstraint.activate([
                contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
                contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
                contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
                contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor)
        ])
        
        for index in Accommodations.allCases.indices{
            let accommodation = Accommodations.allCases[index]
            let campView = UIView()
            campView.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(campView)

            //campView.frame.origin = getWaterholeOrigin(to: accommodation)
            NSLayoutConstraint.activate([
                campView.centerXAnchor.constraint(equalTo: contentView.leadingAnchor, constant: getWaterholeOrigin(to: accommodation).x),
                campView.centerYAnchor.constraint(equalTo: contentView.topAnchor, constant: getWaterholeOrigin(to: accommodation).y),
                campView.widthAnchor.constraint(equalToConstant: markerWidth),
                campView.heightAnchor.constraint(equalToConstant: markerHeight)
            ])
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(MapViewController.waterholeViewTaped(_:)))
            tapGesture.numberOfTapsRequired = 1
            tapGesture.numberOfTouchesRequired = 1
            campView.addGestureRecognizer(tapGesture)
            campView.isUserInteractionEnabled = true
            campView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        }
        scrollView.bringSubviewToFront(contentView)
    }
    
    private func setUpMapImage(){
        mapImage.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(mapImage)
        mapImage.sizeToFit()
        scrollView.contentSize = mapImage.frame.size
        NSLayoutConstraint.activate([
            mapImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            mapImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mapImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            mapImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }
    
    private func fetchImage() {
        do {
            let urlContents = try Data(contentsOf: imageURL)
            image = UIImage(data: urlContents)
        }catch {
            print("Image URL Problems")
        }
        assert(image != nil, "Image should be loaded")
    }
}

extension MapViewController {
    
    private func getWaterholeOrigin(to accommodation: Accommodations) -> CGPoint {
        let imageSize = image?.size ?? CGSize(width: 0, height: 0)
        return CGPoint(x: imageSize.width * accommodation.coordinates.x,//-markerWidth/2,
                       y: imageSize.height * accommodation.coordinates.y)//-markerHeight/2)
    }
    
    private func getCenterPoint(to accommodation: Accommodations) -> CGPoint{
        return CGPoint(x: scrollView.contentSize.width * accommodation.coordinates.x - view.frame.width/2,
                       y: scrollView.contentSize.height * accommodation.coordinates.y - view.frame.height/2)
    }
}

extension MapViewController: UIScrollViewDelegate{
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return contentView
    }
}

