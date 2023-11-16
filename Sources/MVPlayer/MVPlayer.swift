// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI
import VideoPlayer

struct MVPlayer: View {
    
    @State private var isPortrait: Bool = true
    @State private var isLoading: Bool = true
    
    var body: some View {
        VideoPlayer(url: URL(string: "https://rr1---sn-8qj-i5ozr.googlevideo.com/videoplayback?expire=1700169310&ei=_jFWZbSUE9CDvcAPgt-qkAo&ip=14.177.103.248&id=o-ANiqSDFVUwkWOpdY7nb04mkik9mBYuR21m3icnODx8Ei&itag=137&source=youtube&requiressl=yes&mh=JN&mm=31%2C29&mn=sn-8qj-i5ozr%2Csn-8qj-i5ody&ms=au%2Crdu&mv=m&mvi=1&pcm2cms=yes&pl=24&initcwndbps=1265000&vprv=1&svpuc=1&mime=video%2Fmp4&gir=yes&clen=19329502&dur=157.782&lmt=1696899168742842&mt=1700147374&fvip=6&keepalive=yes&fexp=24007246&beids=24350018&c=IOS&txp=5535434&sparams=expire%2Cei%2Cip%2Cid%2Citag%2Csource%2Crequiressl%2Cvprv%2Csvpuc%2Cmime%2Cgir%2Cclen%2Cdur%2Clmt&sig=ANLwegAwRAIgDAYFSF6c8XpgT72VrGWrRx-TNqnr3SaV7-8db8ugxN8CIF-Kb3SP1a8wJPa1DnWUfQV7voMSsAag3C1Kg3-x4QBY&lsparams=mh%2Cmm%2Cmn%2Cms%2Cmv%2Cmvi%2Cpcm2cms%2Cpl%2Cinitcwndbps&lsig=AM8Gb2swRQIgOLx_fZ9dNrxjf0sZMYT08lP24cEzdXMIqfJ85o-Hc3gCIQCZZUzsfrs_fbkhvnbuTzDeqUfBe-YuqiG3kTC7ycBXPw%3D%3D")!, play: .constant(true))
            .onStateChanged { state in
                switch state {
                case .loading:
                    print("---- debug ---- loading")
                    isLoading = true
                case .playing(let totalDuration):
                    print("---- debug ---- totalDuration = \(totalDuration)")
                case .paused(let playProgress, let bufferProgress):
                    print("---- debug ---- playProgress = \(playProgress), bufferProgress =. \(bufferProgress)")
                case .error(let error):
                    print("---- debug ---- error =. ", error)
                }
            }
            .modifier(ConditionalModifier(isPortrait: isPortrait))
            .overlay(alignment: .center, content: {
                if isLoading {
                    Image("loading")
                }
            })
            .background(Color.black)
            .ignoresSafeArea()
            .onAppear {
                // Check the initial orientation
                isPortrait = UIScreen.main.bounds.width < UIScreen.main.bounds.height
            }
            .onRotate { newOrientation in
                // Handle orientation change
                isPortrait = newOrientation.isPortrait
            }
    }
}

struct ConditionalModifier: ViewModifier {
    let isPortrait: Bool
    let width = UIScreen.main.bounds.width
    
    @ViewBuilder
    func body(content: Content) -> some View {
        if isPortrait {
            content.frame(width: width, height: width * 2.75/4)
                .position(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2)
        } else {
            content.edgesIgnoringSafeArea(.all)
        }
    }
}

struct MVPlayer_Previews: PreviewProvider {
    static var previews: some View {
        MVPlayer()
    }
}

struct DeviceRotationViewModifier: ViewModifier {
    let action: (UIDeviceOrientation) -> Void
    
    func body(content: Content) -> some View {
        content
            .onAppear()
            .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
                action(UIDevice.current.orientation)
            }
    }
}

extension View {
    func onRotate(perform action: @escaping (UIDeviceOrientation) -> Void) -> some View {
        self.modifier(DeviceRotationViewModifier(action: action))
    }
}
