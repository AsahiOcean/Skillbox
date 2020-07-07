import UIKit
import AVKit
import Vision
// Skillbox
// VisionBasic
/*
 Создайте ML модель, которая умеет различать собак, кошек, мышей и деревья

 Создайте свой Skynet в режиме реального времени, у которого будет показываться камера и кнопка “Стрелять”. По нажатию на нее вылетает ракета, которая летит к ближайшему найденному лицу. При движении лица ракета автоматически изменяет траекторию
 */

class SkynetViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    let viewFaceImage: UIView! = UIView(frame: .zero)
    
    let player = AVPlayer(url: Bundle.main.url(forResource: "123", withExtension: "m4v")!)
    let playerLayer: AVPlayerLayer! = AVPlayerLayer()
    var videoOutput: AVPlayerItemVideoOutput!
    var playSwitch: CMTimeValue = .zero
    let viewFaceAV: UIView! = UIView(frame: .zero)

    override func viewDidLoad() {
        super.viewDidLoad()
        //MARK: -- ПОИСК ЛИЦА НА ВИДЕО (AVPlayer)
        //MARK: Face tracking on local video
        self.playerLayer.player = self.player

        // возьмем размеры фрейма от imageView
        self.playerLayer.frame = CGRect(x: view.frame.minX, y: view.frame.midY - (imageView.frame.height / 2), width: imageView.frame.width, height: imageView.frame.height)
        self.playerLayer.videoGravity = .resizeAspectFill
        self.playerLayer.backgroundColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
        self.view.layer.addSublayer(self.playerLayer)
        self.player.isMuted = true
        self.player.play()
        
        player.currentItem?.addObserver(self,
          forKeyPath: #keyPath(AVPlayerItem.status),
          options: [.initial, .old, .new],
          context: nil)
        player.addPeriodicTimeObserver(
          forInterval: CMTime(value: 1, timescale: 15),
          queue: DispatchQueue(label: "videoProcessing", qos: .background),
          using: { time in
            self.doThingsWithFaces()
        })
        self.view.addSubview(self.viewFaceAV)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //MARK: -- ПОИСК ЛИЦА НА КАДРЕ ИЗ ВИДЕО (UIImageView)
        //MARK: Tracking the face in the frame from the video
        
        Timer.scheduledTimer(timeInterval: 0.25, target: self, selector: #selector(self.layerMasksTimer), userInfo: nil, repeats: true)
        self.view.addSubview(self.viewFaceImage)
    }
    
    //MARK: -- ПОИСК ЛИЦА НА КАДРЕ ИЗ ВИДЕО (UIImageView)
    //MARK: Tracking the face in the frame from the video
    @objc func layerMasksTimer() {
        let Asset = self.player.currentItem?.asset as? AVURLAsset
        var imageGenerator: AVAssetImageGenerator? = nil
                
        guard let asset = Asset else { return }
            
        imageGenerator = AVAssetImageGenerator(asset: asset)
        imageGenerator?.requestedTimeToleranceAfter = .zero
        imageGenerator?.requestedTimeToleranceBefore = .zero
        
        var cgImage: CGImage?
        do {
            cgImage = try imageGenerator!.copyCGImage(
                at: (self.player.currentItem?.currentTime())!,
                actualTime: nil)
        } catch let error as NSError {
            print("Fail thumbnail: \(error)")
        }
        
        self.imageView.image = UIImage(cgImage: cgImage!)
        self.viewFaceImage.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 0.5)

        DispatchQueue.main.async {
            let request = VNDetectFaceRectanglesRequest { request, error in
                if let fail = error {
                    print("Ошибка VNDetectFaceRectanglesRequest:", fail)
                    return
                }
                
                if request.results?.count == 0 {
                    print("Not see faces on imageView")
                } else {
                    // print("Face count on imageView: \(request.results!.count)")
                    
                    request.results?.forEach({ result in
                        
                        DispatchQueue.main.async {
                            guard let face = result as? VNFaceObservation else { return }
                                                
                            let x = face.boundingBox.origin.x * self.imageView.frame.width
                            let width = face.boundingBox.size.width * self.imageView.frame.width
                            let height = face.boundingBox.size.height * self.imageView.frame.height
                            let y = self.imageView.frame.maxY - (face.boundingBox.origin.y * self.imageView.frame.height) - height
                            
                            self.viewFaceImage.frame = CGRect(x: x, y: y, width: width, height: height)
                        }
                    })
                }
            }
            
            DispatchQueue.main.async {
                guard let img = self.imageView.image else { return }
                let handler = VNImageRequestHandler(cvPixelBuffer: self.ImageCVPixelBuffer(from: img)!)
                do {
                    try handler.perform([request])
                }
                catch let error {
                    print("Ошибка VNImageRequestHandler:", error)
                }
            }
        }
    }
    
    //MARK: -- ПОИСК ЛИЦА НА ВИДЕО (AVPlayer)
    //MARK: Face tracking on local video
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
    guard let keyPath = keyPath, let item = object as? AVPlayerItem else { return }

      switch keyPath {
        case #keyPath(AVPlayerItem.status):
            if item.status == .readyToPlay { self.setUpOutput() }
            break
        default: break
      }
    }
    
    func setUpOutput() {
        guard self.videoOutput == nil else { return }
        let videoItem = self.player.currentItem!
        
        if videoItem.status != .readyToPlay {
        // see https://forums.developer.apple.com/thread/27589#128476
        return
        }
        
        let pixelBuffAttributes = [kCVPixelBufferPixelFormatTypeKey as String: kCVPixelFormatType_420YpCbCr8BiPlanarVideoRange,
        ] as [String: Any]
    
        // kCVPixelFormatType_32BGRA
        // kCVPixelFormatType_420YpCbCr8BiPlanarVideoRange

        let videoOutput = AVPlayerItemVideoOutput(pixelBufferAttributes: pixelBuffAttributes)
        videoItem.add(videoOutput)
        self.videoOutput = videoOutput
    }
    
    func getNewFrame() -> CVPixelBuffer? {
        guard let videoOutput = videoOutput, let currentItem = self.player.currentItem else { return nil }

        let time = currentItem.currentTime()
        if !videoOutput.hasNewPixelBuffer(forItemTime: time) { return nil }
        guard let buffer = videoOutput.copyPixelBuffer(forItemTime: time, itemTimeForDisplay: nil) else { return nil }
        return buffer
    }
    
    func doThingsWithFaces() {
        guard let getNewFrame = getNewFrame() else { return }
        
        DispatchQueue.main.sync {
            let request = VNDetectFaceRectanglesRequest { request, error in
                if let fail = error {
                    print("Ошибка VNDetectFaceRectanglesRequest:", fail)
                    return
                }
                
                if request.results?.count == 0 {
                    print("Not see faces on AVPlayer")
                } else {
                    // print("Face count on imageView: \(request.results!.count)")
                    
                    request.results?.forEach({ result in
                        DispatchQueue.main.async {
                            guard let face = result as? VNFaceObservation else { return }
                            
                            let x = face.boundingBox.origin.x * self.self.playerLayer.frame.width
                            let width = face.boundingBox.size.width * self.self.playerLayer.frame.width
                            let height = face.boundingBox.size.height * self.self.playerLayer.frame.height
                            let y = self.self.playerLayer.frame.maxY - (face.boundingBox.origin.y * self.self.playerLayer.frame.height) - height
                            
                            // Выделение области предполагаемого лица
                            self.viewFaceAV.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 0.5)
                            self.viewFaceAV.frame = CGRect(x: x, y: y, width: width, height: height)
                        }
                    })
                }
            }
            
            DispatchQueue.main.async {
                let handler = VNImageRequestHandler(cvPixelBuffer: getNewFrame)
                do {
                    try handler.perform([request])
                }
                catch let error {
                    print("Ошибка VNImageRequestHandler:", error)
                }
            }
        }
    }
    
    // https://www.hackingwithswift.com/whats-new-in-ios-11
    func ImageCVPixelBuffer(from newImage: UIImage) -> CVPixelBuffer? {
         let attrs = [kCVPixelBufferCGImageCompatibilityKey: kCFBooleanTrue, kCVPixelBufferCGBitmapContextCompatibilityKey: kCFBooleanTrue] as CFDictionary
         var pixelBuffer: CVPixelBuffer?
         let status = CVPixelBufferCreate(kCFAllocatorDefault, Int(newImage.size.width), Int(newImage.size.height), kCVPixelFormatType_32ARGB, attrs, &pixelBuffer)
         guard (status == kCVReturnSuccess) else { return nil }
        
         CVPixelBufferLockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))
         let pixelData = CVPixelBufferGetBaseAddress(pixelBuffer!)

         let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
         let context = CGContext(data: pixelData, width: Int(newImage.size.width), height: Int(newImage.size.height), bitsPerComponent: 8, bytesPerRow: CVPixelBufferGetBytesPerRow(pixelBuffer!), space: rgbColorSpace, bitmapInfo: CGImageAlphaInfo.noneSkipFirst.rawValue)

         context?.translateBy(x: 0, y: newImage.size.height)
         context?.scaleBy(x: 1.0, y: -1.0)

         UIGraphicsPushContext(context!)
         newImage.draw(in: CGRect(x: 0, y: 0, width: newImage.size.width, height: newImage.size.height))
         UIGraphicsPopContext()
         CVPixelBufferUnlockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))
         return pixelBuffer
    }
}
