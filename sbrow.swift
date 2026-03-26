import Foundation
import CoreServices

let browsers: [String: String] = [
    "chrome": "com.google.chrome",
    "safari": "com.apple.safari"
]

let reverseLookup: [String: String] = [
    "com.google.chrome": "chrome",
    "com.apple.safari": "safari"
]

guard CommandLine.arguments.count > 1 else {
    if let current = LSCopyDefaultHandlerForURLScheme("https" as CFString)?.takeRetainedValue() as String? {
        print(reverseLookup[current] ?? current)
    } else {
        print("unknown")
    }
    exit(0)
}

let arg = CommandLine.arguments[1].lowercased()

if arg == "help" {
    print("sbrow              show current default browser")
    print("sbrow chrome       set default browser to Chrome")
    print("sbrow safari       set default browser to Safari")
    exit(0)
}

let name = arg

guard let bundleId = browsers[name] else {
    print("Unknown browser: \(name)")
    print("Supported: chrome, safari")
    exit(1)
}

let schemes = ["http", "https"]
for scheme in schemes {
    LSSetDefaultHandlerForURLScheme(scheme as CFString, bundleId as CFString)
}

LSSetDefaultRoleHandlerForContentType("public.html" as CFString, .all, bundleId as CFString)
LSSetDefaultRoleHandlerForContentType("public.xhtml" as CFString, .all, bundleId as CFString)

print("Default browser set to \(name)")
