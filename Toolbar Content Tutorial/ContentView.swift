import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack {
                NavigationLink {
                    StructToolbarItemGroupView()
                } label: {
                    Text("Hello, world!")
                }
            }
            .toolbar {
                HomeToolbar()
            }
            .toolbarColorScheme(.light, for: .navigationBar)
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Home")
            .padding()
        }
    }
}

struct HomeToolbar: ToolbarContent {
    var body: some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            Text("Home")
        }

        ToolbarItem(placement: .principal) {
            Image(systemName: "bus")
        }

        ToolbarItem(placement: .bottomBar) {
            Button("Save") {
                print("delete document")
            }.buttonStyle(.borderedProminent)
        }
    }
}

struct MyView: View {
    @State var maskSize = CGFloat(0)
    @State var pulsate = false

    var body: some View {
        VStack {
            Image(systemName: "trash")
                .resizable()
                .scaleEffect(pulsate ? 1.3 : 1)
                .frame(width: 75, height: 75)
                .animation(.easeInOut(duration: 1.3).repeatForever(autoreverses: true).delay(1), value: pulsate)
                .mask {
                    VStack {
                        Spacer()
                        Rectangle()
                            .opacity(1)
                            .frame(width: 100, height: maskSize)
                        Spacer()
                    }
                }.onAppear {
                    withAnimation(.linear(duration: 0.5)) {
                        maskSize += 100
                    }
                    withAnimation(.linear) {
                        pulsate = true
                    }
                }
        }
    }
}


struct StructToolbarItemGroupView: View {
    @State private var text = ""
    @State private var bold = false
    @State private var italic = false
    @State private var fontSize = 12.0

    var displayFont: Font {
        let font = Font.system(size: CGFloat(fontSize),
                               weight: bold == true ? .bold : .regular)
        return italic == true ? font.italic() : font
    }

    var body: some View {
        TextEditor(text: $text)
            .font(displayFont)
            .toolbar {
                ToolbarItemGroup {
                    Slider(
                        value: $fontSize,
                        in: 8...120,
                        minimumValueLabel:
                            Text("A").font(.system(size: 8)),
                        maximumValueLabel:
                            Text("A").font(.system(size: 16))
                    ) {
                        Text("Font Size (\(Int(fontSize)))")
                    }
                    .frame(width: 100)
                    Toggle(isOn: $bold) {
                        Image(systemName: "bold")
                    }
                    Toggle(isOn: $italic) {
                        Image(systemName: "italic")
                    }
                }
            }
            .navigationTitle("My Note")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDisplayName("home")
    }
}
