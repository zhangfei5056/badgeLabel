
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let strings = ["111-111-111-111", "22222-22222", "3-3-3-3-3-3-3-333333333", "444444-44-4444444-4-4-4-4", "5555555", "6"]
        var newImagedString: [NSAttributedString?] = []
        let separator = NSAttributedString(string: "   ")
        strings.lazy.forEach { (str) in
            let imagedString = makeStirngToImage(text: str)
            newImagedString.append(imagedString)
            newImagedString.append(separator)
        }

        let allStirngs = NSMutableAttributedString()
        for i in newImagedString {
            if let attributedStr = i {
                allStirngs.append(attributedStr)
            }
        }
        self.textView.attributedText = allStirngs

        let image = stringToImage(text: "really nice day")
        let imageView = UIImageView(image: image)
        if let image = image {
            imageView.frame = CGRect(x: 20, y: 100, width: image.size.width, height: image.size.height)
            self.view.addSubview(imageView)
        }
    }

    func makeStirngToImage(text: String) -> NSAttributedString? {
        guard let image = stringToImage(text: text) else { return nil }
        let attachment = NSTextAttachment()
        attachment.image = image
        return NSAttributedString(attachment: attachment)
    }

    func stringToImage(text: String) -> UIImage? {
        let label = BadgeLabel()
        label.font = UIFont.systemFont(ofSize: 24)
        label.text = text
        label.textColor = UIColor.red
        label.layer.borderColor = UIColor.red.cgColor
        label.layer.borderWidth = 1.0
        label.layer.cornerRadius = 2.5
        label.layer.masksToBounds = true
        label.lineBreakMode = .byClipping
        label.textAlignment = .center
        label.layer.allowsEdgeAntialiasing = true

        label.invalidateIntrinsicContentSize()
        label.sizeToFit()
        let size = label.bounds.size
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        if let ctx = UIGraphicsGetCurrentContext() {
            label.layer.render(in: ctx)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return image;
        }
        return nil
    }
}


class BadgeLabel: UILabel {

    var insets = UIEdgeInsets(top: 2, left: 4, bottom: 2, right: 4)

    override public var intrinsicContentSize: CGSize {
        var superSize = super.intrinsicContentSize
        superSize.width += insets.left + insets.right
        superSize.height += insets.top + insets.bottom
        return superSize
    }

    override public func sizeThatFits(_ size: CGSize) -> CGSize {
        var superSize = super.sizeThatFits(size)
        superSize.width += insets.left + insets.right
        superSize.height += insets.top + insets.bottom
        return superSize
    }

    override public func drawText(in rect: CGRect) {
        super.drawText(in: UIEdgeInsetsInsetRect(rect, insets))
    }

}
