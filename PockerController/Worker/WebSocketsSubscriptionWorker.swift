//
//  WebSocketsSubscriptionWorker.swift
//  PockerController
//
//  Created by Anton Votinov on 11.03.2023.
//

import Foundation
import SocketIO

final class WebSocketsSubscriptionWorker: ObservableObject {
    private let webSocket = WebSocketManager.getInstance()
    private let webSocketTrigger = WebSocketTrigger()
    private let store = Store.getStore()

    @Published var isGameLoaded = false
    
    public func subscribe() {
        self.connect()
        self.updateGame()
        self.wtUpdate()
        self.winner()
        self.actionPerfomed()
        self.newHand()
        self.timer()
        self.cardCheck()
        self.notInvated()
        self.notFound()
        self.scanCardForUser()
        self.scanCommunityCard()
        self.roomResume()
        self.roomPause()
        
        webSocket.connect()
    }
    
    public func unSubscribe() {}
    
    private func connect() {
        webSocket.socket.on(EventOfListen.connect) {data, acc in
            self.webSocketTrigger.takeTableCheck(isWaiting: true)
            self.webSocketTrigger.takeTableCheck(isWaiting: false)
        }
    }
    
    private func updateGame() {
        webSocket.socket.on(EventOfListen.updateGame) { data, acc in
            do {
                let response = data[0] as? [String: Any];
                
                let game = try JSONDecoder().decode(GameData.self, from: JSONSerialization.data(withJSONObject: response?["game"] ?? []))
                let playersForRound = game.getPlayersForRound(game.runninground)
                
                
                self.store.dispath(.setProcessGame(game))
                self.store.dispath(.setWaitingPlayers(game.waitingPlayers))
                self.store.dispath(.setPlayers(playersForRound))
                
                if (!game.gamestart){
                    self.store.dispath(.resetTimer)
                    self.store.dispath(.setLastAction(nil))
                    self.store.dispath(.setIsGamePause(false))
                }
            } catch {
                print("error", error)
            }
            
            self.isGameLoaded = true
        }
    }
    
    private func wtUpdate() {
        webSocket.socket.on(EventOfListen.wtUpdate) {data, acc in
            do {
                let response = data[0] as? [String: Any];
                
                let game = try JSONDecoder().decode(GameData.self, from: JSONSerialization.data(withJSONObject: response?["game"] ?? []))
                
                print("game", game.id)
            } catch {
                print("error", error)
            }
            self.isGameLoaded = true
        }
    }

    private func winner() {
        webSocket.socket.on(EventOfListen.winner) {data, acc in
            print("winner")
        }
    }

    private func actionPerfomed() {
        webSocket.socket.on(EventOfListen.actionPerformed) {data, acc in
            print("actionPerformed")
        }
    }

    private func newHand() {
        webSocket.socket.on(EventOfListen.newHand) {data, acc in
            print("newHand")
        }
    }
    
    private func timer() {
        webSocket.socket.on(EventOfListen.timer) {data, acc in
            print("timer")
        }
    }
    
    private func cardCheck() {
        webSocket.socket.on(EventOfListen.cardCheck) {data, acc in
            print("cardCheck")
        }
    }
    
    private func notInvated() {
        webSocket.socket.on(EventOfListen.notInvited) {data, acc in
            print("notInvited")
        }
    }
    
    private func notFound() {
        webSocket.socket.on(EventOfListen.notFound) {data, acc in
            print("notFound")
            self.isGameLoaded = true
        }
    }
    
    private func scanCardForUser() {
        webSocket.socket.on(EventOfListen.scanCardForUser) {data, acc in
            print("scanCardForUser")
        }
    }
    
    private func scanCommunityCard() {
        webSocket.socket.on(EventOfListen.scanCommunityCard) {data, acc in
            print("scanCommunityCard")
        }
    }
    
    private func roomResume() {
        webSocket.socket.on(EventOfListen.roomResume) {data, acc in
            print("roomResume")
        }
    }
    
    private func roomPause() {
        webSocket.socket.on(EventOfListen.roomPaused) {data, acc in
            print("roomPause")
        }
    }
}
