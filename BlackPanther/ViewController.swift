//
//  ViewController.swift
//  BlackPanther
//
//  Created by James Furlong on 10/1/21.
//

import Cocoa
import WebKit

class ViewController: NSViewController {
    @IBOutlet weak var outputView: NSScrollView!
    @IBOutlet weak var sportOptions: NSPopUpButton!
    
    @IBOutlet weak var fixtureYearTextField: NSTextField?
    @IBOutlet weak var resultRoundTextField: NSTextField!
    
    @IBOutlet weak var playerIndicatorBar: NSProgressIndicator!
    @IBOutlet weak var fixtureIndicatorBar: NSProgressIndicator!
    @IBOutlet weak var resultsIndicatorBar: NSProgressIndicator!
    @IBOutlet weak var resultIndicatorBar: NSProgressIndicator!
    @IBOutlet weak var statsProgressBar: NSProgressIndicator!
    
    private let apiClient = ApiClient()
    private var textOutput: NSTextView? = nil
    private var currentSport: Sport = .NRL
    
    var playerArray: [NRLPlayer]? = nil
    var teamArray: [NRLTeam] = []
    var resultsArray: [RoundResult] = []
    var fixtureYear: String = ""
    var fixture: Fixture? = nil
    var nrlFixture: NRLFixture? = nil
    var nrlResults: [NRLRound]? = nil
    var nrlRoundResult: NRLRound? = nil
    
    var welcomeString: String {
        "Welcome to the Admin Console\nCurrent Sport: \(currentSport.title)\n"
    }
    
    override func viewDidLoad() {
        self.sportOptions.removeAllItems()
        Sport.allCases.forEach { sport in
            self.sportOptions.addItem(withTitle: sport.title)
        }
        super.viewDidLoad()
        textOutput = outputView.documentView as? NSTextView
        outputText(welcomeString, appendText: false)
    }
    
    // MARK: - Actions
    
    @IBAction func sportChanged(_ sender: NSPopUpButton) {
        currentSport = Sport.allCases[sender.indexOfSelectedItem]
    }
    
    @IBAction func getPlayersTapped(_ sender: Any) {
        DispatchQueue.main.async {
            self.playerIndicatorBar.doubleValue = 0.0
            self.playerIndicatorBar.isIndeterminate = true
            self.playerIndicatorBar.startAnimation(self)
        }
        switch currentSport {
            case .NRL: self.apiClient.getNrlPlayers { players in
                self.playerArray = players
                DispatchQueue.main.async {
                    self.playerIndicatorBar.stopAnimation(self)
                    let outputText = players != nil ? "**** Players successfully retrieved ****" : "Something went wrong\n"
                    self.outputText(outputText)
                    self.playerIndicatorBar.isIndeterminate = false
                    self.playerIndicatorBar.doubleValue = players != nil ? 100.0 : 0.0
                }
            }
            default:
                self.playerArray = []
                DispatchQueue.main.async {
                    self.playerIndicatorBar.stopAnimation(self)
                }
        }
    }
    
    @IBAction func viewPlayersTapped(_ sender: NSButton) {
        switch currentSport {
            case .NRL:
                guard let players = self.playerArray else {
                    self.outputText("Fixture mus be retrieved first\n")
                    return
                }
                
                players.forEach { player in
                    self.outputText(player.toString())
                }
            default:
                return
        }
    }
    
    @IBAction func getFixtureTapped(_ sender: Any) {
        DispatchQueue.main.async {
            self.fixtureIndicatorBar.doubleValue = 0.0
            self.fixtureIndicatorBar.isIndeterminate = true
            self.fixtureIndicatorBar.startAnimation(self)
        }
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        let year: String = (fixtureYearTextField?.objectValue ?? formatter.string(from: Date())) as! String
        switch currentSport {
            case .NRL, .NRLW, .StateOfOrigin, .StateOfOriginWomens:
                guard let comp = currentSport.nrlComp else { return }
                self.apiClient.getNrlFixture(year: year, comp: comp) { fixture in
                    self.nrlFixture = fixture
                    DispatchQueue.main.async {
                        self.fixtureIndicatorBar.stopAnimation(self)
                        let outputText = fixture != nil ? "**** Fixture successfully retrieved ****" : "Something went wrong\n"
                        self.outputText(outputText)
                        self.fixtureIndicatorBar.isIndeterminate = false
                        self.fixtureIndicatorBar.doubleValue = fixture != nil ? 100.0 : 0.0
                    }
                }
            case .BigBashCricket:
                self.apiClient.getBigBashFixture(year: year) { fixture in
//                    self.fixture = fixture
                    DispatchQueue.main.async {
                        self.fixtureIndicatorBar.doubleValue = 100.0
                    }
                }
            default: self.fixture = nil
        }
    }
    
