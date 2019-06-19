import Foundation

public enum PactMockServiceAPI: EndPointURLSettable {

  static var url: String = "http://localhost"
  static var port: Int = 1234
  static var enableNetworkLogging: Bool = false

  case clean
  case setup([String: Any])
  case verify
  case write([String: [String: String]])

}

extension PactMockServiceAPI: EndPointType {

  var networkLogging: Bool {
    return PactMockServiceAPI.enableNetworkLogging
  }

  var baseURL: URL {
    guard let url = URL(string: "\(PactMockServiceAPI.url):\(PactMockServiceAPI.port)") else {
      fatalError("baseURL could not be configured")
    }
    return url
  }

  var path: String {
    switch self {
    case .clean,
         .setup:
      return "/interactions"
    case .verify:
      return "/interactions/verification"
    case .write:
      return "/pact"
    }
  }

  var httpMethod: HTTPMethod {
    switch self {
    case .clean:
      return .delete
    case .setup:
      return .put
    case .verify:
      return .get
    case .write:
      return .post
    }
  }

  var task: HTTPTask {
    switch self {
    case .setup(let parameters):
      return .requestWithParameters(bodyParameters: parameters,
                                          urlParameters: nil,
                                          additionHeaders: self.headers)

    case .write(let nestedParameters):
      return .requestWithParameters(bodyParameters: nestedParameters,
                                          urlParameters: nil,
                                          additionHeaders: self.headers)

    default:
      return .request
    }
  }

  var headers: HTTPHeaders? {
    return ["X-Pact-Mock-Service": "true"]
  }

}