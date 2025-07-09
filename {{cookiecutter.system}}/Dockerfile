# Multi-stage Dockerfile for Python development with VS Code dev containers

# Stage 1: Core dependencies layer
FROM python:3.13-slim-bookworm AS dependencies

# Install system dependencies including librdkafka for Kafka support
RUN apt update \
    && apt upgrade -y \
    && apt install -y --no-install-recommends \
    libpq-dev \
    librdkafka-dev \
    && rm -rf /var/lib/apt/lists/*

# Stage 2: Builder phase
FROM dependencies AS builder

# Install build tools and compilers
RUN apt update \
    && apt install -y --no-install-recommends \
    build-essential \
    gcc \
    g++ \
    git \
    && rm -rf /var/lib/apt/lists/*

# Copy UV from the official distroless image (more secure than curl)
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/

# Set working directory
WORKDIR /app

# Copy dependency files
COPY pyproject.toml uv.lock* ./

# Install dependencies using UV
RUN uv sync --frozen --no-dev

# Stage 3: Development layer
FROM builder AS devel

# Install development tools and utilities
RUN apt update \
    && apt install -y --no-install-recommends \
    vim \
    nano \
    less \
    htop \
    tree \
    procps \
    jq \
    git \
    gpg \
    postgresql-client \
    redis-tools \
    kafkacat \
    && rm -rf /var/lib/apt/lists/*

# Install AWS CLI v2
RUN apt update \
    && apt install -y --no-install-recommends \
    curl \
    unzip \
    && curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
    && unzip awscliv2.zip \
    && ./aws/install \
    && rm -rf awscliv2.zip aws \
    && apt remove -y curl unzip \
    && apt autoremove -y \
    && rm -rf /var/lib/apt/lists/*

# Install development dependencies
RUN uv sync --frozen

# Copy application code
COPY . .

# Create non-root user for development
RUN useradd -m -s /bin/bash -u 1000 vscode \
    && chown -R vscode:vscode /app

USER vscode

# Stage 4: Runtime stage (production-ready)
FROM dependencies AS runtime

# Copy built dependencies from builder stage
COPY --from=builder /app/.venv /app/.venv

# Copy application code
COPY . /app

WORKDIR /app

# Create non-root user
RUN useradd -m -s /bin/bash -u 1000 appuser \
    && chown -R appuser:appuser /app

USER appuser

# Activate virtual environment
ENV PATH="/app/.venv/bin:$PATH"

# Default command
CMD ["python", "-m", "src.main"]