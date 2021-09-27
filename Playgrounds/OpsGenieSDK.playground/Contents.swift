import NIOPosix
import OpsGenieSDK
import Foundation

let eventLoopGroup = MultiThreadedEventLoopGroup(numberOfThreads: 1)

let apiKey = "c8184088-b545-4a32-a438-0ab366055617"

let client = OpsGenieClient(
    apiKey: apiKey,
    baseURL: NetworkConstants.baseURL.US.rawValue,
    worker: eventLoopGroup
)

let alerts = try! client.listAlerts().wait()

print(alerts)
