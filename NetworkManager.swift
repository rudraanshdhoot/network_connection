import Foundation
import Network

class NetworkManager: ObservableObject {
    let monitor = NWPathMonitor()
    let queue = DispatchQueue(label: "NetworkManager")
    @Published var isConnected = true
    
    var imageName: String {
        return isConnected ? "wifi" : "wifi.slash"
    }
    
    var connectionDescription: String {
        if isConnected {
            return "Internet Access ✅"
        } else {
            return "No Internet Access 😔. Make sure WiFi is enabled and try again"
        }
    }
    
    init() {
        monitor.pathUpdateHandler = { path in
            DispatchQueue.main.async {
                self.isConnected = path.status == .satisfied
            }
        }
        
        monitor.start(queue: queue)
    }
}
