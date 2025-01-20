//
//  View+dynamicSheet.swift
//  DynamicSheet
//
//  Created by Vlad V on 18.01.2025.
//

import SwiftUI

// MARK: - View+dynamicSheet

extension View {
	public func dynamicSheet<SheetView: View>(
		isPresented: Binding<Bool>,
		backgroundColor: Color? = nil,
		@ViewBuilder sheetView: @escaping () -> SheetView,
		onDismiss: (() -> Void)? = nil
	) -> some View {
		return self
			.background(
				DynamicSheetHelper(
					sheetView: sheetView(),
					showSheet: isPresented,
					backgroundColor: backgroundColor,
					onDismiss: onDismiss
				)
			)
	}
}

// MARK: - DismissDynamicSheetKey

struct DismissDynamicSheetKey: @preconcurrency EnvironmentKey {
	@MainActor public static let defaultValue: (() -> Void)? = nil
}

// MARK: - EnvironmentValues+dismissDynamicSheet

extension EnvironmentValues {
	public var dismissDynamicSheet: (() -> Void)? {
		get { self[DismissDynamicSheetKey.self] }
		set { self[DismissDynamicSheetKey.self] = newValue }
	}
}
