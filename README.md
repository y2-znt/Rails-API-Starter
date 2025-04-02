# 💎 Rails API Starter 💎

<div align="center">

![Ruby](https://img.shields.io/badge/ruby-%23CC342D.svg?style=for-the-badge&logo=ruby&logoColor=white)
![Rails](https://img.shields.io/badge/rails-%23CC0000.svg?style=for-the-badge&logo=ruby-on-rails&logoColor=white)
![Postgres](https://img.shields.io/badge/postgres-%23316192.svg?style=for-the-badge&logo=postgresql&logoColor=white)
![Docker](https://img.shields.io/badge/docker-%230db7ed.svg?style=for-the-badge&logo=docker&logoColor=white)
![GitHub Actions](https://img.shields.io/badge/github%20actions-%232671E5.svg?style=for-the-badge&logo=githubactions&logoColor=white)
![JWT](https://img.shields.io/badge/JWT-black?style=for-the-badge&logo=JSON%20web%20tokens)

[![Build & Deploy](https://github.com/y2-znt/rails-api-starter/actions/workflows/ci.yml/badge.svg)](https://github.com/y2-znt/rails-api-starter/actions/workflows/ci.yml)

Rails 8 Production-Ready API Starter — for startups, hackathons, or clean backend projects.

[Overview](#-overview) •
[Quick Start](#-quick-start) •
[Architecture](#-architecture) •
[API Documentation](#-api-documentation) •
[Development & Testing](#-development--testing)

</div>

## 👀 Overview

### Why Choose This Starter?

- **Production-Grade Architecture**: Built with scalability and maintainability in mind
- **Modern Development Flow**: Docker-based development and deployment
- **Security First**: JWT authentication, role-based authorization, and comprehensive security measures
- **Developer Experience**: Hot-reloading, debugging tools, and extensive documentation
- **Best Practices**: SOLID principles, clean code, and comprehensive testing
- **CI/CD Ready**: GitHub Actions workflow with security scanning and automated testing

### Key Features

- 🔒 **Security**

  - JWT stateless authentication
  - Role-based authorization (Admin/User)
  - CORS protection via Rack
  - Brakeman security scans
  - Secure headers & password encryption

- 🏗️ **API Architecture**

  - RESTful API structure (v1)
  - JSON serialization with ActiveModelSerializers
  - Clean controller logic with concerns
  - Policy-based permissions

- 👥 **User Management**
  - JWT authentication flow
  - Role-based access control
  - Profile management

## 🤸‍♀️ Quick Start

### Prerequisites

- Ruby 3.3.0
- Rails 8.0.2
- PostgreSQL 14 or later
- Bundler 2.5 or later
- Docker (optional)

### Using Docker (Recommended)

```bash
# Clone the repository
git clone https://github.com/y2-znt/rails-api-starter.git

cd rails-api-starter

# Start the development environment
docker compose -f docker-compose-dev.yml up -d --build

# Setup the database and run migrations
docker compose -f docker-compose-dev.yml exec rails-api-dev bundle exec rails db:setup db:migrate

# Run tests to verify setup
docker compose -f docker-compose-dev.yml exec rails-api-dev bundle exec rails test
```

### Without Docker

```bash
# Clone the repository
git clone https://github.com/y2-znt/rails-api-starter.git

cd rails-api-starter

# Install dependencies
bundle install

# Setup database
cp config/database.yml.example config/database.yml
rails db:setup
rails db:migrate

# Run tests to verify setup
rails test

# Start the server
rails server
```

Visit `http://localhost:4000` - You're ready to go! 🎉

## 🏗️ Architecture

### Project Structure

This project follows a classic Rails API structure with a versioned `/api/v1` namespace:

- `app/controllers/api/v1`: API endpoints and business logic
- `app/models`: Active Record models and validations
- `app/policies`: Pundit authorization policies
- `app/serializers`: JSON response formatting
- `lib/`: Reusable services and utilities
- `config/`: Application configuration
- `db/`: Database migrations and schema

### Technical Stack

- **Framework**: Ruby on Rails 8 (API mode)
- **Database**: PostgreSQL 14
- **Authentication**: JWT (stateless)
- **Authorization**: Pundit
- **API Serialization**: ActiveModelSerializers
- **Development Tools**:
  - RuboCop Rails Omakase for code style
  - Annotaterb for model documentation
  - Overcommit for Git hooks
- **Security**:
  - Bcrypt for password hashing
  - Rack CORS for CORS handling
  - Brakeman for security scanning

## 📚 API Documentation

### Auth Endpoints

| Endpoint                | Method | Description       | Response (Success)        |
| ----------------------- | ------ | ----------------- | ------------------------- |
| `/api/v1/auth/register` | POST   | Register new user | `201 Created` + JWT token |
| `/api/v1/auth/login`    | POST   | Login             | `200 OK` + JWT token      |
| `/api/v1/auth/logout`   | POST   | Logout            | `204 No Content`          |

### User Endpoints

| Endpoint            | Method | Auth | Admin | Description      |
| ------------------- | ------ | ---- | ----- | ---------------- |
| `/api/v1/users`     | GET    | ✅   | ✅    | List all users   |
| `/api/v1/users`     | POST   | ✅   | ✅    | Create a user    |
| `/api/v1/users/:id` | GET    | ✅   | 🚫    | Get user details |
| `/api/v1/users/:id` | PUT    | ✅   | 🚫    | Update user      |
| `/api/v1/users/:id` | DELETE | ✅   | ✅    | Delete user      |

### Profile Management

| Endpoint     | Method | Description        | Auth | Response         |
| ------------ | ------ | ------------------ | ---- | ---------------- |
| `/api/v1/me` | GET    | Get own profile    | ✅   | `200 OK`         |
| `/api/v1/me` | PATCH  | Update profile     | ✅   | `204 No Content` |
| `/api/v1/me` | DELETE | Delete own account | ✅   | `204 No Content` |

## 🧪 Development & Testing

### Testing

We use a comprehensive testing setup:

- **MiniTest**: Main testing framework
- **FactoryBot**: Test data generation
- **Shoulda Matchers & Context**: Enhanced test assertions and contexts
- **100% test coverage goal**

```bash
# Run all tests
rails test

# Run specific tests
rails test test/models/user_test.rb
rails test test/models/user_test.rb:42
```

### Quality Tools

- **Brakeman**: Security analysis
- **RuboCop**: Code style enforcement
- **Annotate**: Model documentation
- **Bundle Audit**: Dependency scanning

```bash
# Security scan
bin/brakeman --no-pager

# Lint code
bin/rubocop -f github
```

### 🔐 Git Hooks (Overcommit)

This project uses [Overcommit](https://github.com/sds/overcommit) to enforce code quality and project consistency through Git hooks.

Before starting development, make sure to set it up properly:

```bash
# Install Git hooks
bundle exec overcommit --install

# Sign the configuration file (required once)
bundle exec overcommit --sign
```

You can also manually run all hooks:

```bash
bundle exec overcommit --run
```

The project includes the following pre-commit hooks:

- **RuboCop**: Automatically checks and corrects Ruby code style
  - Runs with `--autocorrect` flag to fix simple issues
  - Required to pass before commit
  - Uses Rails Omakase style guide

### 🔄 CI/CD Pipeline

This project includes a complete GitHub Actions pipeline:

| Stage       | Tools                  |
| ----------- | ---------------------- |
| 🔒 Security | Brakeman, Bundle Audit |
| 🎨 Lint     | RuboCop Rails Omakase  |
| 🧪 Tests    | MiniTest, PostgreSQL   |

---

<div align="center">

Built with ❤️ using Ruby on Rails 8

</div>
