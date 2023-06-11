
import Foundation
class LinkDataGetter {
    
    func getDashboardInfo(withSuccess success: @escaping (_ responseDictionary: LinkData?) -> Void, failure: @escaping (_ error: String) -> Void){
        // *** 1 ***
        let session = URLSession.shared
        
        let requestURL = URL(string: Constant.apiURL)!
        // *** 2 ***
        var request = URLRequest(url: requestURL)
        // Configure request method
        request.httpMethod = "GET"
        // Configure request authentication
        request.setValue(Constant.accessToken,forHTTPHeaderField: "Authorization")
        
        // *** 3 ***
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                // Case 1: Error
                // We got some kind of error while trying to get data from the server.
                print("Error:\n\(error)")
                failure(error.localizedDescription)
            }else {
                // Case 2: Success
                // We got a response from the server!
                let dataString = String(data: data!, encoding: String.Encoding.utf8)
                print("Human-readable data:\n\(dataString!)")
               
                        do {
                          // Try to convert that data into a Swift dictionary
                            let linkData = try JSONDecoder().decode(LinkData.self, from: data!)
                            if linkData.statusCode == 404{
                                failure("")
                                return
                            }
                           
                             success(linkData)
                        }
                        catch let jsonError as NSError {
                          // An error occurred while trying to convert the data into a Swift dictionary.
                          print("JSON error description: \(jsonError.description)")
                            failure(jsonError.description)
                        }
            }
        }
        // *** 6 ***
        dataTask.resume()
    }

}
  
