//
//  UIMammalProfile.swift
//  Etoscha
//
//  Created by Björn Roxin on 28.05.21.
//

import UIKit

class UIImageViewBluredBackground: UIView {
    let featuredPhotoView = UIImageView()
    let blurPhoto = UIImageView()
    var blurEffectView = UIVisualEffectView()

    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        featuredPhotoView.layer.cornerRadius = 0
        featuredPhotoView.layer.masksToBounds = true
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews(){
        featuredPhotoView.translatesAutoresizingMaskIntoConstraints = false
        blurPhoto.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(blurPhoto)
        self.addSubview(featuredPhotoView)
        NSLayoutConstraint.activate([
            featuredPhotoView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            featuredPhotoView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            featuredPhotoView.topAnchor.constraint(equalTo: self.topAnchor),
            featuredPhotoView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
        NSLayoutConstraint.activate([
            blurPhoto.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            blurPhoto.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            blurPhoto.topAnchor.constraint(equalTo: self.topAnchor),
            blurPhoto.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
        blurPhoto.contentMode = .scaleAspectFill
        
        let blurEffect = UIBlurEffect(style: .light)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.translatesAutoresizingMaskIntoConstraints = false
        blurPhoto.addSubview(blurEffectView)
        NSLayoutConstraint.activate([
                    blurEffectView.leadingAnchor.constraint(equalTo: blurPhoto.leadingAnchor),
                    blurEffectView.trailingAnchor.constraint(equalTo: blurPhoto.trailingAnchor),
                    blurEffectView.topAnchor.constraint(equalTo: blurPhoto.topAnchor),
                    blurEffectView.bottomAnchor.constraint(equalTo: blurPhoto.bottomAnchor),
                ])
//
//        blurPhoto.addSubview(blurEffectView)
//        NSLayoutConstraint.activate([
//            blurEffectView.leadingAnchor.constraint(equalTo: blurPhoto.leadingAnchor),
//            blurEffectView.trailingAnchor.constraint(equalTo: blurPhoto.trailingAnchor),
//            blurEffectView.topAnchor.constraint(equalTo: blurPhoto.topAnchor),
//            blurEffectView.bottomAnchor.constraint(equalTo: blurPhoto.bottomAnchor),
//        ])
//        blurEffectView.center = blurPhoto.center
//        blurEffectView.effect = UIBlurEffect(style: .regular)
        
        //featuredPhotoView.contentMode = .scaleAspectFit
        self.bringSubviewToFront(featuredPhotoView)
        self.clipsToBounds = true
    }
    
    func configure(withImageName imageName: String, aspect ratio: CGFloat = 1) {
        let image = UIImage(named: imageName)
        featuredPhotoView.image = image
        blurPhoto.image = image
        guard image != nil else {return}
        // Vertical Image
        if image!.size.width / image!.size.height < ratio { // width is x greater than height, >1: more tolerant into landscape <1: more tolerant to portrait
            featuredPhotoView.contentMode = .scaleAspectFill
        // Horizontal Image
        }else {
            featuredPhotoView.contentMode = .scaleAspectFit
        }
    }
    func configure(withLabeldImage labeledImage: LabeledImage, viewSize: CGSize) {
        let image = UIImage(named: labeledImage.imageName)
        featuredPhotoView.contentMode = .scaleAspectFit
        blurPhoto.image = image

        if let ca = labeledImage.shapes?.filter({$0.label == .CA}).first{
            let caImage = image?.crop(with: ca.rect)
            featuredPhotoView.image = caImage
        }else {
            featuredPhotoView.image = image
        }
    }
}

extension UIImage {
    func blurredImage(with context: CIContext, radius: CGFloat, atRect: CGRect) -> UIImage? {
        guard let ciImg = CIImage(image: self) else { return nil }

        let cropedCiImg = ciImg.cropped(to: atRect)
        let blur = CIFilter(name: "CIGaussianBlur")
        blur?.setValue(cropedCiImg, forKey: kCIInputImageKey)
        blur?.setValue(radius, forKey: kCIInputRadiusKey)
        
        if let ciImgWithBlurredRect = blur?.outputImage?.composited(over: ciImg),
           let outputImg = context.createCGImage(ciImgWithBlurredRect, from: ciImgWithBlurredRect.extent) {
            return UIImage(cgImage: outputImg)
        }
        return nil
    }
}

extension MammalType {
    var backgroundColor : UIColor {
        switch self {
        case .lion:
            return #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
        default:
            return #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        }
    }
}
extension UIImage {
    func scalePreservingAspectRatio(targetSize: CGSize) -> UIImage {
        // Determine the scale factor that preserves aspect ratio
        let widthRatio = targetSize.width / size.width
        let heightRatio = targetSize.height / size.height
        
        let scaleFactor = min(widthRatio, heightRatio)
        
        // Compute the new image size that preserves aspect ratio
        let scaledImageSize = CGSize(
            width: size.width * scaleFactor,
            height: size.height * scaleFactor
        )

        // Draw and return the resized UIImage
        let renderer = UIGraphicsImageRenderer(
            size: scaledImageSize
        )

        let scaledImage = renderer.image { _ in
            self.draw(in: CGRect(
                origin: .zero,
                size: scaledImageSize
            ))
        }
        
        return scaledImage
    }
}
