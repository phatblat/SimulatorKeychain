import Path
import SQLite
import Foundation

let device = "2BB0BA90-51E2-4966-8A91-5A22E8618353"
let keychain = "keychain-2-debug.db"

let path = Path.home/"Library/Developer/CoreSimulator/Devices"/device/"data/Library/Keychains"/keychain
print(path)

let bundleID = "MTGSZH8QM4.co.log-g.RealmTaskTracker"

let db = try Connection(path.string)


// genp table, data column
// where agrp = bundleID
//let data = try db.scalar("SELECT data FROM genp WHERE agrp = '\(bundleID)'")!


let genp = Table("genp")
let groupColumn = Expression<String>("agrp")
let dataColumn = Expression<Data>("data")

let filteredTable = genp.filter(groupColumn == bundleID)
let row = try! db.prepare(filteredTable)
let data = row.map { $0[dataColumn] }.first!

print("data: \(data.datatypeValue)")

let object = try! NSKeyedUnarchiver.unarchiveObject(with: data) as Any
print(object)

/* SecurityFoundation types
 data layout:
 root: nil
 SFInitializationVector
 SFCiphertext
 SFAuthenticationCode
 <object data>

 SFAuthenticatedCiphertext
 SFAuthenticatedCiphertext
 SFCiphertext
 <object data>

 uuid

 root: nil
 SFInitializationVector
 SFCiphertext
 SFAuthenticationCode
 <object data>

 SFAuthenticatedCiphertext
 SFAuthenticatedCiphertext
 SFCiphertext
 <object data>

 root: nil
 SFInitializationVector
 SFCiphertext
 SFAuthenticationCode
 <object data>

 SFAuthenticatedCiphertext
 SFAuthenticatedCiphertext
 SFCiphertext
 <object data>
 uuid
*/
