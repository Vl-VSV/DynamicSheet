# DynamicSheet

`DynamicSheet` — это SwiftUI-компонент для отображения модальных окон (sheet) с авто-подсчетом высты. Компонент автоматически адаптируется под содержимое

## Реализация

Подробно про реализацию и её особенности можно прочить в этой [статье]()

## Требования 

- **iOS 15+**

## Особенности

- Высота sheet автоматически подстраивается под содержимое.
- При использовании ScrollView в sheet, он будет растягиваться на весь экран
- Нужно использовать `@Environment(\.dismissDynamicSheet)` для закрытия sheet

## Использование

### Базовый пример

```swift
import SwiftUI

struct ContentView: View {
    @State private var showSheet = false

    var body: some View {
        Button("Show Sheet") {
            showSheet.toggle()
        }
        .dynamicSheet(showSheet: $showSheet) {
            Text("Hello, Sheet!")
        }
    }
}
```

### С кнопкой закрытия

Особенностью является то, что вместо, `dismiss`, нужно использовать `dismissDynamicSheet`

```swift
.dynamicSheet(showSheet: $showSheet) {
	SheetWithDismissButton()
}
```

```swift
struct SheetWithDismissButton: View {
    @Environment(\.dismissDynamicSheet) private var dismiss

    var body: some View {
        VStack {
            Text("This is a sheet with a dismiss button")
                .font(.title)
                .padding()

            Button("Dismiss") {
                dismiss?() // Закрывает sheet
            }
        }
    }
}
```
