//
//  LightningTests
//
//  Created by 0 on 27.02.19.
//  Copyright © 2019 Zap. All rights reserved.
//

@testable import Lightning
import XCTest

// swiftlint:disable force_unwrapping

class LndConnectURLTests: XCTestCase {
    private enum TestData {
        static let host = URL(string: "192.168.1.4:10009")!

        static let certificate = """
-----BEGIN CERTIFICATE-----
MIICiDCCAi+gAwIBAgIQdo5v0QBXHnji4hRaeeMjNDAKBggqhkjOPQQDAjBHMR8w
HQYDVQQKExZsbmQgYXV0b2dlbmVyYXRlZCBjZXJ0MSQwIgYDVQQDExtKdXN0dXNz
LU1hY0Jvb2stUHJvLTMubG9jYWwwHhcNMTgwODIzMDU1ODEwWhcNMTkxMDE4MDU1
ODEwWjBHMR8wHQYDVQQKExZsbmQgYXV0b2dlbmVyYXRlZCBjZXJ0MSQwIgYDVQQD
ExtKdXN0dXNzLU1hY0Jvb2stUHJvLTMubG9jYWwwWTATBgcqhkjOPQIBBggqhkiO
PQMBBwNCAASFhRm+w/T10PoKtg4lm9hBNJjJD473fkzHwPUFwy91vTrQSf7543j2
JrgFo8mbTV0VtpgqkfK1IMVKMLrF21xio4H8MIH5MA4GA1UdDwEB/wQEAwICpDAP
BgNVHRMBAf8EBTADAQH/MIHVBgNVHREEgc0wgcqCG0p1c3R1c3MtTWFjQm9vay1Q
cm8tMy5sb2NhbIIJbG9jYWxob3N0ggR1bml4ggp1bml4cGFja2V0hwR/AAABhxAA
AAAAAAAAAAAAAAAAAAABhxD+gAAAAAAAAAAAAAAAAAABhxD+gAAAAAAAAAwlc9Zc
k7bDhwTAqAEEhxD+gAAAAAAAABiNp//+GxXGhxD+gAAAAAAAAKWJ5tliDORjhwQK
DwAChxD+gAAAAAAAAG6Wz//+3atFhxD92tDQyv4TAQAAAAAAABAAMAoGCCqGSM49
BAMCA0cAMEQCIA9O9xtazmdxCKj0MfbFHVBq5I7JMnOFPpwRPJXQfrYaAiBd5NyJ
QCwlSx5ECnPOH5sRpv26T8aUcXbmynx9CoDufA==
-----END CERTIFICATE-----

"""

        static let macaroon = Data(base64Encoded: "AgEDbG5kArsBAwoQ3/I9f6kgSE6aUPd85lWpOBIBMBoWCgdhZGRyZXNzEgRyZWFkEgV3cml0ZRoTCgRpbmZvEgRyZWFkEgV32ml0ZRoXCghpbnZvaWNlcxIEcmVhZBIFd3JpdGUaFgoHbWVzc2FnZRIEcmVhZBIFd3JpdGUaFwoIb2ZmY2hhaW4SBHJlYWQSBXdyaXRlGhYKB29uY2hhaW4SBHJlYWQSBXdyaXRlGhQKBXBlZXJzEgRyZWFkEgV3cml0ZQAABiAiUTBv3Eh6iDbdjmXCfNxp4HBEcOYNzXhrm+ncLHf5jA==")!.hexadecimalString
    }

