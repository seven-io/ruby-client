# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## About this Repository

This is the official Ruby client library for the seven.io SMS/Voice API. The gem provides a structured interface for accessing all seven.io API endpoints including SMS, voice calls, balance checking, analytics, and account management.

## Development Commands

### Testing
- `bundle exec rspec` - Run all tests
- `SEVEN_API_KEY=your_key bundle exec rspec` - Run tests with API key for integration testing
- `SEVEN_TEST_HTTP=1 bundle exec rspec` - Enable live API testing (requires valid API key)
- `SEVEN_DEBUG=1 bundle exec rspec` - Enable debug output showing API requests/responses

### Building and Release
- `bundle exec rake build` - Build the gem package
- `bundle exec rake spec` - Run RSpec tests (default task)
- `bundle exec rake changelog` - Generate CHANGELOG.md from git history
- `bundle exec rake install:local` - Build and install gem locally

## Architecture Overview

### Core Structure
The library follows a resource-based architecture pattern:

1. **Base Resource Class (`lib/seven_api/resource.rb`)**: 
   - Common HTTP client functionality using Faraday
   - Authentication handling (API key or Bearer token)
   - Request/response processing with JSON parsing
   - Base URL: `https://gateway.seven.io/api/`

2. **Resource Classes (`lib/seven_api/resources/`)**: 
   - Each API endpoint has a corresponding resource class (SMS, Voice, Balance, etc.)
   - All inherit from `SevenApi::Resource`
   - Define their endpoint path and supported HTTP methods
   - Example: `SevenApi::Resources::Sms` handles `/sms` endpoint

3. **Client Class (`lib/seven_api/client.rb`)**:
   - Dynamically creates instances of all resource classes
   - Provides unified access point: `client.Sms`, `client.Balance`, etc.
   - Uses reflection to discover all resource classes

### Key Patterns

- **Endpoint Definition**: Each resource defines `@endpoint` and `@http_methods` class variables
- **Method Naming**: API operations use descriptive names (`retrieve`, `delete`, `send`)
- **Parameter Handling**: Boolean values are converted to numbered format (0/1) for API compatibility
- **Error Handling**: HTTP errors raise exceptions with status codes
- **Testing**: Supports both mocked tests (default) and live API testing via environment variables

### Authentication
- API Key: Set via `X-Api-Key` header
- Bearer Token: Set via `Authorization` header (when key starts with "Bearer ")
- HMAC Signing: Optional SHA256 HMAC request signing for enhanced security

### HMAC Request Signing
When an HMAC secret is provided, requests are automatically signed using SHA256 HMAC:
- **Signature Headers**: `X-Timestamp` (Unix timestamp) and `X-Signature` (HMAC-SHA256 hex digest)
- **Signature Data**: Concatenation of HTTP method, full path, JSON payload, and timestamp
- **Usage**: Pass `signing_secret` as third parameter to Resource constructor or Client constructor

### Environment Variables
- `SEVEN_API_KEY`: Required for API access
- `SEVEN_SIGNING_SECRET`: Optional HMAC secret for request signing
- `SEVEN_DEBUG=1`: Enable request/response logging (includes signature data when HMAC is used)
- `SEVEN_TEST_HTTP=1`: Use live API for tests instead of mocks

This architecture allows easy extension of new API endpoints by creating new resource classes following the established pattern.