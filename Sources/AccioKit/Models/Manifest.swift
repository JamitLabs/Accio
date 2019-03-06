import Foundation

struct Manifest {
    let projectName: String
    let frameworksPerTarget: [String: [Framework]]
}
