//
//  DynamicSheet.swift
//  DynamicSheet
//
//  Created by Vlad V on 18.01.2025.
//

import SwiftUI

// MARK: - View+dynamicSheet

extension View {
	func dynamicSheet<SheetView: View>(
		showSheet: Binding<Bool>,
		backgroundColor: Color? = nil,
		@ViewBuilder sheetView: @escaping () -> SheetView,
		onDismiss: (() -> Void)? = nil
	) -> some View {
		return self
			.background(
				DynamicSheetHelper(
					sheetView: sheetView(),
					showSheet: showSheet,
					backgroundColor: backgroundColor,
					onDismiss: onDismiss
				)
			)
	}
}

// MARK: - DismissDynamicSheetKey

struct DismissDynamicSheetKey: EnvironmentKey {
	static let defaultValue: (() -> Void)? = nil
}

// MARK: - EnvironmentValues+dismissDynamicSheet

extension EnvironmentValues {
	var dismissDynamicSheet: (() -> Void)? {
		get { self[DismissDynamicSheetKey.self] }
		set { self[DismissDynamicSheetKey.self] = newValue }
	}
}
