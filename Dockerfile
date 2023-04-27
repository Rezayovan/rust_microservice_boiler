
# Use a Rust base image
FROM rust:latest AS builder

# Set the working directory to /app
WORKDIR /app

# Copy the Cargo.toml and Cargo.lock files
COPY Cargo.toml Cargo.lock ./

# Build the dependencies without the application code
RUN mkdir src \
    && echo "fn main() {}" > src/main.rs \
    && cargo build --release

# Copy the source code
COPY src/ ./src/

# Build the application
RUN cargo build --release

# Create a new image using a smaller base image
FROM debian:buster-slim

# Install any required system dependencies
RUN apt-get update && apt-get install -y libssl-dev && rm -rf /var/lib/apt/lists/*

# Copy the built binary from the build stage
COPY --from=builder /app/target/release/ms /usr/local/bin/ms

EXPOSE 8080

# Set the default command to run the application
CMD ["ms"]

