//
//  DynamicSheetHostingController.swift
//  DynamicSheet
//
//  Created by Vlad V on 18.01.2025.
//

import SwiftUI
struct DynamicSheetHelper<SheetView: View>: UIViewControllerRepresentable {
	// MARK: - Dependences

	@Binding private var showSheet: Bool

	private let sheetView: SheetView
	private let backgroundColor: Color?
	private let onDismiss: (() -> Void)?

	// MARK: Private Properties

	private let controller = UIViewController()

	// MARK: - Init

	init(
		sheetView: SheetView,
		showSheet: Binding<Bool>,
		backgroundColor: Color? = nil,
		onDismiss: (() -> Void)? = nil
	) {
		self.sheetView = sheetView
		self._showSheet = showSheet
		self.backgroundColor = backgroundColor
		self.onDismiss = onDismiss
	}

	// MARK: Methods

	func makeUIViewController(context: Context) -> some UIViewController {
		controller.view.backgroundColor = .clear
		return controller
	}

	func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
		if showSheet {
			let sheetController = DynamicSheetHostingController(
				rootView: sheetView
					.environment(\.dismissDynamicSheet, { showSheet = false })
					.ignoresSafeArea(),
				bgColor: backgroundColor
			)
			sheetController.presentationController?.delegate = context.coordinator

			if uiViewController.presentedViewController == nil {
				uiViewController.present(sheetController, animated: true)
				context.coordinator.sheetController = sheetController
			}
		} else {
			if context.coordinator.sheetController != nil {
				context.coordinator.sheetController = nil
				uiViewController.dismiss(animated: true) {
					self.onDismiss?()
				}
			}
		}
	}

	func makeCoordinator() -> Coordinator {
		return Coordinator(self)
	}

	// MARK: Coordinator

	class Coordinator: NSObject, UISheetPresentationControllerDelegate {
		var parent: DynamicSheetHelper
		var sheetController: UIViewController?

		init(_ parent: DynamicSheetHelper) {
			self.parent = parent
		}

		func presentationControllerWillDismiss(_ presentationController: UIPresentationController) {
			parent.showSheet = false
		}

		func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
			sheetController = nil
		}
	}
}
