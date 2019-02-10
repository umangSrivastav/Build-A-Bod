import Foundation
import Alamofire

if let accountSID = ProcessInfo.processInfo.environment["AC47f62278032d169da57a3b368bf15756"], 
   let authToken = ProcessInfo.processInfo.environment["9a647743b51c74262af589fca36b9aa1"] {

  let url = "https://api.twilio.com/2010-04-01/Accounts/\(accountSID)/Messages"
  let parameters = ["From": "+15592585036", "To": "+14083297788", "Body": "Hello from Swift!"]

  Alamofire.request(url, method: .post, parameters: parameters)
    .authenticate(user: accountSID, password: authToken)
    .responseJSON { response in
      debugPrint(response)
  }

  RunLoop.main.run()
}
