////
// 🦠 Corona-Warn-App
//

import UIKit
import OpenCombine

class AddEventTableViewCell: UITableViewCell {

	// MARK: - Overrides

	override func awakeFromNib() {
		super.awakeFromNib()

		isAccessibilityElement = false
		containerView.isAccessibilityElement = true
		containerView.accessibilityTraits = .button
	}

	override func prepareForReuse() {
		super.prepareForReuse()

		subscriptions = []
		cellModel = nil
	}

	// MARK: - Internal

	func configure(cellModel: AddEventCellModel) {
		label.text = cellModel.text
		containerView.accessibilityLabel = cellModel.text

		cellModel.iconImagePublisher
			.assign(to: \.image, on: iconImageView)
			.store(in: &subscriptions)

		cellModel.textColorPublisher
			.assign(to: \.textColor, on: label)
			.store(in: &subscriptions)

		cellModel.accessibilityTraitsPublisher
			.assign(to: \.accessibilityTraits, on: self)
			.store(in: &subscriptions)

		// Retaining cell model so it gets updated
		self.cellModel = cellModel
	}

	// MARK: - Private

	@IBOutlet private weak var containerView: UIView!
	@IBOutlet private weak var iconImageView: UIImageView!
	@IBOutlet private weak var label: ENALabel!

	private var subscriptions = Set<AnyCancellable>()
	private var cellModel: AddEventCellModel?
    
}
