import XCTest

class GameTest: XCTestCase {
    
    var game: Game!
    
    override func setUp() {
        game = Game()
    }

    func testXAlwaysGoesFirst() {
        XCTAssertEqual(game.nextPlayer(), Player.x)
    }
    
    func testPlayersCannotPlayOnAPlayedPosition() {
        game.play(Position.topLeft)
        let status = game.play(Position.topLeft)
        
        XCTAssertEqual(status, Status.positionAlreadyPlayed)
    }
    
    func testPlayersCanTakeANotPlayedPosition() {
        game.play(Position.topLeft)
        let status = game.play(Position.topMiddle)
        
        XCTAssertEqual(status, Status.positionTaken)
    }
    
    func testPlayersAlternatePlacingXandO() {
        game.play(Position.topLeft)
        
        XCTAssertEqual(game.nextPlayer(), Player.o)
    }
    
    // X' O' X'
    // X' O' O'
    // O' X' X'
    func testTheGameIsADrawWhenAllNineSquaresAreFilledAndNeitherPlayerHasThreeInARow() {
        game.play(Position.topLeft)
        game.play(Position.topMiddle)
        game.play(Position.topRight)
        game.play(Position.centerMiddle)
        game.play(Position.centerLeft)
        game.play(Position.centerRight)
        game.play(Position.bottomMiddle)
        game.play(Position.bottomLeft)
        let state = game.play(Position.bottomRight)
        
        XCTAssertEqual(state, Status.draw)
    }
    
    // X' X' X' ---> win
    // O'
    // O'
    func testXWinsTakingAllTheTopRow() {
        game.play(Position.topLeft)
        game.play(Position.centerLeft)
        game.play(Position.topMiddle)
        game.play(Position.bottomLeft)
        let state = game.play(Position.topRight)
        
        XCTAssertEqual(state, Status.xWon)
    }

    // O' O' O' ---> win
    // X' X'
    // X'
    func testOWinsTakingAllTheTopRow() {
        game.play(Position.bottomLeft)
        game.play(Position.topLeft)
        game.play(Position.centerLeft)
        game.play(Position.topMiddle)
        game.play(Position.centerMiddle)
        let state = game.play(Position.topRight)

        XCTAssertEqual(state, Status.oWon)
    }
    
    // O'
    // X' X' X' ---> win
    // O'
    func testXWinsTakingAllTheCenterRow() {
        game.play(Position.centerLeft)
        game.play(Position.topLeft)
        game.play(Position.centerMiddle)
        game.play(Position.bottomLeft)
        let state = game.play(Position.centerRight)
        
        XCTAssertEqual(state, Status.xWon)
    }
    
    // X'
    // O' O' O' ---> win
    // X' X'
    func testOWinsTakingAllTheCenterRow() {
        game.play(Position.bottomMiddle)
        game.play(Position.centerLeft)
        game.play(Position.topLeft)
        game.play(Position.centerMiddle)
        game.play(Position.bottomLeft)
        let state = game.play(Position.centerRight)
        
        XCTAssertEqual(state, Status.oWon)
    }
}
