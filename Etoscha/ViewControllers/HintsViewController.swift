//
//  HIntsViewController.swift
//  Etoscha
//
//  Created by Björn Roxin on 03.07.21.
//

import UIKit
import FirebaseAnalytics

class HintsViewController: UIViewController {
    
    private var collectionView: UICollectionView?

    private var hints : [String] {
        let completeString = getHints()
        return completeString.components(separatedBy: "&")
    }
    private var hintHeadings : [String] {
        let completeString = getHintTitles()
        return completeString.components(separatedBy: "&")
    }
    private var images : [String] {
        return ["ItsAllAboutTiming","LessIsMore","CalmDown","ThinkOneStepAhead"]
    }
    private var selectedCard : Int? {
        didSet{
            DispatchQueue.main.async {
                self.collectionView?.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDefaultNavBar()
        addSingleTitleToNavBar(title: getTitle())
        view.backgroundColor = Appearance.backgroundColor
        let layout = createCompositionalLayout()
        collectionView = UICollectionView(frame: self.view.safeAreaLayoutGuide.layoutFrame, collectionViewLayout: layout)
        collectionView?.backgroundColor = Appearance.backgroundColor
        collectionView?.register(CardCollectionItem.self, forCellWithReuseIdentifier: CardCollectionItem.reuseIdentifer)
        collectionView?.register(HintsCollectionViewCell.self, forCellWithReuseIdentifier: HintsCollectionViewCell.reuseIdentifer)
        collectionView?.reloadData()
        collectionView?.dataSource = self
        collectionView?.delegate = self
        collectionView?.isUserInteractionEnabled = true
        view.addSubview(collectionView ??  UICollectionView())
    }
    
    
    private func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (sectionNumber, env) -> NSCollectionLayoutSection? in
            return self.firstLayoutSection()
        }
    }
    
    private func firstLayoutSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets.bottom = UICardsViewController.spaceBetween
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(0.45))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = .init(top: 0, leading: UICardsViewController.spaceLeft, bottom: 0, trailing: UICardsViewController.spaceRight)
       
        let section = NSCollectionLayoutSection(group: group)
        //section.orthogonalScrollingBehavior = .continuous// groupPaging
        
        return section
    }

}

extension HintsViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hints.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // View as HintCollectionViewCell
        if indexPath.row == selectedCard{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HintsCollectionViewCell.reuseIdentifer, for: indexPath) as! HintsCollectionViewCell
            cell.configure(title: hintHeadings[indexPath.row], text: hints[indexPath.row])
            return cell
        }
        //View as Card
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardCollectionItem.reuseIdentifer, for: indexPath) as! CardCollectionItem
            cell.configure(withImageName: images[indexPath.row], title: hintHeadings[indexPath.row], asSmallCard: false)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var cardType = CardType.big
        if indexPath.section == 1 {
            cardType = CardType.small
        }
        Analytics.logEvent(MyAnalyticsEvents.pressedCard.rawValue, parameters: [MyAnalyticsParameters.cardType.rawValue: cardType.rawValue])
        if indexPath.row == selectedCard{
            selectedCard = nil
        }else {
            selectedCard = indexPath.row
        }
    }
    
}


extension HintsViewController {
    private func getHints()-> String {
        return NSLocalizedString(EtoshaViews.gameDriveHintsView.rawValue+"_hints", tableName: "Texts", bundle: .main, value: "NO text found", comment: "Facts")
    }
    private func getHintTitles()-> String {
        return NSLocalizedString(EtoshaViews.gameDriveHintsView.rawValue+"_hintTitles", tableName: "Texts", bundle: .main, value: "NO text found", comment: "Facts")
    }
    private func getTitle()-> String {
        return NSLocalizedString(EtoshaViews.gameDriveHintsView.rawValue+"_title", tableName: "Texts", bundle: .main, value: "NO text found", comment: "Facts")
    }
}
