
import UIKit
import AVFoundation

@IBDesignable public class HABackgroundPlayerView: UIView {
    
    var player: AVPlayer?
    var avPlayerLayer: AVPlayerLayer!
    var videoURL: NSURL = NSURL()
    var cView: UIView = UIView()
    let screenSize = UIScreen.main.bounds
    
    @IBInspectable
    public var name: String = "test" {
        didSet {
            inits(resource: name, extensionFormat: mime, repeats: repeats, muted: muted, alpha: layerAlpha)
        }
    }
    
    @IBInspectable
    public var mime: String = "mp4" {
        didSet {
            inits(resource: name, extensionFormat: mime, repeats: repeats, muted: muted, alpha: layerAlpha)
        }
    }
    
    @IBInspectable
    public var repeats: Bool = true {
        didSet {
            inits(resource: name, extensionFormat: mime, repeats: repeats, muted: muted, alpha: layerAlpha)
        }
    }
    
    @IBInspectable
    public var muted: Bool = true {
        didSet {
            inits(resource: name, extensionFormat: mime, repeats: repeats, muted: muted, alpha: layerAlpha)
        }
    }
    
    @IBInspectable
    public var layerAlpha: CGFloat = 0.5 {
        didSet {
            inits(resource: name, extensionFormat: mime, repeats: repeats, muted: muted, alpha: layerAlpha)
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        inits(resource: name, extensionFormat: mime, repeats: repeats, muted: muted, alpha: layerAlpha)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        inits(resource: name, extensionFormat: mime, repeats: repeats, muted: muted, alpha: layerAlpha)
    }
    
    func inits(resource: String, extensionFormat: String, repeats: Bool, muted: Bool, alpha: CGFloat) {
        
        setLayer()
        
        guard let video = Bundle.main.url(forResource: resource,
                                          withExtension: extensionFormat) else {
                                            return
        }
        videoURL = video as NSURL
        
        if (player == nil) {
            player = AVPlayer(url: videoURL as URL)
            player?.actionAtItemEnd = .none
            player?.isMuted = muted
            
            avPlayerLayer = AVPlayerLayer(player: player)
            avPlayerLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
            avPlayerLayer.zPosition = -1
            avPlayerLayer.frame = screenSize
            
            player?.play()
            
            layer.addSublayer(avPlayerLayer)
            
        }
        
        if repeats {
            NotificationCenter.default.addObserver(self,
                                                   selector: #selector(loopVideo),
                                                   name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
                                                   object: player?.currentItem)
        }
        
    }
    
    @objc func loopVideo() {
        player?.seek(to: CMTime.zero)
        player?.play()
    }
    
    func setLayer() {
        if cView.isDescendant(of: self) {
            cView.removeFromSuperview()
        } else {
            cView = UIView.init(frame: screenSize)
            cView.backgroundColor = UIColor.black
            cView.alpha = layerAlpha;
            cView.layer.zPosition = 0;
            self.addSubview(cView)
        }
    }
}
