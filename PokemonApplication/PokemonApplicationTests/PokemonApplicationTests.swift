//
//  PokemonApplicationTests.swift
//  PokemonApplicationTests
//
//  Created by Oscar Dominguez Ocaña on 1/2/24.
//

import XCTest
@testable import PokemonApplication

final class PokemonApplicationTests: XCTestCase {

    override func setUpWithError() throws {
        
    }

    override func tearDownWithError() throws {
        
    }

    func testFetchPokemonsList() throws {
        let expectation = XCTestExpectation(description: "Fetching pokemons")

        let vm = PokemonViewModel(pokemonManager: MockPokemonManager())
        vm.getPokemonList()

        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            XCTAssertTrue(!vm.pokemonList.isEmpty, "Pokemon list is empty")
            XCTAssertTrue(!vm.filteredPokemon.isEmpty, "Filtered Pokemon list is not empty")
            XCTAssertTrue(vm.pokemonList.count == 151, "Pokemon list count is incorrect")
            
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 3.0)
    }

}
