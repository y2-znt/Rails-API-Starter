# 💎 Rails API Starter 💎

## Rails 8 Production-Ready API Starter — for startups, hackathons, or clean backend projects.

![Ruby](https://img.shields.io/badge/ruby-%23CC342D.svg?style=for-the-badge&logo=ruby&logoColor=white)
![Rails](https://img.shields.io/badge/rails-%23CC0000.svg?style=for-the-badge&logo=ruby-on-rails&logoColor=white)
![Postgres](https://img.shields.io/badge/postgres-%23316192.svg?style=for-the-badge&logo=postgresql&logoColor=white)
![GitHub Actions](https://img.shields.io/badge/github%20actions-%232671E5.svg?style=for-the-badge&logo=githubactions&logoColor=white)
![JWT](https://img.shields.io/badge/JWT-black?style=for-the-badge&logo=JSON%20web%20tokens)

![Pundit](https://img.shields.io/badge/Pundit-Authorization-green)
![Minitest](https://img.shields.io/badge/Minitest-Testing-yellow)

## Features

### Authentication & Security

- **JWT-based Authentication** with secure token management
- **Role-based Authorization** using Pundit policies
- **Bcrypt Password Encryption**
- **CORS Protection** with rack-cors
- **Security-first Approach** with before_action guards

### API Architecture

- **RESTful API Design**
- **Versioned API Structure** (v1)
- **JSON Serialization** with ActiveModelSerializers
- **Policy-based Authorization** with comprehensive test coverage
- **Clean Controller Architecture** with concerns separation

### User Management

- **Complete User CRUD Operations**
- **Role Management** (Admin/User)
- **Profile Management** with the /me endpoint
- **Secure Password Reset Flow**
- **Email Validation**

### Code Quality

- **Comprehensive Test Suite** using MiniTest
  - Policy Tests
  - Controller Tests
  - Model Tests
- **Static Code Analysis** with Brakeman
- **Code Style** enforcement with Rubocop Rails Omakase
- **Automated Model Annotation** with annotaterb

### Development Tools

- **Factory Bot** for test data generation
- **Shoulda Matchers** for elegant testing
- **Debug Tools** for development
- **Annotated Models** for better documentation

## 🔪 Technical Stack

- **Ruby 3.x**
- **Rails 8.0.2**
- **PostgreSQL**
- **JWT** for stateless authentication
- **Pundit** for authorization
- **ActiveModelSerializers** for JSON serialization
- **Rack CORS** for CORS handling
- **Bcrypt** for password hashing

## 📚 API Documentation

### Authentication Endpoints

| Endpoint                | Method | Description       | Request Body                                                        | Success Response                                              | Error Response      |
| ----------------------- | ------ | ----------------- | ------------------------------------------------------------------- | ------------------------------------------------------------- | ------------------- |
| `/api/v1/auth/register` | POST   | Register new user | `{ "email": "string", "password": "string", "username": "string" }` | `201 Created` `{ "message": "User created", "token": "jwt" }` | `422 Unprocessable` |
| `/api/v1/auth/login`    | POST   | Login user        | `{ "email": "string", "password": "string" }`                       | `200 OK` `{ "token": "jwt" }`                                 | `401 Unauthorized`  |
| `/api/v1/auth/logout`   | POST   | Logout user       | -                                                                   | `204 No Content`                                              | `401 Unauthorized`  |

### User Management

| Endpoint            | Method | Auth Required | Admin Only | Description      |
| ------------------- | ------ | ------------- | ---------- | ---------------- |
| `/api/v1/users`     | GET    | Yes           | Yes        | List all users   |
| `/api/v1/users`     | POST   | Yes           | Yes        | Create user      |
| `/api/v1/users/:id` | GET    | Yes           | No\*       | Get user details |
| `/api/v1/users/:id` | PUT    | Yes           | No\*       | Update user      |
| `/api/v1/users/:id` | DELETE | Yes           | Yes        | Delete user      |

\* Users can access their own data

### Profile Management

| Endpoint     | Method | Description     | Success Response | Error Response      |
| ------------ | ------ | --------------- | ---------------- | ------------------- |
| `/api/v1/me` | GET    | Get own profile | `200 OK`         | `401 Unauthorized`  |
| `/api/v1/me` | PATCH  | Update profile  | `204 No Content` | `422 Unprocessable` |
| `/api/v1/me` | DELETE | Delete account  | `204 No Content` | `401 Unauthorized`  |

## 🧪 Testing

```bash
# Run all tests
rails test

# Run specific test file
rails test test/models/user_test.rb

# Run specific test
rails test test/models/user_test.rb:42
```

### Test Structure

## 🔒 Security Features

- JWT token-based authentication
- Password encryption with BCrypt
- Role-based access control
- Request authentication middleware
- CORS protection
- Comprehensive authorization policies

## 🚀 Getting Started

1. Clone the repository

```bash
git clone https://github.com/y2-znt/rails-api-starter.git
```

2. Install dependencies

```bash
bundle install
```

3. Setup database

```bash
rails db:create db:migrate
```

4. Start the server

```bash
rails server
```

## 💡 Best Practices Implemented

- **Service-Oriented Architecture**
- **DRY (Don't Repeat Yourself)** principles
- **SOLID** principles adherence
- **Comprehensive Error Handling**
- **Security-First** approach
- **Test-Driven Development**
- **Clean Code** practices

## ♾️ Continuous Integration

This project implements a robust CI pipeline using GitHub Actions with three main jobs:

### Pipeline Jobs

| Job              | Description                                | Tools Used            |
| ---------------- | ------------------------------------------ | --------------------- |
| 🔒 Security Scan | Analyzes code for security vulnerabilities | Brakeman              |
| 🎨 Lint          | Ensures consistent code style              | RuboCop Rails Omakase |
| 🧪 Test          | Runs the test suite with PostgreSQL        | Minitest              |

### Key Features

- **Automated Security Checks**: Brakeman scans for common Rails security vulnerabilities
- **Code Style Enforcement**: RuboCop ensures consistent code style across the project
- **Database Integration**: Automated testing with PostgreSQL service container
- **Artifact Storage**: Failed test screenshots are automatically stored
- **Multiple Triggers**: Runs on both pull requests and pushes to main branch

### Example Workflow

```bash
# Security Scan
bin/brakeman --no-pager

# Lint Check
bin/rubocop -f github

# Test Suite
bin/rails db:test:prepare test test:system
```

The pipeline ensures that all code changes:

- Are free from common security vulnerabilities
- Follow consistent style guidelines
- Pass all tests with a real database
- Maintain high code quality standards

---

### Built with ❤️ using Ruby on Rails 8
