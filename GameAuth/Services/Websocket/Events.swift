import Foundation

enum EventOfListen {
    static let updateGame = "updateGame"
    static let blinderTimer = "blinderTimer"
    static let winner = "winner"
    static let connect = "connect"
    static let actionPerformed = "actionperformed"
    static let newHand = "newhand"
    static let scanCardForUser = "scanCardForUser"
    static let scanCommunityCard = "scanCommunityCard"
    static let roomResume = "roomResume"
    static let roomPaused = "roomPaused"
    static let notInvited = "notInvited"
    static let timer = "timer"
    static let cardCheck = "cardCheck"
    static let users = "users"
    static let playerCameraChange = "playerCameraChange"
    static let playerMicChange = "playerMicChange"
    static let notFound = "notFound"
    static let wtUpdate = "wt-update"
    static let barRoomLeft = "barRoomLeft"
}

enum EventOfTrigger {
    static let checkTable = "checkTable"
    static let cardCheck = "cardCheck"
    static let doCall = "docall"
    static let doFold = "dofold"
    static let doAllin = "doallin"
    static let doReset = "doreset"
    static let doCheck = "docheck"
    static let doBet = "dobet"
    static let doRaise = "doraise"
    static let playerTentativeAction = "playerTentativeAction"
    static let playerCameraChange = "playerCameraChange"
    static let playerMicChange = "playerMicChange"
}
