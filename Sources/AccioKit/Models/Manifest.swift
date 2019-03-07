import Foundation

struct Manifest {
    let projectName: String
    let frameworksPerTarget: [Target: [Framework]]
}
