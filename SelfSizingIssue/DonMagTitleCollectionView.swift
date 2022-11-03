//
//  DonMagTitleCollectionView.swift
//  SelfSizingIssue
//
//  Created by Don Mag on 11/3/22.
//

import UIKit

class DonMagTitleCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
	
	var items = ["this", "is", "example", "for", "some", "data", "in", "array"]
	
	init() {
		let flowLayout = UICollectionViewFlowLayout()
		
		// use a reasonable estimated size
		//flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
		flowLayout.estimatedItemSize = CGSize(width: 100.0, height: 24.0)
		
		flowLayout.scrollDirection = .horizontal
		
		flowLayout.sectionInset = .init(top: 16, left: 8, bottom: 16, right: 8)
		flowLayout.sectionInsetReference = .fromContentInset
		
		flowLayout.minimumLineSpacing = 5
		flowLayout.minimumInteritemSpacing = 5
		
		super.init(frame: .zero, collectionViewLayout: flowLayout)
		
		register(UINib(nibName: "DonMagSampleCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "DonMagSampleCollectionViewCell")
		
		delegate = self
		dataSource = self
		
		contentInset = .zero
		delaysContentTouches = true
		
		allowsMultipleSelection = false
		
		backgroundColor = .systemOrange
		
		// set first cell as initially selected
		self.selectItem(at: IndexPath(item: 0, section: 0), animated: false, scrollPosition: .left)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return items.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DonMagSampleCollectionViewCell", for: indexPath) as! DonMagSampleCollectionViewCell
		
		let item = items[indexPath.item]
		cell.myLabel.text = item
		
		return cell
		
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		// do something on cell selection?
		print("Selected item at:", indexPath)
	}
	
}


