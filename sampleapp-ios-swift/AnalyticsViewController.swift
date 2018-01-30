
import UIKit
import MobileCenterAnalytics

class AnalyticsViewController: UIViewController {

    @IBOutlet weak var customEventButton: UIButton!
    @IBOutlet weak var customColorButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        customColorButton.layer.cornerRadius = 10.0
        customEventButton.layer.cornerRadius = 10.0

        navigationController?.navigationBar.barTintColor = UIColor.black
        navigationController?.navigationBar.isTranslucent = false
    }

    @IBAction func analyticsButtonTapped(_ sender: UIButton) {
        switch sender {
        case customEventButton:
            MSAnalytics.trackEvent("Sample event")
            
            // vvv
            
            
            //API endpoint from swagger
            let url = URL(string: "https://api.appcenter.ms/v0.1/apps/Winnies-Test-Organization/Sample-iOS-App/push/notifications")!
            
            // post the data
            
            //building the URL request
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            //headers -- from swagger (anything with -H in curl)
            request.addValue("33e9abf9c2a16df40acca5eaab04a6f6cdfcbead", forHTTPHeaderField: "X-API-Token")
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            //JSON body (copy/pasted from curl)
            let postDataString = "{ \"notification_content\": { \"name\": \"Name\", \"title\": \"Title\", \"body\": \"Body\" }}"
            // Convert from string to UTF8 binary
            request.httpBody = postDataString.data(using: .utf8)
            
            // Fires the request
            let task = URLSession.shared.dataTask(with: request, completionHandler: { (responseData: Data?, response: URLResponse?, error: Error?) in
                // Deal with response
                NSLog("\(response)")
            })
            task.resume()
            
            // ^^^
            
            
            print("send a custom alert via Cocoapods")
            presentCustomEventAlert()

        case customColorButton:
            print("custom color property button pressed")
            presentColorPropertyAlert()

        default:
            break
        }
    }

    // - MARK: Alert Functions

    func presentCustomEventAlert() {
        let alert = UIAlertController(title: "Event sent",
                                      message: "",
                                      preferredStyle: .alert)

        // OK Button
        alert.addAction(UIAlertAction(title: "OK",
                                      style: .default,
                                      handler: { _ in alert.dismiss(animated: true, completion: nil)
        }))
        present(alert, animated: true, completion: nil)
    }

    func presentColorPropertyAlert() {
        let alert = UIAlertController(title: "Choose a color",
                                      message: "",
                                      preferredStyle: .alert)
        alert.view.tintColor = UIColor.black

        // Yellow button
        alert.addAction(UIAlertAction(title: "💛 Yellow",
                                      style: .default,
                                      handler: { _ in alert.dismiss(animated: true, completion: nil)
                                          MSAnalytics.trackEvent("Color event", withProperties: ["Color": "Yellow"])
        }))

        // Blue button
        alert.addAction(UIAlertAction(title: "💙 Blue",
                                      style: .default,
                                      handler: { _ in alert.dismiss(animated: true, completion: nil)
                                          MSAnalytics.trackEvent("Color event", withProperties: ["Color": "Blue"])
        }))

        // Red button
        alert.addAction(UIAlertAction(title: "❤️ Red",
                                      style: .default,
                                      handler: { _ in alert.dismiss(animated: true, completion: nil)
                                          MSAnalytics.trackEvent("Color event", withProperties: ["Color": "Red"])
        }))

        present(alert, animated: true, completion: nil)
    }
}
