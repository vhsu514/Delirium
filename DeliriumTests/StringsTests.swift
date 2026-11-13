import Foundation
import Testing
@testable import Delirium

/// Checks on every user-facing string, in English and Spanish.
/// The unit tests run inside the app, so `Bundle.main` is the app bundle
/// and holds the compiled strings catalog.
struct StringsTests {
    static let languages = ["en", "es"]

    /// PLAN.md section 9, plus Spanish forms of the same phrases.
    static let bannedPhrases = [
        "has delirium", "diagnos", "prevents delirium", "treats",
        "tiene delirio", "tiene delirium", "diagnós",
        "previene el delirio", "previene el delirium", "trata el", "trata la",
    ]

    /// Hard rule 2: no drug advice. Common drug names linked with sudden
    /// confusion in hospital. Add to this list as content grows.
    static let drugNames = [
        "haloperidol", "haldol", "lorazepam", "ativan", "diazepam", "valium",
        "midazolam", "quetiapine", "quetiapina", "seroquel", "olanzapine",
        "olanzapina", "risperidone", "risperidona", "melatonin", "melatonina",
        "ramelteon", "dexmedetomidine", "dexmedetomidina", "zolpidem",
        "ambien", "diphenhydramine", "difenhidramina", "benadryl", "trazodone",
        "trazodona", "morphine", "morfina", "oxycodone", "oxicodona",
        "fentanyl", "fentanilo", "propofol", "donepezil",
    ]

    static func table(_ language: String) -> [String: String] {
        guard
            let path = Bundle.main.path(
                forResource: "Localizable", ofType: "strings",
                inDirectory: nil, forLocalization: language),
            let table = NSDictionary(contentsOfFile: path) as? [String: String]
        else { return [:] }
        return table
    }

    @Test(arguments: languages)
    func catalogIsPresent(language: String) {
        #expect(!Self.table(language).isEmpty)
    }

    @Test func englishAndSpanishHaveTheSameKeys() {
        let en = Set(Self.table("en").keys)
        let es = Set(Self.table("es").keys)
        #expect(en == es)
    }

    @Test(arguments: languages)
    func noStringIsEmpty(language: String) {
        for (key, value) in Self.table(language) {
            #expect(
                !value.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
                "\(key) is empty in \(language)")
        }
    }

    @Test(arguments: languages)
    func everyScreenHasTitleAndSubtitle(language: String) {
        let table = Self.table(language)
        for screen in Screen.allCases {
            #expect(table[screen.titleKeyName] != nil)
            #expect(table[screen.subtitleKeyName] != nil)
        }
    }

    @Test(arguments: languages)
    func noBannedPhrasesOrDrugNames(language: String) {
        for (key, value) in Self.table(language) {
            let text = value.lowercased()
            for phrase in Self.bannedPhrases + Self.drugNames {
                #expect(
                    !text.contains(phrase),
                    "\(key) (\(language)) contains banned text: \(phrase)")
            }
        }
    }
}
