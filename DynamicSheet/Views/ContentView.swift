//
//  ContentView.swift
//  DynamicSheet
//
//  Created by Vlad V on 18.01.2025.
//

import SwiftUI

struct ContentView: View {
	@State private var firstSheetIsPresented = false

    var body: some View {
        VStack {
			Button("First Sheet") {
				firstSheetIsPresented = true
			}
        }
        .padding()
		.dynamicSheet(showSheet: $firstSheetIsPresented) {
			Text("Hello")
				.font(.largeTitle)
		} onDismiss: {
			print("Did dismiss")
		}
    }
}

#Preview {
    ContentView()
}
