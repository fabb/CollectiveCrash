import UIKit

class MyCollectionViewCell: UICollectionViewCell {
	
	let label = UILabel()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		addSubview(label)
		backgroundColor = .green
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError()
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		label.frame = bounds
	}
	
	func setText(_ text: String) {
		label.text = text
	}
	
}
