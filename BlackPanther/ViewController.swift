//
//  ViewController.swift
//  BlackPanther
//
//  Created by James Furlong on 10/1/21.
//

import Cocoa
import WebKit

class ViewController: NSViewController {
    @IBOutlet weak var playerIndicatorBar: NSProgressIndicator!
    @IBOutlet weak var fixtureIndicatorBar: NSProgressIndicator!
    @IBOutlet weak var resultIndicatorBar: NSProgressIndicator!
    @IBOutlet weak var sportTextField: NSTextField!
    @IBOutlet weak var fixtureYearTextField: NSTextField?
    @IBOutlet weak var resultRoundTextField: NSTextField!
    @IBOutlet weak var resultGameTextField: NSTextField!
    @IBOutlet weak var errorLabel: NSTextField!
    
    private let apiClient = ApiClient()
    private var currentSport: Sport = .NRL
    
    var playerArray: [NRLPlayer] = []
    var teamArray: [NRLTeam] = []
    var resultsArray: [RoundResult] = []
    var fixtureYear: String = ""
    var fixture: Fixture? = nil
    
    // MARK: - Actions
    
    @IBAction func sportChange(_ sender: NSButtonCell) {
        currentSport = Sport.allCases[sender.tag]
        sportTextField.objectValue = currentSport.title
    }
    
    @IBAction func buttonTapped(_ sender: Any) {
        switch currentSport {
            case .NRL: self.apiClient.getNrlPlayers { players in
                self.playerArray = players
            }
            default: self.playerArray = []
        }
    }
    
    @IBAction func fixtureButtonTapped(_ sender: Any) {
        DispatchQueue.main.async {
            self.fixtureIndicatorBar.doubleValue = 0.0
        }
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        let year: String = (fixtureYearTextField?.objectValue ?? formatter.string(from: Date())) as! String
        switch currentSport {
            case .NRL:
                self.apiClient.getNrlFixture(leagueId: currentSport.leagueId, year: year) { fixture in
                    self.fixture = fixture
                }
            case .BigBashCricket:
                self.apiClient.getBigBashFixture(year: year) { fixture in
                    self.fixture = fixture
                }
            default: self.fixture = nil
        }
        DispatchQueue.main.async {
            self.fixtureIndicatorBar.doubleValue = 100.0
        }
    }
    
    @IBAction func resultButtonTapped(_ sender: Any) {
        DispatchQueue.main.async {
            self.resultIndicatorBar.doubleValue = 0.0
        }
        switch currentSport {                
            case .BigBashCricket:
                guard let fixture = self.fixture as? BigBashFixture else { return }
                self.apiClient.getBigBashResults(fixture: fixture) { results in
                    self.resultsArray = results ?? []
                }
            default: self.resultsArray = []
        }
    }
    
    // MARK: - Internal functions
    
    private func getCompletedRound(_ eventId: String, completion: @escaping (RoundResultResponse) -> (Void)) {
        let url = URL(string: "https://www.thesportsdb.com/api/v1/json/1/eventresults.php?id=\(eventId)")
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        request.timeoutInterval = 20
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print(response)
            }
            if let data = data {
                do {
                    let result = try JSONDecoder().decode(RoundResultResponse.self, from: data)
                    completion(result)
                } catch {
                    print(error)
                }
            }
        }.resume()
    }
    
    private func pushUpPlayerInfo() {
        // TODO: Complete this
    }
    
    private func pushUpFixtureInformation() {
        // TODO: Complete this
    }
    
    private func pushUpRoundResults() {
        // TODO: complete this
        self.resultsArray = []
    }
    
    private func displayError(_ message: String) {
        self.errorLabel.objectValue = message
        
        NSAnimationContext.runAnimationGroup ({ context in
            context.duration = 2.0
            context.allowsImplicitAnimation = true
            
            self.errorLabel.alphaValue = 1.0
            self.view.layoutSubtreeIfNeeded()
        }, completionHandler: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                NSAnimationContext.runAnimationGroup({ closeContext in
                    closeContext.duration = 4.0
                    closeContext.allowsImplicitAnimation = true
                    
                    self.errorLabel.alphaValue = 0.0
                    self.view.layoutSubtreeIfNeeded()
                }, completionHandler: nil)
            }
        })
    }
}