    @IBAction func viewFixtureTapped(_ sender: Any) {
        switch currentSport {
            case .NRL, .NRLW, .StateOfOrigin, .StateOfOriginWomens:
                guard let fixture = self.nrlFixture else {
                    self.outputText("Fixture must be retrieved first\n")
                    return
                }
                
                self.outputText(fixture.toString())
            default:
                return
        }
    }
    
    @IBAction func getResultsTapped(_ sender: Any) {
        DispatchQueue.main.async {
            self.resultsIndicatorBar.doubleValue = 0.0
            self.resultsIndicatorBar.isIndeterminate = true
            self.resultsIndicatorBar.startAnimation(self)
        }
        switch currentSport {                
            case .BigBashCricket:
                guard let fixture = self.fixture as? BigBashFixture else { return }
                self.apiClient.getBigBashResults(fixture: fixture) { results in
                    self.resultsArray = results ?? []
                }
            case .NRL:
                guard let fixture = self.nrlFixture else { return }
                DispatchQueue.main.async {
//                    self.resultsIndicatorBar.an
                }
                self.apiClient.getNrlResults(fixture: fixture) { results in
                    self.nrlResults = results
                    DispatchQueue.main.async {
                        self.resultsIndicatorBar.stopAnimation(self)
                        let outputText = results != nil ? "**** Results succesfully retrieved ****" : "Something went wrong\n"
                        self.outputText(outputText)
                        self.resultsIndicatorBar.isIndeterminate = false
                        self.resultsIndicatorBar.doubleValue = results != nil ? 100.0 : 0.0
                    }
                    
                }
            default: self.resultsArray = []
        }
    }
    
    @IBAction func showResultsTapped(_ sender: Any) {
        switch currentSport {
            case .NRL:
                guard let results = self.nrlResults else {
                    outputText("Results must be retrieved first\n")
                    return
                }
                outputText(NRLRound.resultString(from: results))
            default:
                return 
        }
    }
    
    @IBAction func getResultTapped(_ sender: Any) {
        DispatchQueue.main.async {
            self.resultIndicatorBar.doubleValue = 0.0
            self.resultIndicatorBar.isIndeterminate = true
            self.resultIndicatorBar.startAnimation(self)
        }
        switch currentSport {
            case .NRL:
                guard let fixture = self.nrlFixture else { return }
                guard let round = Int(self.resultRoundTextField.stringValue) else {
                    self.outputText("Round must be entered and must be a number")
                    return
                }
                self.apiClient.getNrlResult(fixture: fixture, round: round) { result in
                    self.nrlRoundResult = result
                    DispatchQueue.main.async {
                        self.resultIndicatorBar.stopAnimation(self)
                        let outputText = result != nil ? "**** Result succesfully retrieved ****" : "Something went wrong\n"
                        self.outputText(outputText)
                        self.resultIndicatorBar.isIndeterminate = false
                        self.resultIndicatorBar.doubleValue = result != nil ? 100.0 : 0.0
                    }
                }
            default:
                self.nrlRoundResult = nil
        }
    }
    
    @IBAction func showResultTapped(_ sender: Any) {
        switch currentSport {
            case .NRL:
                guard let result = self.nrlRoundResult else {
                    outputText("Result must be retrieved first\n")
                    return
                }
                outputText(result.toString())
            default:
                return
        }
    }
    
    @IBAction func getStatsTapped(_ sender: Any) {
        //TODO: Implement this
    }
    
    @IBAction func showStatsTapped(_ sender: Any) {
        //TODO: Implement this
    }
    
    // MARK: - Internal functions
    
    private func outputText(_ text: String, appendText: Bool = true) {
        let formattedText: String = "\(text)\n"
        if appendText {
            self.textOutput?.textStorage?.mutableString.append(formattedText)
            return
        }
        self.textOutput?.textStorage?.mutableString.setString(formattedText)
        self.textOutput?.textColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
    }
}
