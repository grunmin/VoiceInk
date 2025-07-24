import SwiftUI

struct LicenseManagementView: View {
    @StateObject private var licenseViewModel = LicenseViewModel()
    @Environment(\.colorScheme) private var colorScheme
    let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "Unknown"
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                // Hero Section
                heroSection
                
                // Main Content - Always show activated content since app is always licensed
                VStack(spacing: 32) {
                    activatedContent
                }
                .padding(32)
            }
        }
        .background(Color(NSColor.controlBackgroundColor))
    }
    
    private var heroSection: some View {
        VStack(spacing: 24) {
            VStack(spacing: 12) {
                HStack {
                    Image(systemName: "waveform.badge.mic")
                        .font(.system(size: 32))
                        .foregroundStyle(.blue)
                    Text("VoiceInk")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                }
                
                Text("Open Source Voice Transcription")
                    .font(.headline)
                    .foregroundColor(.secondary)
                
                Text("Version \(appVersion)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            // Open Source Badge
            VStack(spacing: 16) {
                HStack {
                    Image(systemName: "heart.fill")
                        .font(.system(size: 20))
                        .foregroundStyle(.red)
                    Text("Free & Open Source")
                        .font(.headline)
                }
                .padding(.vertical, 8)
                .padding(.horizontal, 16)
                .background(Color.red.opacity(0.1))
                .cornerRadius(12)
                
                Text("This is an open source version with all features unlocked")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                
                // GitHub and Community Links
                HStack(spacing: 24) {
                    Button {
                        if let url = URL(string: "https://github.com/Beingpax/VoiceInk") {
                            NSWorkspace.shared.open(url)
                        }
                    } label: {
                        featureItem(icon: "chevron.left.forwardslash.chevron.right", title: "GitHub", color: .purple)
                    }
                    .buttonStyle(.plain)
                    
                    Button {
                        if let url = URL(string: "https://github.com/Beingpax/VoiceInk/discussions") {
                            NSWorkspace.shared.open(url)
                        }
                    } label: {
                        featureItem(icon: "bubble.left.and.bubble.right.fill", title: "Community", color: .blue)
                    }
                    .buttonStyle(.plain)
                    
                    Button {
                        if let url = URL(string: "https://github.com/Beingpax/VoiceInk/issues") {
                            NSWorkspace.shared.open(url)
                        }
                    } label: {
                        featureItem(icon: "map.fill", title: "Issues", color: .green)
                    }
                    .buttonStyle(.plain)
                }
                .padding(.top, 8)
            }
        }
        .padding(.vertical, 60)
    }
    
    private var activatedContent: some View {
        VStack(spacing: 32) {
            // Status Card
            VStack(spacing: 24) {
                HStack {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 24))
                        .foregroundStyle(.green)
                    Text("Open Source Version")
                        .font(.headline)
                    Spacer()
                    Text("Active")
                        .font(.caption)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 4)
                        .background(Capsule().fill(.green))
                        .foregroundStyle(.white)
                }
                
                Divider()
                
                Text("All features are available in this open source version")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            .padding(32)
            .background(CardBackground(isSelected: false))
            .shadow(color: .black.opacity(0.05), radius: 10)
            
            // Features Overview
            VStack(spacing: 24) {
                Text("Available Features")
                    .font(.headline)
                
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 20) {
                    featureRow(icon: "waveform", title: "AI Transcription", description: "Advanced speech-to-text")
                    featureRow(icon: "brain.head.profile", title: "AI Enhancement", description: "Smart text processing")
                    featureRow(icon: "globe", title: "Multi-language", description: "Support for many languages")
                    featureRow(icon: "keyboard", title: "Hotkeys", description: "Quick access shortcuts")
                    featureRow(icon: "wand.and.stars", title: "Power Mode", description: "Context-aware features")
                    featureRow(icon: "chart.bar", title: "Analytics", description: "Usage metrics")
                }
            }
            .padding(32)
            .background(CardBackground(isSelected: false))
            .shadow(color: .black.opacity(0.05), radius: 10)
        }
    }
    
    private func featureItem(icon: String, title: String, color: Color) -> some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.system(size: 20))
                .foregroundStyle(color)
            Text(title)
                .font(.caption)
                .fontWeight(.medium)
        }
        .frame(width: 80)
    }
    
    private func featureRow(icon: String, title: String, description: String) -> some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 16))
                .foregroundStyle(.blue)
                .frame(width: 20)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.subheadline)
                    .fontWeight(.medium)
                Text(description)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
        }
    }
}

struct LicenseManagementView_Previews: PreviewProvider {
    static var previews: some View {
        LicenseManagementView()
    }
}


