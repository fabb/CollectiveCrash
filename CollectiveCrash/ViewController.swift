import UIKit

class ViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

	let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
	var viewModel = ["0"]
	var counter = 0
	
	override func loadView() {
		self.view = collectionView
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		collectionView.delegate = self
		collectionView.dataSource = self
		collectionView.register(MyCollectionViewCell.self, forCellWithReuseIdentifier: "testcell")
		collectionView.register(MyCollectionViewHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "testheader")
		collectionView.backgroundColor = .white
		collectionView.alwaysBounceVertical = true
		collectionView.reloadData()
	}

	@IBAction func addButtonPressed(_ sender: Any) {
		collectionView.performBatchUpdates({
			counter += 1
			viewModel.append("\(counter)")
			collectionView.insertItems(at: [IndexPath(item: counter, section: 0)])
		}, completion: nil)
	}
	
	@IBAction func deleteButtonPressed(_ sender: Any) {
		guard !viewModel.isEmpty else { return }
		collectionView.performBatchUpdates({
			counter -= 1
			viewModel.remove(at: viewModel.count - 1)
			collectionView.deleteItems(at: [IndexPath(item: counter + 1, section: 0)])
		}, completion: nil)
	}
	
	@IBAction func reloadButtonPressed(_ sender: Any) {
		collectionView.reloadData()
	}
	
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 1
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return viewModel.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "testcell", for: indexPath) as! MyCollectionViewCell
		cell.setText(viewModel[indexPath.item])
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
		guard kind == UICollectionElementKindSectionHeader else {
			fatalError()
		}
		
		let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "testheader", for: indexPath) as! MyCollectionViewHeader
		header.setText("my header")
		return header
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: 100, height: 100)
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
		// THIS IS PROBLEMATIC
		guard !viewModel.isEmpty else {
			return CGSize.zero
		}
		
		return CGSize(width: 1, height: 100)
	}
	
}

