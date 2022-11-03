//
//  ViewController.swift
//  selfSizingIssue
//
//  Created by Roi Mulia on 02/11/2022.
//

import UIKit

class ViewController: UIViewController {

	@IBOutlet weak var containerView: UIView!
	
	@IBOutlet weak var myContainerView: UIView!

	override func viewDidLoad() {
        super.viewDidLoad()

		let items: [String] = [
			"this", "Sunday", "is", "Monday", "example", "Tuesday", "for", "Wednesday", "some", "Thursday", "data", "Friday", "in", "Saturday"
		]

        let collectionView = AdaptiveTitleCollectionView()
		let myCollectionView = DonMagTitleCollectionView()

		collectionView.items = items
		myCollectionView.items = items

        containerView.addSubview(collectionView)
        collectionView.bindMarginsToSuperview()
		
		myContainerView.addSubview(myCollectionView)
		myCollectionView.bindMarginsToSuperview()
        
        // Do any additional setup after loading the view.
    }


}

public extension UIViewController {
    func addAsChildTo(parentVc: UIViewController, inside container: UIView, insets: UIEdgeInsets = .zero) {
        parentVc.addChild(self)
        self.view.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(self.view)
        
        view.bindMarginsToSuperview(insets: insets)
        didMove(toParent: parentVc)
    }
    
}

extension UIView {
    func bindMarginsToSuperview(insets: UIEdgeInsets = .zero) {
        guard let superview = self.superview else {
            print("Error! `superview` was nil – call `addSubview(view: UIView)` before calling `bindFrameToSuperviewBounds()` to fix this.")
            return
        }
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: insets.left).isActive = true
        self.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: insets.right).isActive = true
        self.topAnchor.constraint(equalTo: superview.topAnchor, constant: insets.top).isActive = true
        self.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: insets.bottom).isActive = true
    }
}

class MyLabelCell: UICollectionViewCell {
	
	let myLabel: UILabel = UILabel()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		commonInit()
	}
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		commonInit()
	}
	func commonInit() {
		myLabel.textColor = .black
		myLabel.textAlignment = .center
		myLabel.font = .systemFont(ofSize: 16.0)
		myLabel.translatesAutoresizingMaskIntoConstraints = false
		contentView.addSubview(myLabel)
		
		let g = contentView
		NSLayoutConstraint.activate([
			
			myLabel.topAnchor.constraint(equalTo: g.topAnchor, constant: 5.0),
			myLabel.leadingAnchor.constraint(equalTo: g.leadingAnchor, constant: 5.0),
			myLabel.trailingAnchor.constraint(equalTo: g.trailingAnchor, constant: -5.0),
			myLabel.bottomAnchor.constraint(equalTo: g.bottomAnchor, constant: -5.0),

			
		])
		
		myLabel.backgroundColor = .green
		contentView.backgroundColor = .red
	}
	
	
	override var isSelected: Bool {
		didSet {
			myLabel.backgroundColor = isSelected ? .yellow : .green
		}
	}
	
}

class MyTitleCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
	
	var items = ["this", "Monday", "is", "example", "Tuesday", "for", "some", "Wednesday", "data", "in", "Thursday", "array"]
	
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
		
		register(UINib(nibName: "SampleCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SampleCollectionViewCell")
		register(MyLabelCell.self, forCellWithReuseIdentifier: "MyCell")
		
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

		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SampleCollectionViewCell", for: indexPath) as! SampleCollectionViewCell
		
		let item = items[indexPath.item]
		cell.myLabel.text = item

		return cell
		
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		// do something on cell selection?
	}
	
}



