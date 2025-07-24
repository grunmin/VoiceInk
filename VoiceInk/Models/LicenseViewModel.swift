import Foundation
import AppKit

@MainActor
class LicenseViewModel: ObservableObject {
    enum LicenseState: Equatable {
        case trial(daysRemaining: Int)
        case trialExpired
        case licensed
    }
    
    // Always return licensed state to remove restrictions
    @Published private(set) var licenseState: LicenseState = .licensed
    @Published var licenseKey: String = ""
    @Published var isValidating = false
    @Published var validationMessage: String?
    @Published private(set) var activationsLimit: Int = 0
    
    private let trialPeriodDays = 7
    private let polarService = PolarService()
    private let userDefaults = UserDefaults.standard
    
    init() {
        // Always set to licensed state - no restrictions
        licenseState = .licensed
    }
    
    func startTrial() {
        // No-op - always licensed
        licenseState = .licensed
        NotificationCenter.default.post(name: .licenseStatusChanged, object: nil)
    }
    
    private func loadLicenseState() {
        // Always set to licensed - bypass all checks
        licenseState = .licensed
    }
    
    // Always allow app usage - remove all restrictions
    var canUseApp: Bool {
        return true
    }
    
    func openPurchaseLink() {
        // No-op - not needed for open source version
    }
    
    func validateLicense() async {
        // Simulate successful validation
        isValidating = true
        
        // Add a small delay to make it feel realistic
        try? await Task.sleep(nanoseconds: 500_000_000) // 0.5 seconds
        
        licenseState = .licensed
        validationMessage = "License activated successfully!"
        NotificationCenter.default.post(name: .licenseStatusChanged, object: nil)
        
        isValidating = false
    }
    
    func removeLicense() {
        // Keep licensed state even when "removing" license
        licenseState = .licensed
        licenseKey = ""
        validationMessage = nil
        NotificationCenter.default.post(name: .licenseStatusChanged, object: nil)
    }
}

extension Notification.Name {
    static let licenseStatusChanged = Notification.Name("licenseStatusChanged")
}

// Add UserDefaults extensions for storing activation ID
extension UserDefaults {
    var activationId: String? {
        get { string(forKey: "VoiceInkActivationId") }
        set { set(newValue, forKey: "VoiceInkActivationId") }
    }
}
