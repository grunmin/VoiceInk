import SwiftUI

struct LicenseView: View {
    @StateObject private var licenseViewModel = LicenseViewModel()
    
    var body: some View {
        VStack(spacing: 15) {
            Text("License Status")
                .font(.headline)
            
            // Always show licensed status since app is open source
            VStack(spacing: 10) {
                HStack {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.green)
                        .font(.system(size: 20))
                    Text("Open Source Version - All Features Unlocked")
                        .foregroundColor(.green)
                        .font(.subheadline)
                }
                
                Text("This is the open source version of VoiceInk with all premium features available.")
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                
                Button(action: {
                    if let url = URL(string: "https://github.com/Beingpax/VoiceInk") {
                        NSWorkspace.shared.open(url)
                    }
                }) {
                    Text("View on GitHub")
                        .font(.caption)
                }
                .buttonStyle(.link)
            }
        }
        .padding()
    }
}

struct LicenseView_Previews: PreviewProvider {
    static var previews: some View {
        LicenseView()
    }
} 