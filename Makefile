# Pixel Game Makefile
# This Makefile provides convenient commands for development and deployment

.PHONY: help build run dev clean test docker-build docker-run docker-dev install-frontend-deps build-frontend

# Default target
help: ## Show this help message
	@echo "Pixel Game - Available Commands:"
	@echo ""
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

# Go Backend Commands
build: ## Build the Go application
	@echo "Building Go application..."
	go build -o bin/pixel-game main.go

run: build ## Build and run the Go application locally
	@echo "Starting Go application..."
	./bin/pixel-game

dev: ## Run the Go application in development mode
	@echo "Starting Go application in development mode..."
	go run main.go

test: ## Run Go tests
	@echo "Running Go tests..."
	go test ./...

clean: ## Clean build artifacts
	@echo "Cleaning build artifacts..."
	rm -rf bin/
	rm -rf frontend/dist/
	rm -rf frontend/node_modules/

# Frontend Commands
install-frontend-deps: ## Install frontend dependencies
	@echo "Installing frontend dependencies..."
	cd frontend && npm install

build-frontend: install-frontend-deps ## Build the frontend
	@echo "Building frontend..."
	cd frontend && npm run build

dev-frontend: install-frontend-deps ## Run frontend development server
	@echo "Starting frontend development server..."
	cd frontend && npm run dev

# Docker Commands
docker-build: ## Build Docker image
	@echo "Building Docker image..."
	docker build -t pixel-game .

docker-run: ## Run the application using Docker Compose
	@echo "Starting application with Docker Compose..."
	docker-compose up --build

docker-dev: ## Run development environment with Docker Compose
	@echo "Starting development environment..."
	docker-compose -f docker-compose.dev.yml up --build

docker-stop: ## Stop Docker containers
	@echo "Stopping Docker containers..."
	docker-compose down
	docker-compose -f docker-compose.dev.yml down

docker-clean: ## Clean Docker containers and images
	@echo "Cleaning Docker containers and images..."
	docker-compose down -v
	docker-compose -f docker-compose.dev.yml down -v
	docker system prune -f

# Database Commands
db-setup: ## Set up the database using Docker
	@echo "Setting up database..."
	docker-compose up -d postgres
	@echo "Waiting for database to be ready..."
	sleep 10
	@echo "Database is ready!"

db-reset: ## Reset the database
	@echo "Resetting database..."
	docker-compose down -v
	docker-compose up -d postgres
	@echo "Waiting for database to be ready..."
	sleep 10
	@echo "Database has been reset!"

# Development Workflow
setup: install-frontend-deps db-setup ## Initial project setup
	@echo "Project setup complete!"
	@echo "Run 'make dev' to start the backend server"
	@echo "Run 'make dev-frontend' to start the frontend development server"

full-dev: ## Start full development environment (backend + frontend + database)
	@echo "Starting full development environment..."
	docker-compose -f docker-compose.dev.yml up -d postgres
	@echo "Waiting for database..."
	sleep 5
	@echo "Starting backend..."
	go run main.go &
	@echo "Starting frontend..."
	cd frontend && npm run dev

# Production Commands
prod-build: build-frontend build ## Build for production
	@echo "Production build complete!"

prod-run: prod-build ## Run production build
	@echo "Starting production application..."
	./bin/pixel-game

# Utility Commands
logs: ## Show Docker container logs
	docker-compose logs -f

logs-backend: ## Show backend logs
	docker-compose logs -f backend

logs-db: ## Show database logs
	docker-compose logs -f postgres

status: ## Show status of all services
	@echo "Docker containers status:"
	docker-compose ps
	@echo ""
	@echo "Docker images:"
	docker images | grep pixel-game
