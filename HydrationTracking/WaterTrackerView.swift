import SwiftUI

struct WaterTrackerView: View {
    @EnvironmentObject var settings: UserSettings

    var target: Double {
        settings.dailyWaterTarget
    }

    var progress: Double {
        min(settings.currentIntake / target, 1.0)
    }

    var statusSymbol: String {
        switch progress {
        case 0..<0.2: return "zzz"
        case 0.2..<0.5: return "tortoise.fill"
        case 0.5..<0.9: return "hare.fill"
        default: return "hands.clap.fill"
        }
    }

    var statusColor: Color {
        progress >= 1.0 ? .green : .primary
    }

    var body: some View {
        VStack(spacing: 24) {
            Text("Today's Water Intake")
                .font(.title3)
                .fontWeight(.semibold)

            Text(String(format: "%.1f liter / %.1f liter", settings.currentIntake, target))
                .font(.title2)
                .foregroundColor(statusColor)

            ZStack {
                Circle()
                    .stroke(Color.gray.opacity(0.2), lineWidth: 22)

                Circle()
                    .trim(from: 0.0, to: progress)
                    .stroke(Color(hex: "#32ADE6"), style: StrokeStyle(lineWidth: 22, lineCap: .round))
                    .rotationEffect(.degrees(-90))
                    .animation(.easeInOut(duration: 0.5), value: progress)

                Image(systemName: statusSymbol)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 48, height: 48)
                    .foregroundColor(.yellow)
            }
            .frame(width: 220, height: 220)

            Text(String(format: "%.1f L", settings.currentIntake))
                .font(.title)

            HStack(spacing: 40) {
                Button(action: {
                    settings.currentIntake = max(0, settings.currentIntake - 0.1)
                }) {
                    Text("−")
                        .font(.largeTitle)
                        .frame(width: 60, height: 60)
                        .background(Color(.systemGray6))
                        .clipShape(Circle())
                }

                Button(action: {
                    if settings.currentIntake < target {
                        settings.currentIntake = min(settings.currentIntake + 0.1, target)
                    }                }) {
                    Text("+")
                        .font(.largeTitle)
                        .frame(width: 60, height: 60)
                        .background(Color(.systemGray6))
                        .clipShape(Circle())
                }
            }
        }
        .padding()
    }
}


#Preview {
    WaterTrackerView()
        .environmentObject(UserSettings())
}
