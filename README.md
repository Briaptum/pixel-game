# Pixel Game

A modern web application built with Go backend, Vue.js frontend, PostgreSQL database, and Docker containerization.

## Tech Stack

- **Backend**: Go with Gin framework
- **Frontend**: Vue.js 3 with Vite
- **Styling**: Tailwind CSS
- **Database**: PostgreSQL
- **Containerization**: Docker & Docker Compose
- **Build Tool**: Make

## Project Structure

```
pixel-game/
├── main.go                 # Go backend application
├── go.mod                  # Go module dependencies
├── Makefile               # Build and development commands
├── Dockerfile             # Production Docker image
├── docker-compose.yml     # Production Docker Compose
├── docker-compose.dev.yml # Development Docker Compose
├── database/
│   └── init.sql          # Database initialization script
└── frontend/
    ├── package.json      # Node.js dependencies
    ├── vite.config.js    # Vite configuration
    ├── tailwind.config.js # Tailwind CSS configuration
    ├── Dockerfile.dev    # Frontend development Docker image
    └── src/
        ├── App.vue       # Main Vue component
        ├── main.js       # Vue application entry point
        └── style.css     # Global styles with Tailwind
```

## Quick Start

### Prerequisites

- Go 1.21+
- Node.js 18+
- Docker & Docker Compose
- Make

### Development Setup

1. **Clone and setup the project:**
   ```bash
   make setup
   ```

2. **Start the development environment:**
   ```bash
   make full-dev
   ```

   This will start:
   - PostgreSQL database on port 5432
   - Go backend server on port 8080
   - Vue.js frontend dev server on port 3000

3. **Access the application:**
   - Frontend: http://localhost:3000 (Hello page with status cards)
   - Backend API: http://localhost:8081/api (when using Docker)
   - Health check: http://localhost:8081/api/health (when using Docker)

### Individual Commands

**Backend:**
```bash
make dev          # Run Go backend in development mode
make build        # Build Go application
make run          # Build and run Go application
```

**Frontend:**
```bash
make dev-frontend # Run Vue.js development server
make build-frontend # Build frontend for production
```

**Database:**
```bash
make db-setup     # Start PostgreSQL database
make db-reset     # Reset database with fresh data
```

**Docker:**
```bash
make docker-run   # Run full application with Docker Compose
make docker-dev   # Run development environment with Docker
make docker-stop  # Stop all Docker containers
make docker-clean # Clean Docker containers and images
```

## API Endpoints

- `GET /api/health` - Health check endpoint
- `GET /api/users` - Get all users
- `POST /api/users` - Create a new user

## Environment Variables

Create a `.env` file in the root directory:

```env
PORT=8080
DATABASE_URL=postgres://postgres:password@localhost:5432/pixelgame?sslmode=disable
GIN_MODE=debug
```

## Docker Deployment

### Production

```bash
make docker-run
```

This will:
- Build the Go application
- Build the Vue.js frontend
- Start PostgreSQL database
- Serve the application on port 8080

### Development

```bash
make docker-dev
```

This will:
- Start PostgreSQL database
- Start Vue.js development server with hot reload
- Run Go backend locally (you need to run `make dev` separately)

## Available Make Commands

Run `make help` to see all available commands:

- `make setup` - Initial project setup
- `make dev` - Run Go backend in development mode
- `make dev-frontend` - Run Vue.js frontend development server
- `make full-dev` - Start complete development environment
- `make build` - Build Go application
- `make build-frontend` - Build Vue.js frontend
- `make docker-run` - Run with Docker Compose
- `make docker-dev` - Run development environment with Docker
- `make db-setup` - Set up PostgreSQL database
- `make clean` - Clean build artifacts
- `make test` - Run Go tests

## Features

- ✅ Go backend with Gin framework
- ✅ Vue.js 3 frontend with Vite
- ✅ Tailwind CSS for styling
- ✅ PostgreSQL database integration
- ✅ Docker containerization
- ✅ Comprehensive Makefile
- ✅ Development and production configurations
- ✅ API endpoints for user management
- ✅ Responsive UI with modern design
- ✅ Hot reload for frontend development

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test your changes
5. Submit a pull request

## License

This project is open source and available under the MIT License.
# pixel-game
