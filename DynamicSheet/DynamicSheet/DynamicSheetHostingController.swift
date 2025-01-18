//
//  DynamicSheetHostingController.swift
//  DynamicSheet
//
//  Created by Vlad V on 18.01.2025.
//

import SwiftUI

class DynamicSheetHostingController<Content: View>: UIHostingController<Content> {
	private var heightConstraint: NSLayoutConstraint?

	override func viewDidLoad() {
		super.viewDidLoad()
		view.layer.cornerRadius = 20
	}

	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()

		if let presentationController = presentationController as? UISheetPresentationController {
			let targetSize = CGSize(width: view.bounds.width, height: UIView.layoutFittingCompressedSize.height)
			let fittingSize = view.systemLayoutSizeFitting(targetSize)

			preferredContentSize = fittingSize

			presentationController.detents = [
				._detent(withIdentifier: UUID().uuidString, constant: fittingSize.height)
			]

			presentationController.prefersGrabberVisible = true
		}
	}
}

