//
//  CardsViewController.swift
//  Etoscha
//
//  Created by Björn Roxin on 27.05.21.
//

import UIKit
import FirebaseAnalytics

class UICardsViewController: UIViewController
{
    var heading : String?{
        didSet{
            guard heading != nil else {return}
            addSingleTitleToNavBar(title: heading!)
        }
    }
    private var collectionView: UICollectionView?
    private var bigCards : [CardAble]?
    private var smallCards : [CardAble]?
    
    func isCardsEmpty() -> Bool {
        return bigCards == nil  && smallCards == nil
    }
    
    func getCard(for indexpath: IndexPath) -> CardAble?{
        if indexpath.section == 0{
            return bigCards?[indexpath.row]
        }
        if indexpath.section == 1{
            return smallCards?[indexpath.row]
        }
        else {return nil}
    }
    
    func setCards(bigCards : [CardAble]?, smallCards : [CardAble]?) {
        if bigCards != nil {
            self.bigCards = bigCards
        }
        if smallCards != nil {
            self.smallCards = smallCards
        }
        collectionView?.clearsContextBeforeDrawing = true
        DispatchQueue.main.async {
            self.collectionView?.reloadData()
        }
        collectionView?.setNeedsDisplay()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupDefaultNavBar()
        view.backgroundColor = Appearance.backgroundColor
        let layout = createCompositionalLayout()
        collectionView = UICollectionView(frame: self.view.safeAreaLayoutGuide.layoutFrame, collectionViewLayout: layout)
        collectionView?.backgroundColor = Appearance.backgroundColor
        collectionView?.register(CardCollectionItem.self, forCellWithReuseIdentifier: CardCollectionItem.reuseIdentifer)
        collectionView?.reloadData()
        collectionView?.dataSource = self
        collectionView?.delegate = self
        collectionView?.isUserInteractionEnabled = true
        view.addSubview(collectionView ??  UICollectionView())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView?.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
    }
    
    
    private func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        
        return UICollectionViewCompositionalLayout { (sectionNumber, env) -> NSCollectionLayoutSection? in
            
            switch sectionNumber {
            
            case 0: return self.firstLayoutSection()
            case 1: return self.secondLayoutSection()
            default: return self.firstLayoutSection()
            }
        }
    }
    
    private func firstLayoutSection() -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets.bottom = UICardsViewController.spaceBetween
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.28))//.fractionalWidth(0.45))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = .init(top: 0, leading: UICardsViewController.spaceLeft, bottom: 0, trailing: UICardsViewController.spaceRight)
       
        let section = NSCollectionLayoutSection(group: group)
        
        //section.orthogonalScrollingBehavior = .continuous// groupPaging
        
        return section
    }
    
    private func secondLayoutSection() -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 0, leading: 0, bottom: UICardsViewController.spaceBetween, trailing: UICardsViewController.spaceRight)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.18))//.estimated(500))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
       
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets.leading = UICardsViewController.spaceLeft
        
        return section
    }
}
//MARK: - UICollectionViewDataSource Methods
extension UICardsViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch section {
            case 0: return bigCards?.count ?? 0
            case 1: return smallCards?.count ?? 0
            default: return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardCollectionItem.reuseIdentifer, for: indexPath) as! CardCollectionItem
        
        if indexPath.section == 0, bigCards != nil {
            let card = bigCards![indexPath.row]
            cell.configure(withImageName: card.mainImage, title: card.shortName ,asSmallCard: false)
        }
        else if indexPath.section == 1, smallCards != nil {
            let card = smallCards![indexPath.row]
            cell.configure(withImageName: card.mainImage, title: card.shortName ,asSmallCard: true)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var cardType = CardType.big
        if indexPath.section == 1 {
            cardType = CardType.small
        }
        Analytics.logEvent(MyAnalyticsEvents.pressedCard.rawValue, parameters: [MyAnalyticsParameters.cardType.rawValue: cardType.rawValue])
    }
    
}

extension UICardsViewController : UICollectionViewDelegate {
    
}

extension UICardsViewController {
    //MARK: Appearance
    static let spaceLeft : CGFloat = 10
    static let spaceRight : CGFloat  = 10
    static let spaceBetween : CGFloat = 10
}
