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

    private var listennerForDisconnect: () = Store.getStore().subscribe {state in
        let isAuth = hasAuth(state)

        if (!isAuth) {
            WebSocketManager.getInstance().disconnect()
        }
    }

    public func subscribe() {
        self.connect()
        self.notInvited()
        self.updateGame()
        self.wtUpdate()
        self.winner()
        self.actionPerfomed()
        self.newHand()
        self.timer()
        self.cardCheck()
        self.notFound()
        self.scanCardForUser()
        self.scanCommunityCard()
        self.roomResume()
        self.roomPause()
        self.barRoom()
        self.micChange()
        self.videoChange()
        
        webSocket.connect()
    }
    
    private func connect() {
        webSocket.socket.on(EventOfListen.connect) {data, acc in
            self.webSocketTrigger.takeTableCheck(isWaiting: false)
        }
    }
    
    private func updateGame() {
        webSocket.socket.on(EventOfListen.updateGame) { data, acc in
            let userId = getCurrentUserId(self.store.state)
            
            do {
                let response = data[0] as? [String: Any];
                
                let game = try JSONDecoder().decode(GameData.self, from: JSONSerialization.data(withJSONObject: response?["game"] ?? []))
                let playersForRound = game.getPlayersForRound(game.runninground)
                
                let currentPlayer = game.barroomPlayers.first(where: {player -> Bool in
                    player.id == userId
                })
                
                
                self.store.dispatch(.setProcessGame(game))
                self.store.dispatch(.setWaitingPlayers(game.waitingPlayers))
                self.store.dispatch(.setPlayers(playersForRound))

                if (currentPlayer != nil) {
                    self.store.dispatch(.setFlagLeftToBarRoom(true))
                }
                
                if (game.isReset) {
                    self.store.dispatch(.resetTimer)
                    self.store.dispatch(.setLastAction(nil))
                    self.store.dispatch(.setIsGamePause(false))
                    self.store.dispatch(.setFoldMaked(false))
                }
            } catch {
                print("error", error)
            }

            self.isGameLoaded = true
        }
    }

    private func wtUpdate() {
        webSocket.socket.on(EventOfListen.wtUpdate) { data, acc in
            do {
                let response = data[0] as? [String: Any];

                let game = try JSONDecoder().decode(GameData.self, from: JSONSerialization.data(withJSONObject: response?["game"] ?? []))

                self.store.dispatch(.setWaitingPlayers(game.waitingPlayers))
                self.store.dispatch(.setProcessGame(game))
                self.store.dispatch(.setLastAction(nil))
            } catch {
                print("error", error)
            }
            
            self.isGameLoaded = true
        }
    }

    private func winner() {
        webSocket.socket.on(EventOfListen.winner) { data, acc in
            do {
                let response = data[0] as? [String: Any];
                
                let game = try JSONDecoder().decode(GameData.self, from: JSONSerialization.data(withJSONObject: response?["game"] ?? []))
                let playersForRound = game.getPlayersForRound(game.runninground)
       
                self.store.dispatch(.setProcessGame(game))
                self.store.dispatch(.setWaitingPlayers(game.waitingPlayers))
                self.store.dispatch(.setPlayers(playersForRound))
            } catch {
                print("error", error)
            }
        }
    }

    private func actionPerfomed() {
        webSocket.socket.on(EventOfListen.actionPerformed) {data, acc in
            let userId = getCurrentUserId(self.store.state)
            
            do {
                let response = data[0] as? [String: Any];
                
                let data = try JSONDecoder().decode(ActionPerformed.self, from: JSONSerialization.data(withJSONObject: response ?? []))
                
                if (data.id == userId) {
                    self.store.dispatch(.resetTimer)
                    
                    if (data.action == "fold") {
                        self.store.dispatch(.setFoldMaked(true))
                    }
                }
            } catch {
                print("error", error)
            }
        }
    }

    private func newHand() {
        webSocket.socket.on(EventOfListen.newHand) {data, acc in
            do {
                let response = data[0] as? [String: Any];
                
                let game = try JSONDecoder().decode(GameData.self, from: JSONSerialization.data(withJSONObject: response?["game"] ?? []))
       
                self.store.dispatch(.setProcessGame(game))
                self.store.dispatch(.resetTimer)
                self.store.dispatch(.setLastAction(nil))
                self.store.dispatch(.setFoldMaked(false))
                self.store.dispatch(.setWaitingPlayers(game.waitingPlayers))
            } catch {
                print("error", error)
            }
        }
    }
    
    private func timer() {
        webSocket.socket.on(EventOfListen.timer) {data, acc in
            let userId = getCurrentUserId(self.store.state)
            
            do {
                let response = data[0] as? [String: Any];
                
                let data = try JSONDecoder().decode(Timer.self, from: JSONSerialization.data(withJSONObject: response ?? []))
                
                if (data.id == userId) {
                    self.store.dispatch(.setTimer(data.playerchance))
                }
            } catch {
                print("error", error)
            }
        }
    }
    
    private func cardCheck() {
        webSocket.socket.on(EventOfListen.cardCheck) {data, acc in
            let userId = getCurrentUserId(self.store.state)
            
            do {
                let response = data[0] as? [String: Any];
                
                let data = try JSONDecoder().decode(CardCheck.self, from: JSONSerialization.data(withJSONObject: response ?? []))
                
                if (data.userId == userId) {
                    self.store.dispatch(.setFlagLeftToBarRoom(true))
                }
            } catch {
                print("error", error)
            }
        }
    }
    
    private func notInvited() {
        webSocket.socket.on(EventOfListen.notInvited) {data, acc in
            self.webSocketTrigger.takeTableCheck(isWaiting: true)
        }
    }
    
    private func notFound() {
        webSocket.socket.on(EventOfListen.notFound) {data, acc in
            self.store.dispatch(.setIsGameOver(true))
            
            self.isGameLoaded = true
        }
    }
    
    private func scanCardForUser() {
        webSocket.socket.on(EventOfListen.scanCardForUser) {data, acc in
            do {
                let response = data[0] as? [String: Any];
                
                let game = try JSONDecoder().decode(GameData.self, from: JSONSerialization.data(withJSONObject: response?["game"] ?? []))

                self.store.dispatch(.setProcessGame(game))
                self.store.dispatch(.setPlayers(game.players))
                self.store.dispatch(.setWaitingPlayers(game.waitingPlayers))
                self.store.dispatch(.setLastAction(nil))
            } catch {
                print("error", error)
            }
        }
    }
    
    private func scanCommunityCard() {
        webSocket.socket.on(EventOfListen.scanCommunityCard) {data, acc in
            do {
                let response = data[0] as? [String: Any];
                
                let game = try JSONDecoder().decode(GameData.self, from: JSONSerialization.data(withJSONObject: response?["game"] ?? []))
                let playersForRound = game.getPlayersForRound(game.runninground)
       
                self.store.dispatch(.setPlayers(playersForRound))
                self.store.dispatch(.setWaitingPlayers(game.waitingPlayers))
                self.store.dispatch(.setProcessGame(game))
                self.store.dispatch(.setLastAction(nil))
            } catch {
                print("error", error)
            }
        }
    }
    
    private func roomResume() {
        webSocket.socket.on(EventOfListen.roomResume) {data, acc in
            self.store.dispatch(.setIsGamePause(false))
        }
    }
    
    private func roomPause() {
        webSocket.socket.on(EventOfListen.roomPaused) {data, acc in
            self.store.dispatch(.setIsGamePause(true))
        }
    }
    
    private func barRoom() {
        webSocket.socket.on(EventOfListen.barRoomLeft) {data, acc in
            let userId = getCurrentUserId(self.store.state)
            
            do {
                let response = data[0] as? [String: Any];
                
                let data = try JSONDecoder().decode(BarRoomLeft.self, from: JSONSerialization.data(withJSONObject: response ?? []))
                
                if (data.userId == userId) {
                    self.store.dispatch(.setFlagLeftToBarRoom(true))
                }
            } catch {
                print("error", error)
            }
            
        }
    }
    
    private func micChange() {
        webSocket.socket.on(EventOfListen.playerMicChange) {data, acc in
           let userId = getCurrentUserId(self.store.state)
           do {
                let response = data[0] as? [String: Any];
                
                let data = try JSONDecoder().decode(PlayerMicrophoneChange.self, from: JSONSerialization.data(withJSONObject: response ?? []))
                
                if (data.userId == userId) {
                    self.store.dispatch(.setIsAudio(data.isAudio))
                }
            } catch {
                print("error", error)
            }
        }
    }
    
    private func videoChange() {
        webSocket.socket.on(EventOfListen.playerCameraChange) {data, acc in
            let userId = getCurrentUserId(self.store.state)
            do {
                 let response = data[0] as? [String: Any];
                 
                 let data = try JSONDecoder().decode(PlayerCameraChange.self, from: JSONSerialization.data(withJSONObject: response ?? []))
                 
                 if (data.userId == userId) {
                     self.store.dispatch(.setIsCamera(data.isVideo))
                 }
             } catch {
                 print("error", error)
             }
        }
    }
}
