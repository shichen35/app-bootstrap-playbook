// Draws a 1024×1024 iOS app icon without alpha (App Store requirement) and writes it into the
// asset catalog. Replace drawArtwork(in:) with your own artwork; iOS masks the corners and adds
// Liquid Glass itself, so draw full-bleed.
// Usage: swift tools/make-icon.swift [output.png]   (run from the repository root)
import AppKit

let output = CommandLine.arguments.dropFirst().first ?? "MyApp/Assets.xcassets/AppIcon.appiconset/AppIcon.png"
let size: CGFloat = 1024

func drawArtwork(in rect: NSRect) {
    NSGradient(colors: [
        NSColor(srgbRed: 0.11, green: 0.36, blue: 0.85, alpha: 1),
        NSColor(srgbRed: 0.05, green: 0.62, blue: 0.80, alpha: 1),
    ])!.draw(in: rect, angle: 60)
    NSColor.white.setFill()
    NSBezierPath(roundedRect: rect.insetBy(dx: 220, dy: 300), xRadius: 70, yRadius: 70).fill()
}

// Draw with alpha (bitmap contexts need it), then flatten into an opaque context.
let rep = NSBitmapImageRep(
    bitmapDataPlanes: nil, pixelsWide: Int(size), pixelsHigh: Int(size), bitsPerSample: 8, samplesPerPixel: 4,
    hasAlpha: true, isPlanar: false, colorSpaceName: .deviceRGB, bytesPerRow: 0, bitsPerPixel: 0)!
NSGraphicsContext.saveGraphicsState()
NSGraphicsContext.current = NSGraphicsContext(bitmapImageRep: rep)
drawArtwork(in: NSRect(x: 0, y: 0, width: size, height: size))
NSGraphicsContext.restoreGraphicsState()
let opaque = CGContext(
    data: nil, width: Int(size), height: Int(size), bitsPerComponent: 8, bytesPerRow: 0,
    space: CGColorSpace(name: CGColorSpace.sRGB)!, bitmapInfo: CGImageAlphaInfo.noneSkipLast.rawValue)!
opaque.draw(rep.cgImage!, in: CGRect(x: 0, y: 0, width: size, height: size))
try NSBitmapImageRep(cgImage: opaque.makeImage()!).representation(using: .png, properties: [:])!
    .write(to: URL(fileURLWithPath: output))
print("Wrote \(output)")
