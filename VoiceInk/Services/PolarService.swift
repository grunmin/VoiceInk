import Foundation
import IOKit

class PolarService {
    // Simplified service - no actual API calls needed for open source version
    private let organizationId = "Org"
    private let apiToken = "Token"
    private let baseURL = "https://api.polar.sh"
    
    struct LicenseValidationResponse: Codable {
        let status: String
        let limit_activations: Int?
        let id: String?
        let activation: ActivationResponse?
    }
    
    struct ActivationResponse: Codable {
        let id: String
    }
    
    struct ActivationRequest: Codable {
        let key: String
        let organization_id: String
        let label: String
        let meta: [String: String]
    }
    
    struct ActivationResult: Codable {
        let id: String
        let license_key: LicenseKeyInfo
    }
    
    struct LicenseKeyInfo: Codable {
        let limit_activations: Int
        let status: String
    }

    // Generate a unique device identifier
    private func getDeviceIdentifier() -> String {
        // Use the macOS serial number or a generated UUID that persists
        if let serialNumber = getMacSerialNumber() {
            return serialNumber
        }
        
        // Fallback to a stored UUID if we can't get the serial number
        let defaults = UserDefaults.standard
        if let storedId = defaults.string(forKey: "VoiceInkDeviceIdentifier") {
            return storedId
        }
        
        // Create and store a new UUID if none exists
        let newId = UUID().uuidString
        defaults.set(newId, forKey: "VoiceInkDeviceIdentifier")
        return newId
    }
    
    // Try to get the Mac serial number
    private func getMacSerialNumber() -> String? {
        let platformExpert = IOServiceGetMatchingService(kIOMainPortDefault, IOServiceMatching("IOPlatformExpertDevice"))
        if platformExpert == 0 { return nil }
        
        defer { IOObjectRelease(platformExpert) }
        
        if let serialNumber = IORegistryEntryCreateCFProperty(platformExpert, "IOPlatformSerialNumber" as CFString, kCFAllocatorDefault, 0) {
            return (serialNumber.takeRetainedValue() as? String)?.trimmingCharacters(in: .whitespacesAndNewlines)
        }
        
        return nil
    }
    
    // Always return successful validation for open source version
    func checkLicenseRequiresActivation(_ key: String) async throws -> (isValid: Bool, requiresActivation: Bool, activationsLimit: Int?) {
        // Simulate API delay
        try await Task.sleep(nanoseconds: 200_000_000) // 0.2 seconds
        
        // Always return valid and no activation required
        return (isValid: true, requiresActivation: false, activationsLimit: nil)
    }
    
    // Always return successful activation for open source version
    func activateLicenseKey(_ key: String) async throws -> (activationId: String, activationsLimit: Int) {
        // Simulate API delay
        try await Task.sleep(nanoseconds: 200_000_000) // 0.2 seconds
        
        // Return mock activation data
        let mockActivationId = UUID().uuidString
        return (activationId: mockActivationId, activationsLimit: 0)
    }
    
    // Always return successful validation for open source version
    func validateLicenseKeyWithActivation(_ key: String, activationId: String) async throws -> Bool {
        // Simulate API delay
        try await Task.sleep(nanoseconds: 200_000_000) // 0.2 seconds
        
        // Always return valid
        return true
    }
}

enum LicenseError: Error, LocalizedError {
    case activationFailed
    case validationFailed
    case activationLimitReached
    case activationNotRequired
    
    var errorDescription: String? {
        switch self {
        case .activationFailed:
            return "Failed to activate license on this device."
        case .validationFailed:
            return "License validation failed."
        case .activationLimitReached:
            return "This license has reached its maximum number of activations."
        case .activationNotRequired:
            return "This license does not require activation."
        }
    }
}