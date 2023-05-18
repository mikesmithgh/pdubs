import Foundation
import AppKit

@main
public struct pdubs {
    
    public static func main() {
        let arguments = CommandLine.arguments
        
        var pid = ProcessInfo.processInfo.processIdentifier
        if arguments.count > 1 {
            pid = Int32(arguments[1]) ?? -1
        }
        
        var parentWindows: [[String: Any]] = []
        
        while pid > 0 && parentWindows.isEmpty {
            let onScreenWindows = CGWindowListCopyWindowInfo(.optionOnScreenOnly, kCGNullWindowID) as! [[String: Any]]
            parentWindows = onScreenWindows.filter{ w in
                return (w[kCGWindowOwnerPID as String] as? pid_t) == pid
            }
            
            if !parentWindows.isEmpty {
                do {
                    var formatting: JSONSerialization.WritingOptions = [
                        .prettyPrinted
                    ]
                    
                    if #available(macOS 10.13, *) {
                        formatting.insert(.sortedKeys)
                    }
                    
                    if #available(macOS 10.15, *) {
                        formatting.insert(.withoutEscapingSlashes)
                    }
                    let jsonData = try JSONSerialization.data(withJSONObject: parentWindows, options: formatting)
                    
                    if let jsonString = String(data: jsonData, encoding: .utf8) {
                        print(jsonString)
                    }
                } catch {
                    print("Error converting array to JSON: \(error.localizedDescription)")
                }
            }
            
            pid = getParentPID(forPID: pid) ?? -1
        }
    }
    
    private static func getParentPID(forPID pid: Int32) -> Int32? {
        var mib: [Int32] = [CTL_KERN, KERN_PROC, KERN_PROC_PID, pid]
        var info: kinfo_proc = kinfo_proc()
        var size = MemoryLayout<kinfo_proc>.stride
        
        let result = sysctl(&mib, u_int(mib.count), &info, &size, nil, 0)
        if result == 0 {
            let parentPID = info.kp_eproc.e_ppid
            return parentPID
        } else {
            return nil
        }
    }
}
