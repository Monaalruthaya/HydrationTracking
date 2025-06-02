import SwiftUI

struct NotificationSettingsView: View {
    @EnvironmentObject var settings: UserSettings
    @State private var selectedInterval: Int = 15
  //  @Published var intervalMinutes: Int = 15
    @State private var navigateToTracker = false

    let intervals = [15, 30, 60, 90, 120, 180, 240, 300]

    var body: some View {
        VStack(alignment: .leading, spacing: 30) {
            Text("Notification Preferences")
                .font(.system(size: 25, weight: .bold))

            VStack(alignment: .leading, spacing: 8) {
                Text("The start and End hour")
                    .font(.system(size: 20, weight: .semibold))

                Text("Specify the start and end date to receive the notifications")
                    .font(.system(size: 17))
                    .foregroundColor(.gray)

                VStack(spacing: 0) {
                    HStack {
                        Text("Start hour")
                            .font(.system(size: 20))
                        Spacer()
                        DatePicker("", selection: $settings.startHour, displayedComponents: .hourAndMinute)
                            .labelsHidden()
                            .frame(width: 120)
                    }
                    .padding()

                    Divider()

                    HStack {
                        Text("End hour")
                            .font(.system(size: 20))
                        Spacer()
                        DatePicker("", selection: $settings.endHour, displayedComponents: .hourAndMinute)
                            .labelsHidden()
                            .frame(width: 120)
                    }
                    .padding()
                }
                .background(Color(UIColor.systemGray6))
                .cornerRadius(10)
            }

            VStack(alignment: .leading, spacing: 8) {
                Text("Notification interval")
                    .font(.system(size: 20, weight: .semibold))

                Text("How often would you like to receive notifications within the specified time interval")
                    .font(.system(size: 17))
                    .foregroundColor(.gray)
              //  Spacer()


                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 4), spacing: 12) {
                    ForEach(intervals, id: \.self) { interval in
                        Button(action: {
                            selectedInterval = interval
                            settings.intervalMinutes = interval
                        }) {
                            Text(interval >= 60 ? "\(interval / 60)\nHours" : "\(interval)\nMins")
                                .font(.system(size: 16))
                                .multilineTextAlignment(.center)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 20)
                                .background(selectedInterval == interval ? Color(hex: "#32ADE6") : Color(UIColor.systemGray6))
                                .foregroundColor(selectedInterval == interval ? .white : .black)
                                .cornerRadius(16)
                        }
                    }
                }

            }

            Spacer()

            Button(action: {
                navigateToTracker = true
            }) {
                Text("Start")
                    .frame(maxWidth: .infinity)
                    .font(.system(size: 22))
                    .frame(height: 52)
                    .background(Color(hex: "#32ADE6"))
                    .foregroundColor(.white)
                    .cornerRadius(14)
            }
            .padding(.bottom, 16)

        }
        .padding(.horizontal, 24)
        .padding(.top, 32)
        .navigationDestination(isPresented: $navigateToTracker) {
            WaterTrackerView()
        }
    }
}



#Preview {
    NotificationSettingsView()
        .environmentObject(UserSettings())
}