    func testParsing() {
        let urlString = "lndconnect://192.168.1.4:10009?cert=MIICiDCCAi-gAwIBAgIQdo5v0QBXHnji4hRaeeMjNDAKBggqhkjOPQQDAjBHMR8wHQYDVQQKExZsbmQgYXV0b2dlbmVyYXRlZCBjZXJ0MSQwIgYDVQQDExtKdXN0dXNzLU1hY0Jvb2stUHJvLTMubG9jYWwwHhcNMTgwODIzMDU1ODEwWhcNMTkxMDE4MDU1ODEwWjBHMR8wHQYDVQQKExZsbmQgYXV0b2dlbmVyYXRlZCBjZXJ0MSQwIgYDVQQDExtKdXN0dXNzLU1hY0Jvb2stUHJvLTMubG9jYWwwWTATBgcqhkjOPQIBBggqhkiOPQMBBwNCAASFhRm-w_T10PoKtg4lm9hBNJjJD473fkzHwPUFwy91vTrQSf7543j2JrgFo8mbTV0VtpgqkfK1IMVKMLrF21xio4H8MIH5MA4GA1UdDwEB_wQEAwICpDAPBgNVHRMBAf8EBTADAQH_MIHVBgNVHREEgc0wgcqCG0p1c3R1c3MtTWFjQm9vay1Qcm8tMy5sb2NhbIIJbG9jYWxob3N0ggR1bml4ggp1bml4cGFja2V0hwR_AAABhxAAAAAAAAAAAAAAAAAAAAABhxD-gAAAAAAAAAAAAAAAAAABhxD-gAAAAAAAAAwlc9Zck7bDhwTAqAEEhxD-gAAAAAAAABiNp__-GxXGhxD-gAAAAAAAAKWJ5tliDORjhwQKDwAChxD-gAAAAAAAAG6Wz__-3atFhxD92tDQyv4TAQAAAAAAABAAMAoGCCqGSM49BAMCA0cAMEQCIA9O9xtazmdxCKj0MfbFHVBq5I7JMnOFPpwRPJXQfrYaAiBd5NyJQCwlSx5ECnPOH5sRpv26T8aUcXbmynx9CoDufA&macaroon=AgEDbG5kArsBAwoQ3_I9f6kgSE6aUPd85lWpOBIBMBoWCgdhZGRyZXNzEgRyZWFkEgV3cml0ZRoTCgRpbmZvEgRyZWFkEgV32ml0ZRoXCghpbnZvaWNlcxIEcmVhZBIFd3JpdGUaFgoHbWVzc2FnZRIEcmVhZBIFd3JpdGUaFwoIb2ZmY2hhaW4SBHJlYWQSBXdyaXRlGhYKB29uY2hhaW4SBHJlYWQSBXdyaXRlGhQKBXBlZXJzEgRyZWFkEgV3cml0ZQAABiAiUTBv3Eh6iDbdjmXCfNxp4HBEcOYNzXhrm-ncLHf5jA"
        let url = URL(string: urlString)!
        let lndConnectURL = LndConnectURL(url: url)

        XCTAssertEqual(lndConnectURL?.rpcCredentials.host, TestData.host)
        XCTAssertEqual(lndConnectURL?.rpcCredentials.certificate, TestData.certificate)
        XCTAssertEqual(lndConnectURL?.rpcCredentials.macaroon.hexadecimalString, TestData.macaroon)

    }

    func testParsingZapConnect() {
        let zapConnectString = "{\"c\":\"MIICiDCCAi+gAwIBAgIQdo5v0QBXHnji4hRaeeMjNDAKBggqhkjOPQQDAjBHMR8wHQYDVQQKExZsbmQgYXV0b2dlbmVyYXRlZCBjZXJ0MSQwIgYDVQQDExtKdXN0dXNzLU1hY0Jvb2stUHJvLTMubG9jYWwwHhcNMTgwODIzMDU1ODEwWhcNMTkxMDE4MDU1ODEwWjBHMR8wHQYDVQQKExZsbmQgYXV0b2dlbmVyYXRlZCBjZXJ0MSQwIgYDVQQDExtKdXN0dXNzLU1hY0Jvb2stUHJvLTMubG9jYWwwWTATBgcqhkjOPQIBBggqhkiOPQMBBwNCAASFhRm+w/T10PoKtg4lm9hBNJjJD473fkzHwPUFwy91vTrQSf7543j2JrgFo8mbTV0VtpgqkfK1IMVKMLrF21xio4H8MIH5MA4GA1UdDwEB/wQEAwICpDAPBgNVHRMBAf8EBTADAQH/MIHVBgNVHREEgc0wgcqCG0p1c3R1c3MtTWFjQm9vay1Qcm8tMy5sb2NhbIIJbG9jYWxob3N0ggR1bml4ggp1bml4cGFja2V0hwR/AAABhxAAAAAAAAAAAAAAAAAAAAABhxD+gAAAAAAAAAAAAAAAAAABhxD+gAAAAAAAAAwlc9Zck7bDhwTAqAEEhxD+gAAAAAAAABiNp//+GxXGhxD+gAAAAAAAAKWJ5tliDORjhwQKDwAChxD+gAAAAAAAAG6Wz//+3atFhxD92tDQyv4TAQAAAAAAABAAMAoGCCqGSM49BAMCA0cAMEQCIA9O9xtazmdxCKj0MfbFHVBq5I7JMnOFPpwRPJXQfrYaAiBd5NyJQCwlSx5ECnPOH5sRpv26T8aUcXbmynx9CoDufA==\",\"m\":\"AgEDbG5kArsBAwoQ3/I9f6kgSE6aUPd85lWpOBIBMBoWCgdhZGRyZXNzEgRyZWFkEgV3cml0ZRoTCgRpbmZvEgRyZWFkEgV32ml0ZRoXCghpbnZvaWNlcxIEcmVhZBIFd3JpdGUaFgoHbWVzc2FnZRIEcmVhZBIFd3JpdGUaFwoIb2ZmY2hhaW4SBHJlYWQSBXdyaXRlGhYKB29uY2hhaW4SBHJlYWQSBXdyaXRlGhQKBXBlZXJzEgRyZWFkEgV3cml0ZQAABiAiUTBv3Eh6iDbdjmXCfNxp4HBEcOYNzXhrm+ncLHf5jA==\",\"ip\":\"192.168.1.4:10009\"}"

        let zapConnect = ZapconnectQRCode(json: zapConnectString)

        XCTAssertEqual(zapConnect?.rpcCredentials.host, TestData.host)
        XCTAssertEqual(zapConnect?.rpcCredentials.certificate, TestData.certificate)
        XCTAssertEqual(zapConnect?.rpcCredentials.macaroon.hexadecimalString, TestData.macaroon)
    }
}
