import Foundation
import UIKit

class NetworkManager {
    
    static let shared = NetworkManager()
    
    func loadData(url: String, completion: @escaping ([DataModel]) -> ()) {
        guard let url = URL(string: url) else { return }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                var postsDataArray = [DataModel]()
                if let json = try? JSONSerialization.jsonObject(with: data) as? [String : Any] {
                    if let postsData = json["hydra:member"] as? [[String : Any?]] {
                        for element in postsData {
                            if let postId = element["@id"] as? String,
                               let bodyText = element["body"] as? String,
                               let featuredMedia = element["featuredMedia"] as? [String : Any],
                               let headLineText = element["headline"] as? String,
                               let subHeadLineText = element["subHead"] as? String,
                               let context = featuredMedia["context"] as? [String : Any],
                               let imageUrl = context["thumbnail_resized_800"] as? String,
                               let mainTaxonomy = element["mainTaxonomy"] as? [String : Any],
                               let description = mainTaxonomy["description"] as? String {
                                let dataModel = DataModel(postId: postId, headLineText: headLineText, bodyText: bodyText, subHeadlineText: subHeadLineText, imageUrl: imageUrl, description: description)
                                postsDataArray.append(dataModel)
                            }
                        }
                    }
                }
                completion(postsDataArray)
            }
        }.resume()
    }
    
    func getImage(url: String, completion: @escaping (UIImage) -> ()) {
        if let url = URL(string: url) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else { return }
                if let image = UIImage(data: data) {
                    completion(image)
                } else {
                    completion(UIImage())
                }
            }.resume()
        }
    }
}
