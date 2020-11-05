import Path
import SQLite

let device = "2BB0BA90-51E2-4966-8A91-5A22E8618353"
let keychain = "keychain-2-debug.db"

let path = Path.home/"Library/Developer/CoreSimulator/Devices"/device/"data/Library/Keychains"/keychain
print(path)

let bundleID = "MTGSZH8QM4.co.log-g.RealmTaskTracker"

let db = try Connection(path.string)

// genp table, data column
// where agrp = bundleID
for row in try db.prepare("SELECT data FROM genp WHERE agrp = '\(bundleID)'") {
    print("data: \(row[0])")
}
