//
//  ContentView.swift
//  DynamicSheet
//
//  Created by Vlad V on 18.01.2025.
//

import SwiftUI

struct ContentView: View {
	@State private var firstSheetIsPresented = false
	@State private var secondSheetIsPresented = false
	@State private var thirdSheetIsPresented = false
	@State private var fourthSheetIsPresented = false

	var body: some View {
		VStack(spacing: 24) {
			// Кнопки для открытия sheet
			Button(action: { firstSheetIsPresented = true }) {
				Text("First Sheet")
					.sheetButtonStyle(backgroundColor: .green)
			}

			Button(action: { secondSheetIsPresented = true }) {
				Text("Second Sheet")
					.sheetButtonStyle(backgroundColor: .blue)
			}

			Button(action: { thirdSheetIsPresented = true }) {
				Text("Third Sheet")
					.sheetButtonStyle(backgroundColor: .orange)
			}

			Button(action: { fourthSheetIsPresented = true }) {
				Text("Fourth Sheet")
					.sheetButtonStyle(backgroundColor: .purple)
			}
		}
		.padding()
		// Привязка sheet к состоянию и отображение
		.dynamicSheet(
			showSheet: $firstSheetIsPresented,
			backgroundColor: .green
		) {
			FirstSheetView()
		}
		.dynamicSheet(showSheet: $secondSheetIsPresented) {
			SecondSheetView()
		}
		.dynamicSheet(showSheet: $thirdSheetIsPresented) {
			ThirdSheetView()
		}
		.dynamicSheet(showSheet: $fourthSheetIsPresented) {
			FourthSheetView()
		} onDismiss: {
			print("Sheet dismissed")
		}
	}
}

// MARK: - First Sheet

/// Простой sheet с текстом
struct FirstSheetView: View {
	var body: some View {
		VStack {
			Text("Hello")
				.font(.largeTitle)
				.padding()
		}
	}
}

// MARK: - Second Sheet

/// Sheet с вопросом и двумя кнопками
struct SecondSheetView: View {
	var body: some View {
		VStack(spacing: 16) {
			Text("Do you really want to do something?")
				.font(.title.bold())
				.multilineTextAlignment(.center)
				.padding(.horizontal, 24)

			HStack(spacing: 16) {
				Button(action: {}) {
					Text("Yes")
						.actionButtonStyle(backgroundColor: .blue)
				}

				Button(action: {}) {
					Text("No")
						.actionButtonStyle(backgroundColor: .red)
				}
			}
		}
		.padding()
	}
}

// MARK: - Third Sheet

/// Sheet с прокручиваемым списком
struct ThirdSheetView: View {
	var body: some View {
		ScrollView {
			VStack(alignment: .leading, spacing: 8) {
				ForEach(0..<100) { index in
					Text("Hello \(index)")
						.font(.title2)
						.padding(.vertical, 4)
				}
			}
			.frame(maxWidth: .infinity)
			.padding()
		}
		.background(Color.orange.opacity(0.1))
	}
}

// MARK: - Fourth Sheet

/// Sheet с кнопкой для закрытия
struct FourthSheetView: View {
	@Environment(\.dismissDynamicSheet) private var dismiss

	var body: some View {
		VStack {
			Button(action: { dismiss?() }) {
				Text("Dismiss")
					.font(.title)
					.padding()
					.background(Color.purple)
					.foregroundColor(.white)
					.cornerRadius(10)
			}
		}
		.padding()
	}
}

// MARK: - Button Styles

extension Text {
	/// Стиль для кнопок на главном экране
	func sheetButtonStyle(backgroundColor: Color) -> some View {
		self
			.font(.title2.bold())
			.foregroundColor(.white)
			.padding()
			.frame(maxWidth: .infinity)
			.background(backgroundColor)
			.cornerRadius(10)
	}

	/// Стиль для кнопок внутри sheet
	func actionButtonStyle(backgroundColor: Color) -> some View {
		self
			.font(.title3.bold())
			.foregroundColor(.white)
			.padding()
			.frame(maxWidth: .infinity)
			.background(backgroundColor)
			.cornerRadius(8)
	}
}

// MARK: - Preview

#Preview {
	ContentView()
}
