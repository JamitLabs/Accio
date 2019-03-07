import Foundation

struct Manifest {
    let projectName: String
    let frameworksPerTargetName: [String: [Framework]]
}
