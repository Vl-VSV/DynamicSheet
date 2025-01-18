//
//  DynamicSheetHostingController.swift
//  DynamicSheet
//
//  Created by Vlad V on 18.01.2025.
//

import SwiftUI
import DynamicSheetDetent

class DynamicSheetHostingController<Content: View>: UIHostingController<Content> {
	private var bgColor: Color?

	init(rootView: Content, bgColor: Color? = nil) {
		self.bgColor = bgColor

		super.init(rootView: rootView)
	}

	required dynamic init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		view.layer.cornerRadius = 20
		view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]

		if let bgColor {
			view.backgroundColor = UIColor(bgColor)
		}
	}

	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()

		if let presentationController = presentationController as? UISheetPresentationController {
			let fittingSize = view.systemLayoutSizeFitting(view.frame.size)

			preferredContentSize = fittingSize

			presentationController.detents = [
				._detent(withIdentifier: UUID().uuidString, constant: fittingSize.height)
			]

			presentationController.prefersGrabberVisible = true
		}
	}
}
