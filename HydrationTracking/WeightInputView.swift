import SwiftUI

struct WeightInputView: View {
    @EnvironmentObject var settings: UserSettings
    @State private var weightText: String = ""
    @State private var navigateNext = false

    var body: some View {
        VStack {
            Spacer()

            VStack(alignment: .leading, spacing: 0) {
                Image(systemName: "drop.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 60)
                    .foregroundColor(Color(hex: "#32ADE6"))
                    .padding(.bottom, 10)

                Text("Hydrate")
                    .font(.system(size: 30, weight: .semibold))
                    .padding(.bottom, 8)

                Text("Start with Hydrate to record and track your water intake daily based on your needs and stay hydrated")
                    .font(.system(size: 18))
                    .foregroundColor(.gray)
                    .padding(.bottom, 24)

                HStack {
                    Text("Body weight")
                        .foregroundColor(.primary)
                        .font(.system(size: 20))

                    Spacer()

                    TextField("Value", text: $weightText)
                        .keyboardType(.decimalPad)
                        .multilineTextAlignment(.leading)
                        .font(.system(size: 20))
                }
                .padding(.horizontal)
                .frame(height: 52)
                .background(Color(UIColor.systemGray6))
                .cornerRadius(14)
            }
            .padding(.horizontal, 25)
            .frame(maxWidth: .infinity)
            .frame(height: 400, alignment: .center)

            Spacer()

            Button(action: {
                if let value = Double(weightText) {
                    settings.weight = value
                    navigateNext = true
                }
            }) {
                Text("Next")
                    .frame(maxWidth: .infinity)
                    .font(.system(size: 20))
                    .frame(height: 52)
                    .background(Color(hex: "#32ADE6"))
                    .foregroundColor(.white)
                    .cornerRadius(14)
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 8)

            NavigationLink(destination: NotificationSettingsView(), isActive: $navigateNext) {
                EmptyView()
            }
        }
        .frame(maxHeight: .infinity)
        .padding(.top, 30)
    }
}

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        _ = scanner.scanString("#")
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
        let r = Double((rgb >> 16) & 0xFF) / 255
        let g = Double((rgb >> 8) & 0xFF) / 255
        let b = Double(rgb & 0xFF) / 255
        self.init(red: r, green: g, blue: b)
    }
}

#Preview {
    WeightInputView()
        .environmentObject(UserSettings())
}
