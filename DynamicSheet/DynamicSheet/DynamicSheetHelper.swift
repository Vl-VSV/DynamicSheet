//
//  DynamicSheetHelper.swift
//  DynamicSheet
//
//  Created by Vlad V on 18.01.2025.
//

import SwiftUI

struct DynamicSheetHelper<SheetView: View>: UIViewControllerRepresentable {
	// MARK: - Dependences

	let sheetView: SheetView
	@Binding var showSheet: Bool
	let onDismiss: (() -> Void)?

	// MARK: Private Properties

	private let controller = UIViewController()

	// MARK: - Init

	init(sheetView: SheetView, showSheet: Binding<Bool>, onDismiss: (() -> Void)? = nil) {
		self.sheetView = sheetView
		self._showSheet = showSheet
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
					.padding(.bottom, context.coordinator.getBottomSafeAreaInset()) // Добавление паддинга для девайсов с TouchId
					.padding(.top, context.coordinator.getTopPadding()) // Уменьшение паддинга для девайсов с FaceId
			)
			sheetController.presentationController?.delegate = context.coordinator

			if uiViewController.presentedViewController == nil {
				uiViewController.present(sheetController, animated: true)
				context.coordinator.sheetController = sheetController
			}
		} else {
			if context.coordinator.sheetController != nil {
				context.coordinator.sheetController = nil
				uiViewController.dismiss(animated: true)
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
			parent.onDismiss?()
			sheetController = nil
		}

		func getBottomSafeAreaInset() -> CGFloat {
			UIApplication.shared.bottomSafeAreaInset == 0 ? 24 : 0
		}

		func getTopPadding() -> CGFloat {
			UIApplication.shared.bottomSafeAreaInset == 0 ? 0 : -12
		}
	}
}

// MARK: - UIApplication+bottomSafeAreaInset

fileprivate extension UIApplication {
	var bottomSafeAreaInset: CGFloat {
		guard let windowScene = connectedScenes.first as? UIWindowScene else {
			return 0
		}

		guard let window = windowScene.windows.first else {
			return 0
		}

		return window.safeAreaInsets.bottom
	}
}
