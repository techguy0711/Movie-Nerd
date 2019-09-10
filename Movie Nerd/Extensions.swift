/*
This extension does the job of fetching image data from a URL and bringing it back as a image.
 */
import UIKit

extension UIImageView {
    public func imageFromUrl(urlString: String) {
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            NSURLConnection.sendAsynchronousRequest(request as URLRequest, queue: .main, completionHandler: { (response, data, error) in
                if let imageData = data as NSData? {
                    self.image = UIImage(data: imageData as Data)
                }
                
            })
        }
    }
}
