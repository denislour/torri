# Torii (鳥居)

## Overview
Torii, meaning "heavenly gate" in Japanese, is a centralized authentication and authorization system built with Elixir/Phoenix.

## Architecture

### System Flow
````mermaid
graph TD
    %% Main Flow
    A[Client] --> B[Torii]
    
    B --> C[Authentication Context]
    B --> D[Authorization Context]

    %% Contexts
    subgraph Contexts
        C --> C1[Account Management]
        C1 --> C11[Login]
        C1 --> C12[Register]
        C1 --> C13[Password Reset]
        C1 --> C14[Password Change]
        C1 --> C15[Token Management]
        
        D --> D1[Role Management]
        D1 --> D11[Role Assignment]
        D1 --> D12[Permission Control]
        D1 --> D13[Role Validation]
    end

    %% Actors
    subgraph Actors
        E1[TokenManager]
        E2[RateLimiter]
        E3[SessionMonitor]
        E4[PermissionManager]
    end

    %% Database Storage
    subgraph Database Storage
        F[(PostgreSQL)]
        F --> F1[Users Table]
        F --> F2[Roles Table]
        F --> F3[User Roles Table]
    end
    
    %% Memory Storage
    subgraph Memory Storage
        G[(ETS)]
        G --> G1[Token Blacklist]
        G --> G2[Permission Cache]
        G --> G3[Session Data]
    end

    %% Connections
    C --> F1
    D --> F2
    D --> F3
    E1 --> G1
    E1 --> G3
    E2 --> G3
    E3 --> G3
    E4 --> G2
    E1 -.->|Validate|F1
    E4 -.->|Cache|F2
    E4 -.->|Cache|F3
    C11 --> E2
    C15 --> E1
    C11 --> E3
    D12 --> E4

    %% Styles
    style A fill:#f9f,stroke:#333,stroke-width:2px
    style B fill:#bbf,stroke:#333,stroke-width:2px
    style C fill:#dfd,stroke:#333,stroke-width:2px
    style C1 fill:#dfd,stroke:#333,stroke-width:2px
    style C11 fill:#dfd,stroke:#333,stroke-width:2px
    style C12 fill:#dfd,stroke:#333,stroke-width:2px
    style C13 fill:#dfd,stroke:#333,stroke-width:2px
    style C14 fill:#dfd,stroke:#333,stroke-width:2px
    style C15 fill:#dfd,stroke:#333,stroke-width:2px
    style D fill:#fdd,stroke:#333,stroke-width:2px
    style D1 fill:#fdd,stroke:#333,stroke-width:2px
    style D11 fill:#fdd,stroke:#333,stroke-width:2px
    style D12 fill:#fdd,stroke:#333,stroke-width:2px
    style D13 fill:#fdd,stroke:#333,stroke-width:2px
    style E1 fill:#ffd,stroke:#333,stroke-width:2px
    style E2 fill:#ffd,stroke:#333,stroke-width:2px
    style E3 fill:#ffd,stroke:#333,stroke-width:2px
    style E4 fill:#ffd,stroke:#333,stroke-width:2px
    style F fill:#ddf,stroke:#333,stroke-width:2px
    style F1 fill:#ddf,stroke:#333,stroke-width:2px
    style F2 fill:#ddf,stroke:#333,stroke-width:2px
    style F3 fill:#ddf,stroke:#333,stroke-width:2px
    style G fill:#dff,stroke:#333,stroke-width:2px
    style G1 fill:#dff,stroke:#333,stroke-width:2px
    style G2 fill:#dff,stroke:#333,stroke-width:2px
    style G3 fill:#dff,stroke:#333,stroke-width:2px
````

### Database Schema
````mermaid
erDiagram
    USERS ||--o{ USER_ROLES : has_many
    USERS {
        uuid id PK
        string email
        string hashed_password
        boolean is_active
        timestamp last_login
        timestamp inserted_at
        timestamp updated_at
    }
    
    ROLES ||--|{ USER_ROLES : has_many
    ROLES {
        uuid id PK
        string name
        jsonb permissions
        timestamp inserted_at
        timestamp updated_at
    }
    
    USER_ROLES {
        uuid id PK
        uuid user_id FK
        uuid role_id FK
        timestamp inserted_at
        timestamp updated_at
    }
````

## Core Features

### Authentication
- User registration
- Login/Logout
- Password reset
- Password change
- Token management

### Authorization
- Role-based access control
- Permission management
- Role validation

## Technical Stack
- Framework: Elixir/Phoenix
- Database: PostgreSQL
- Cache: ETS
- Token: JWT

## Actors
- **TokenManager**: Handles JWT operations and blacklisting
- **RateLimiter**: Controls request rates
- **SessionMonitor**: Manages user sessions
- **PermissionManager**: Handles permission caching and validation

## Requirements
- Elixir 1.14+
- Phoenix 1.7+
- PostgreSQL 13+

## Installation
[Coming soon]

## License
MIT
