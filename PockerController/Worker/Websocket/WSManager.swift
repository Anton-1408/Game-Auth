import Foundation

class WSManager {
    internal var webSocketTask: URLSessionWebSocketTask?
    
    internal var gameId: String?
    internal var userId: String?
    
    private static var instance: WSManager?

    private init() {}
    
    public static func getInstance() -> WSManager {
        if (instance == nil) {
            instance = WSManager()
        }
            
        return instance!
    }
    
    public func connect() {
        if let url = URL(string: "wss://ТУТ_ВАШ_АДРЕС") {
            webSocketTask = URLSession(configuration: .default).webSocketTask(with: url)
        
            webSocketTask?.resume()
        }
    }
    
    public func disconnect() {
        webSocketTask?.cancel()
    }
}
