//
//  WebSocketTrigger.swift
//  PockerController
//
//  Created by Anton Votinov on 11.03.2023.
//

import Foundation

final class WebSocketTrigger {
    private let webSocket = WebSocketManager.getInstance()
    private let store = Store.getStore()
    
    public func takeFold() -> Void {
        webSocket.socket.emit(EventOfTrigger.doFold, getDataForSocket(store.state));
    };

    public func takeCardCheck() -> Void {
        webSocket.socket.emit(EventOfTrigger.cardCheck, getDataForSocket(store.state));
    };

    public func takeCall (amount: Int) -> Void {
        var dataForCall = getDataForSocket(store.state) as [String: Any];
        
        dataForCall["amount"] = amount

        webSocket.socket.emit(EventOfTrigger.doCall, dataForCall);
    };

    public func takeRaise(amount: Int) -> Void {
        var dataForRaise = getDataForSocket(store.state) as [String: Any];
        
        dataForRaise["amount"] = amount
        
        webSocket.socket.emit(EventOfTrigger.doRaise, dataForRaise);
    };

    public func takeTableCheck(isWaiting: Bool) -> Void {
        var dataForCheck = getDataForSocket(store.state) as [String: Any];
        
        dataForCheck["isWaiting"] = isWaiting
        
        webSocket.socket.emit(EventOfTrigger.checkTable, dataForCheck);
    };

    public func takeCheck() -> Void {
        webSocket.socket.emit(EventOfTrigger.doCheck, getDataForSocket(store.state));
    };

    public func takeAllIn(amount: Int) -> Void {
        var dataForAllIn = getDataForSocket(store.state) as [String: Any];
        
        dataForAllIn["amount"] = amount
        
        webSocket.socket.emit(EventOfTrigger.doAllin, getDataForSocket(store.state));
    };

    public func takeBet(amount: Int) -> Void {
        var dataForBet = getDataForSocket(store.state) as [String: Any];
        
        dataForBet["amount"] = amount
        
        webSocket.socket.emit(EventOfTrigger.doBet, getDataForSocket(store.state));
    };

    public func takePlayerTentativeAction(playerAction: String?) -> Void {
        var dataForTentativeAction = getDataForSocket(store.state) as [String: Any];
        
        dataForTentativeAction["playerAction"] = playerAction
        
        webSocket.socket.emit(EventOfTrigger.playerTentativeAction, dataForTentativeAction);
    };
}
