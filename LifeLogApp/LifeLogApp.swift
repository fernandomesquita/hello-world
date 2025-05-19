import SwiftUI
import CoreLocation

struct Entry: Identifiable {
    let id = UUID()
    let text: String
    let date: Date
    let latitude: Double
    let longitude: Double
}

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let manager = CLLocationManager()
    @Published var location: CLLocation? = nil

    override init() {
        super.init()
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.last
    }
}

struct ContentView: View {
    @State private var entryText: String = ""
    @State private var entries: [Entry] = []
    @ObservedObject private var locationManager = LocationManager()

    var body: some View {
        NavigationView {
            VStack {
                TextField("Digite algo", text: $entryText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                Button("Salvar Entrada") {
                    let text = entryText
                    entryText = ""
                    let date = Date()
                    let coord = locationManager.location?.coordinate
                    let entry = Entry(text: text, date: date,
                                      latitude: coord?.latitude ?? 0.0,
                                      longitude: coord?.longitude ?? 0.0)
                    entries.append(entry)
                }
                .padding()

                List(entries) { entry in
                    VStack(alignment: .leading) {
                        Text(entry.text.isEmpty ? "(sem texto)" : entry.text)
                        Text("\(entry.date, formatter: dateFormatter)")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        Text("Lat: \(entry.latitude), Lon: \(entry.longitude)")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }
            }
            .navigationTitle("Life Log")
        }
    }
}

private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    return formatter
}()

@main
struct LifeLogApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
