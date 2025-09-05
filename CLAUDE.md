# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

**Your Car Your Way** is an academic project for a car rental application architecture design. The project consists of business analysis, technical architecture definition, and proof-of-concept development.

### Project Structure

- `/data/` - Database initialization scripts and sample data
- `/etape_1/` - Initial project phase documentation  
- `/etape_2/poc-chat/` - Spring Boot chat proof-of-concept application
- `/livrables/` - Main project deliverables (business requirements, architecture docs)
- `/scenario/` - Project context and scenario description

## Database Setup Commands

### PostgreSQL Setup
```powershell
# Setup with local PostgreSQL
$PGHOST = "localhost"; $PGPORT = 5432; $PGUSER = "ycw_user"; $PGDB = "ycw"
psql -h $PGHOST -p $PGPORT -U $PGUSER -d $PGDB -f "data/postgres/001_init_schema.sql"
psql -h $PGHOST -p $PGPORT -U $PGUSER -d $PGDB -f "data/postgres/002_seed.sql"

# Setup with Docker container
Get-Content "data/postgres/001_init_schema.sql" | docker exec -i postgres psql -U postgres -d ycw
Get-Content "data/postgres/002_seed.sql" | docker exec -i postgres psql -U postgres -d ycw
```

### MongoDB Setup
```powershell
# Import sample conversations
mongoimport --uri "mongodb://localhost:27017" --db ycw --collection conversations --file "data/mongodb/conversations.sample.json" --jsonArray

# Import with EXTJSON format (recommended with validator)
mongoimport --uri "mongodb://localhost:27017" --db ycw --collection conversations --file "data/mongodb/conversations.sample.extjson.json" --jsonArray

# Enable schema validator (optional)
mongosh --nodb --file "data/mongodb/enable_validator.js"
```

## PoC Chat Application (Spring Boot + Frontend)

### Backend (Spring Boot)
```bash
cd etape_2/poc-chat/backend
mvn clean install
mvn spring-boot:run
```

The backend runs on port 8080 and connects to MongoDB at `mongodb://localhost:27017/ycw_chat_poc`.

### Frontend (Static Files with pnpm serve)
```bash
cd etape_2/poc-chat/frontend
pnpm dlx serve -l 4200 .
```

The frontend serves on port 4200. Access the chat at: http://localhost:4200

### Testing
```bash
# Backend tests
cd etape_2/poc-chat/backend
mvn test
```

### Prerequisites
- MongoDB running on localhost:27017
- Java 17+ for backend
- Node.js/pnpm for frontend serving

## Architecture Overview

### Data Architecture
- **PostgreSQL**: Main relational data (customers, vehicles, reservations, support_ticket)
- **MongoDB**: Chat conversations with JSON schema validation
- **Hybrid approach**: Structured data in PostgreSQL, unstructured chat data in MongoDB

### Key Entities
- **Customer**: User accounts with authentication
- **Vehicle**: ACRISS-coded vehicle inventory  
- **Reservation**: Booking lifecycle management
- **Support_ticket**: Customer service requests
- **Conversations**: Real-time chat messages (MongoDB)

### Business Rules
- Reservation modifications free until 48h before start
- Cancellation refund: 100% if >7 days, 25% if <7 days
- ACRISS vehicle classification standard
- API integration for agency tools
- GDPR compliance for data management

### Functional Requirements
- User registration/authentication with email verification
- Vehicle search and reservation system
- Payment integration (test mode)
- Support via tickets and real-time chat
- API for external agency applications

### Technology Stack
- **Backend**: Spring Boot 3.2.3, Java 17
- **Database**: PostgreSQL + MongoDB hybrid
- **Real-time**: WebSocket for chat functionality
- **Architecture**: RESTful API design

## Key Configuration Files

- `etape_2/poc-chat/backend/src/main/resources/application.properties` - Spring Boot configuration
- `data/mongodb/conversations.schema.json` - MongoDB collection validator schema
- `etape_2/poc-chat/backend/pom.xml` - Maven dependencies and build configuration

## Academic Context

This is a learning project focused on:
- Software architecture design
- Database structure optimization  
- Technical requirements analysis
- Proof-of-concept development
- Stakeholder requirement validation

The project emphasizes architecture over full implementation, with the PoC demonstrating key technical concepts rather than production-ready code.