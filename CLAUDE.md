# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Technology Stack
- Ruby 3.4.5 (managed with asdf)
- Rails 8.0.3
- PostgreSQL database
- Puma 6.x web server

## Common Development Tasks

### Running the application
```bash
rails server
```
The API will be available at http://localhost:3000

### Database commands
```bash
# Create and migrate database
rails db:create db:migrate

# Seed database with initial data
rails db:seed

# Reset database (drop, create, migrate, seed)
rails db:reset
```

### Running tests
```bash
# Run all request specs
rspec spec/requests

# Run all model specs
rspec spec/models

# Run a specific test file
rspec spec/requests/api/v1/vehicles_spec.rb

# Run tests with detailed output
rspec --format documentation
```

### Code quality checks
```bash
# Run RuboCop for code style checking
rubocop

# Auto-fix RuboCop offenses where possible
rubocop -a
```

### API Documentation
```bash
# Generate/update Swagger API documentation
rake rswag:specs:swaggerize
```
Documentation is available at http://localhost:3000/api-docs when the server is running.

## Architecture Overview

### API Structure
This is a Rails API-only application serving as the backend for the Exo Cars exotic car rental platform. The API follows RESTful conventions with versioning under `/api/v1/`.

### Authentication
- Uses JWT (JSON Web Tokens) for stateless authentication
- Token generation handled by `JsonWebToken` model in app/models/json_web_token.rb
- Authentication logic in app/controllers/authentication_controller.rb
- Protected endpoints require Authorization header with JWT token
- `authorize_request` method in ApplicationController validates tokens

### Key Models and Relationships
- **User**: Has many bookings, uses Devise for authentication with custom JWT integration
- **Vehicle**: Represents exotic cars, has many bookings and galleries (photos)
- **Booking**: Belongs to both user and vehicle, tracks rental reservations with date ranges and location
- **Gallery**: Belongs to vehicle, stores photo URLs for vehicle images

### Controllers
All API controllers inherit from `ApplicationController` which provides:
- JWT authorization via `authorize_request` method
- JSON payload parsing via `json_payload` method
- Error handling for not found resources

API endpoints are namespaced under `Api::V1::` and include:
- UsersController: User CRUD operations
- VehiclesController: Vehicle management (admin only for create/delete)
- BookingsController: Nested under both users and vehicles
- GalleriesController: Nested under vehicles for photo management
- AuthenticationController: Handles user login and JWT token generation

### Database Configuration
- Uses PostgreSQL in all environments
- Development/test databases use local PostgreSQL with credentials from environment variables
- Production uses DATABASE_URL environment variable
- Requires Figaro gem for environment variable management (config/application.yml)

### Testing Strategy
- RSpec for testing framework
- Request specs test API endpoints and responses
- Model specs test validations and associations
- Rswag generates API documentation from request specs
- Test database is recreated for each test run

### Deployment
- Configured for deployment on Render
- Uses ElephantSQL for production database
- Frontend deployed separately on Vercel