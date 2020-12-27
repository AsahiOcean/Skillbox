import UIKit
import AVKit

func BackgroundVideo() -> UIView {
    let background = UIView()
    let path = URL(fileURLWithPath: Bundle.main.path(forResource: "background", ofType: "mov")!)
    let player = AVPlayer(url: path)
    let movie = AVPlayerLayer(player: player)
    movie.frame = UIScreen.main.bounds
    movie.videoGravity = AVLayerVideoGravity.resizeAspectFill
    player.play()
    background.layer.zPosition = -1
    background.layer.addSublayer(movie)
    return background
}
