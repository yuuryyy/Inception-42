# Inception - Docker Infrastructure Project

## Table of Contents
- [Project Overview](#project-overview)
- [Learning Objectives](#learning-objectives)
- [Docker Fundamentals](#docker-fundamentals)
  - [What is Docker?](#what-is-docker)
  - [Containers vs Virtual Machines](#containers-vs-virtual-machines)
  - [Docker Images vs Containers](#docker-images-vs-containers)
  - [Docker Engine Architecture](#docker-engine-architecture)
- [Dockerfile Best Practices](#dockerfile-best-practices)
  - [Writing Efficient Dockerfiles](#writing-efficient-dockerfiles)
  - [Multi-stage Builds](#multi-stage-builds)
  - [Layer Caching](#layer-caching)
  - [Security Considerations](#security-considerations)
- [Docker Compose](#docker-compose)
  - [YAML Configuration](#yaml-configuration)
  - [Service Definition](#service-definition)
  - [Networks and Volumes](#networks-and-volumes)
  - [Environment Variables](#environment-variables)
- [Container Orchestration](#container-orchestration)
  - [Service Dependencies](#service-dependencies)
  - [Health Checks](#health-checks)
  - [Restart Policies](#restart-policies)
  - [Resource Management](#resource-management)
- [Networking](#networking)
  - [Docker Networks](#docker-networks)
  - [Port Mapping](#port-mapping)
  - [Container Communication](#container-communication)
  - [Network Security](#network-security)
- [Data Management](#data-management)
  - [Docker Volumes](#docker-volumes)
  - [Bind Mounts](#bind-mounts)
  - [Data Persistence](#data-persistence)
  - [Backup Strategies](#backup-strategies)
- [Security](#security)
  - [Environment Variables vs Secrets](#environment-variables-vs-secrets)
  - [Docker Secrets](#docker-secrets)
  - [SSL/TLS Configuration](#ssltls-configuration)
  - [Container Security](#container-security)
- [Service-Specific Learning](#service-specific-learning)
  - [NGINX Configuration](#nginx-configuration)
  - [WordPress + PHP-FPM Setup](#wordpress--php-fpm-setup)
  - [MariaDB Database Management](#mariadb-database-management)
- [System Administration](#system-administration)
  - [Process Management (PID 1)](#process-management-pid-1)
  - [Daemon Processes](#daemon-processes)
  - [Log Management](#log-management)
  - [System Monitoring](#system-monitoring)
- [Development Workflow](#development-workflow)
  - [Local Development Setup](#local-development-setup)
  - [Debugging Containers](#debugging-containers)
  - [Testing Strategies](#testing-strategies)
  - [CI/CD Integration](#cicd-integration)
- [Infrastructure Architecture](#infrastructure-architecture)
  - [Service Architecture Design](#service-architecture-design)
  - [Load Balancing](#load-balancing)
  - [Scalability Considerations](#scalability-considerations)
  - [Performance Optimization](#performance-optimization)
- [Implementation Journey](#implementation-journey)
  - [Project Setup](#project-setup)
  - [NGINX Container](#nginx-container)
  - [MariaDB Container](#mariadb-container)
  - [WordPress Container](#wordpress-container)
  - [Network Configuration](#network-configuration)
  - [Volume Management](#volume-management)
  - [Environment Configuration](#environment-configuration)
- [Bonus Features](#bonus-features)
  - [Redis Cache](#redis-cache)
  - [FTP Server](#ftp-server)
  - [Static Website](#static-website)
  - [Adminer](#adminer)
  - [Additional Service](#additional-service)
- [Troubleshooting](#troubleshooting)
  - [Common Issues](#common-issues)
  - [Debugging Techniques](#debugging-techniques)
  - [Performance Issues](#performance-issues)
  - [Connectivity Problems](#connectivity-problems)
- [Best Practices Learned](#best-practices-learned)
- [Resources Used](#resources-used)
- [Reflection](#reflection)

## Project Overview
This project focuses on system administration and infrastructure setup using Docker. The core goal is to virtualize a multi-service web environment, specifically a LEMP stack (Linux, Engine X/Nginx, MariaDB, PHP-FPM) to host a WordPress site. It's a deep dive into container orchestration, networking, data persistence, and foundational security.

## Learning Objectives
***Master Docker & Docker Compose:***    
Understand containerization, image        creation with Dockerfile (using Debian as the base OS), and multi-container application management with docker-compose.  
***Systems Administration:***   
Configure core services like a web server (NGINX), a database (MariaDB), and a scripting engine (PHP-FPM), including proper PID 1 process management.   
***Networking & Security:***   
Implement inter-container communication, SSL/TLS encryption (HTTPS) for the web server, and manage sensitive data securely using environment variables or Docker secrets.   
***Data Persistence:***    
Utilize Docker Volumes to ensure application data (database content, WordPress files) is persistent and shared correctly between services.
*I'll fill this section with my personal objectives as I progress through the project.*

## Docker Fundamentals

### What is Docker?
Docker is a platform for developing, shipping, and running applications using containers. It provides a standardized way to package an application's code, runtime, system tools, libraries, and settings into a unit that can run consistently across any environment. Its primary purpose is to solve the "it works on my machine" problem by ensuring environment parity.
*My understanding of Docker's purpose, benefits, and use cases.*

### Containers vs Virtual Machines
*Key differences and when to use each technology.*

### Docker Images vs Containers
*The relationship between images and containers, and the lifecycle.*

### Docker Engine Architecture
*How Docker works under the hood, including the daemon and client.*

## Dockerfile Best Practices

### Writing Efficient Dockerfiles
*Techniques for creating optimized and maintainable Dockerfiles.*

### Multi-stage Builds
*Using multi-stage builds to reduce image size and improve security.*

### Layer Caching
*Understanding how Docker layer caching works and optimizing for it.*

### Security Considerations
*Security best practices when writing Dockerfiles.*

## Docker Compose

### YAML Configuration
*Understanding Docker Compose file structure and syntax.*

### Service Definition
*How to properly define services in docker-compose.yml.*

### Networks and Volumes
*Configuring networking and data persistence in Compose.*

### Environment Variables
*Managing configuration through environment variables.*

## Container Orchestration

### Service Dependencies
*Managing startup order and service dependencies.*

### Health Checks
*Implementing health checks for robust container management.*

### Restart Policies
*Understanding and configuring container restart behavior.*

### Resource Management
*Setting resource limits and managing container resources.*

## Networking

### Docker Networks
*Understanding Docker's networking model and network types.*

### Port Mapping
*How to expose container ports and manage port conflicts.*

### Container Communication
*Inter-container communication and service discovery.*

### Network Security
*Securing container networking and isolating services.*

## Data Management

### Docker Volumes
*Understanding Docker volumes and when to use them.*

### Bind Mounts
*Using bind mounts for development and specific use cases.*

### Data Persistence
*Ensuring data survives container restarts and updates.*

### Backup Strategies
*Approaches for backing up containerized data.*

## Security

### Environment Variables vs Secrets
*Understanding the difference and when to use each approach.*

### Docker Secrets
*Implementing Docker secrets for sensitive information.*

### SSL/TLS Configuration
*Setting up secure connections with proper certificates.*

### Container Security
*Security best practices for running containers in production.*

## Service-Specific Learning

### NGINX Configuration
*Configuring NGINX as a reverse proxy with SSL/TLS.*

### WordPress + PHP-FPM Setup
*Setting up WordPress with PHP-FPM without bundling with NGINX.*

### MariaDB Database Management
*Database configuration, user management, and security.*

## System Administration

### Process Management (PID 1)
*Understanding PID 1 in containers and proper process management.*

### Daemon Processes
*How to run services as daemons in containers properly.*

### Log Management
*Container logging strategies and log aggregation.*

### System Monitoring
*Monitoring container health and performance.*

## Development Workflow

### Local Development Setup
*Setting up a development environment with Docker.*

### Debugging Containers
*Techniques for debugging containerized applications.*

### Testing Strategies
*Testing Docker containers and multi-service applications.*

### CI/CD Integration
*Integrating Docker into continuous integration/deployment pipelines.*

## Infrastructure Architecture

### Service Architecture Design
*Designing microservices architecture with Docker.*

### Load Balancing
*Implementing load balancing in containerized environments.*

### Scalability Considerations
*Planning for scaling containerized applications.*

### Performance Optimization
*Optimizing Docker container and application performance.*

## Implementation Journey

### Project Setup
*Initial project structure and development environment setup.*

### NGINX Container
*Building and configuring the NGINX container with SSL.*

### MariaDB Container
*Setting up the database container with proper initialization.*

### WordPress Container
*Creating the WordPress container with PHP-FPM configuration.*

### Network Configuration
*Setting up Docker networks for service communication.*

### Volume Management
*Implementing persistent storage for database and website files.*

### Environment Configuration
*Managing environment variables and secrets securely.*

## Bonus Features

### Redis Cache
*Implementing Redis caching for WordPress performance.*

### FTP Server
*Setting up an FTP server for file management.*

### Static Website
*Creating a simple static website container.*

### Adminer
*Database administration interface setup.*

### Additional Service
*Custom service implementation and justification.*

## Troubleshooting

### Common Issues
*Problems encountered and their solutions.*

### Debugging Techniques
*Methods for diagnosing container and service issues.*

### Performance Issues
*Identifying and resolving performance bottlenecks.*

### Connectivity Problems
*Network and service connectivity troubleshooting.*

## Best Practices Learned
*Summary of Docker and system administration best practices discovered.*

## Resources Used
*List of helpful documentation, tutorials, and references consulted.*

## Reflection
*Overall thoughts on the project and key learning outcomes.*

Project Overview

This project focuses on system administration and infrastructure setup using Docker. The core goal is to virtualize a multi-service web environment, specifically a LEMP stack (Linux, Engine X/Nginx, MariaDB, PHP-FPM) to host a WordPress site. It's a deep dive into container orchestration, networking, data persistence, and foundational security.

Learning Objectives

    Master Docker & Docker Compose: Understand containerization, image creation with Dockerfile (using Debian as the base OS), and multi-container application management with docker-compose.

    Systems Administration: Configure core services like a web server (NGINX), a database (MariaDB), and a scripting engine (PHP-FPM), including proper PID 1 process management.

    Networking & Security: Implement inter-container communication, SSL/TLS encryption (HTTPS) for the web server, and manage sensitive data securely using environment variables or Docker secrets.

    Data Persistence: Utilize Docker Volumes to ensure application data (database content, WordPress files) is persistent and shared correctly between services.

Docker Fundamentals

What is Docker?

Docker is a platform for developing, shipping, and running applications using containers. It provides a standardized way to package an application's code, runtime, system tools, libraries, and settings into a unit that can run consistently across any environment. Its primary purpose is to solve the "it works on my machine" problem by ensuring environment parity.

Containers vs Virtual Machines

Feature	Container (e.g., Docker)	Virtual Machine (VM) (e.g., VirtualBox)
Isolation	OS-level isolation; shares the host OS kernel.	Hardware-level isolation; runs a full, independent guest OS.
Size	Lightweight (MBs), starts in seconds.	Heavyweight (GBs), requires minutes to boot.
Performance	Near-native performance.	Performance overhead due to hypervisor layer.
Use Case	Microservices, rapid deployment, application isolation.	Full system isolation, running different OSes, strong security boundaries.

Docker Images vs Containers

A Docker Image is a read-only, ordered collection of root filesystem changes and the corresponding execution parameters. It's the blueprint or template. A Container is a runnable, read-write instance of an image. When executed, Docker adds a thin, writable layer on top of the image's read-only layers.

Docker Engine Architecture

The Docker Engine operates in a client-server architecture. The Docker Client (your CLI commands like docker run) communicates with the Docker Daemon (dockerd), which runs in the background and manages Docker objects (images, containers, volumes, networks). The Daemon uses the host OS kernel's features (cgroups and namespaces) for isolation.

Dockerfile Best Practices

Writing Efficient Dockerfiles

Use a minimal base image (like Debian Slim), keep the number of layers low by chaining commands with && \, and place the most frequently changing instructions (like COPY application code) later in the file. This maximizes the use of layer caching.

Multi-stage Builds

A technique using multiple FROM statements to separate build-time environments from the final runtime environment. The goal is to minimize the final image size by only copying the necessary artifacts from a "builder" stage to a lean final stage, leaving behind large dependencies.

Layer Caching

Each instruction in a Dockerfile corresponds to an immutable image layer. Docker caches these layers. During a rebuild, if an instruction and its context haven't changed, Docker reuses the cached layer, accelerating the build. The cache is invalidated if an instruction or any preceding instruction is modified.

Security Considerations

Use the principle of least privilege. Avoid running containers as the root user; use the USER instruction to switch to a non-root user. Remove unnecessary packages, and never store sensitive data (secrets) directly in the Dockerfile.

Docker Compose

YAML Configuration

Docker Compose uses a YAML (.yml) file to declaratively define the entire multi-container application's structure, including services, networks, and volumes. It provides a single configuration point for complex systems.

Service Definition

A service is a definition for a container that runs a specific application component (e.g., nginx, mariadb). It specifies parameters like the image or build context, ports to map, restart policy, and networking rules.

Networks and Volumes

Custom networks and volumes are defined at the top level of the docker-compose.yml file and referenced by services. This ensures they are created and managed correctly as integral parts of the application infrastructure.

Environment Variables

Managed via an external .env file or directly in the environment: block. They are crucial for dynamic configuration (like database credentials, hostnames) at runtime, allowing the same container image to be deployed in different settings.

Container Orchestration

Service Dependencies

Managed using the depends_on key. This only ensures that service containers are created and started in a specific order (e.g., mariadb before wordpress). Crucially, it does not wait for the application inside the container to be ready to accept connections.

Health Checks

A more reliable way to manage service readiness. A healthcheck block defines a command (e.g., checking if the database port is open) that Docker periodically runs inside a container. If the check fails, Docker knows the container is running but unhealthy.

Restart Policies

Configured using the restart key (e.g., always, on-failure). This instructs the Docker daemon on how to handle a container that exits. For continuous operation, unless-stopped is often used to ensure automatic recovery after crashes or reboots.

Resource Management

Allows setting limits on CPU and memory consumption using keys like cpus and mem_limit. This is essential for host stability, preventing a single runaway container from monopolizing resources and causing a denial of service on the host.

Networking

Docker Networks

Docker's default network type is the bridge network (the one created by Compose). It connects a set of containers on a private network and isolates them from the host's public network, ensuring secure inter-container communication.

Port Mapping

The process of linking a port inside the container to a port on the host machine using the ports: configuration (e.g., 443:443). Only mapped ports are externally accessible; unmapped ports are reserved for internal communication.

Container Communication

On a custom bridge network, containers can communicate using their service names as hostnames (this is Service Discovery). The WordPress container connects to MariaDB simply by using the hostname mariadb.

Network Security

Achieved by only exposing the necessary port (443 for NGINX) to the public. Internal services like MariaDB and PHP-FPM are only accessible on the private Docker network, effectively shielding them behind the NGINX reverse proxy.

Data Management

Docker Volumes

The recommended method for persistent data storage. Volumes are managed entirely by Docker and reside in a dedicated part of the host filesystem. They are highly efficient and the best way to ensure data (like your MariaDB data) survives container lifecycle events.

Bind Mounts

Allows a container to directly access a file or directory from the host machine's exact path. They are typically used for local development (to instantly reflect code changes) or for mounting specific host configuration files.

Data Persistence

The guarantee that critical data (database contents, user uploads, logs) remains intact across container shutdowns, restarts, and updates. In this project, persistence for both the database and WordPress files is achieved using Docker Volumes.

Backup Strategies

Involves periodically backing up the data stored in the Docker Volumes. For the database, this means running an export command (mysqldump) from within the MariaDB container and saving the file to a secure, external location.

Security

Environment Variables vs Secrets

Environment Variables (e.g., in .env file) are suitable for non-sensitive, configuration data. Secrets are for highly sensitive data (passwords, private keys) that should not be exposed in plaintext environment variables, logs, or image layers.

Docker Secrets

A mechanism to inject sensitive data into a container securely at runtime, often using an in-memory filesystem to prevent persistence and exposure in shell history or inspect output.

SSL/TLS Configuration

Involves generating a self-signed certificate and its corresponding private key (using OpenSSL) and configuring NGINX to use them. This enables HTTPS (Hypertext Transfer Protocol Secure) traffic on port 443, encrypting data between the user and the web server.

Container Security

Minimize the attack surface by using minimal base images, removing unnecessary packages, and running processes as a non-root user. The NGINX reverse proxy enforces security by being the only externally-facing service.

Service-Specific Learning

NGINX Configuration

NGINX is configured as a Reverse Proxy with SSL. It listens on port 443, handles the HTTPS connection, and then forwards dynamic requests (PHP files) to the separate PHP-FPM container via the internal network, using the FastCGI protocol.

WordPress + PHP-FPM Setup

WordPress application files are served by NGINX, but the actual code execution is handled by PHP-FPM (FastCGI Process Manager). They are separate containers communicating via the internal network (e.g., wordpress:9000). This separation improves security and resource management.

MariaDB Database Management

The container must execute a startup script to: 1) Initialize the service; 2) Create the specific WordPress database; 3) Create a dedicated user with minimal privileges; and 4) Ensure the service remains running in the foreground as PID 1.

System Administration

Process Management (PID 1)

In a container, the process specified by CMD or ENTRYPOINT receives PID 1. This process must correctly handle signal processing and reap zombie processes. Services like NGINX and MariaDB must be configured to run in the foreground and not detach as traditional background daemons.

Daemon Processes

Traditional services that run continuously in the background. In a container, these daemons (NGINX, MariaDB) must be run in a manner that keeps the main container process in the foreground to signal Docker that the service is running, or the container will immediately exit.

Log Management

All services must be configured to send their logs to stdout and stderr (standard output/error). Docker captures these streams, which is the standard method for centralized log collection in containerized environments.

System Monitoring

Involves using container tools (like docker stats) or specialized services (like cAdvisor or Prometheus, potential bonuses) to observe key metrics: container health status, resource utilization (CPU, memory, disk I/O), and network traffic.

Development Workflow

Local Development Setup

Utilizing Bind Mounts to link the source code from the host machine directly into the running container. This allows developers to edit code locally and see the changes reflected instantly in the containerized application without rebuilding the image.

Debugging Containers

Techniques include inspecting container logs (docker logs <container>), executing shell commands inside a running container (docker exec -it <container> /bin/bash), and temporarily increasing logging verbosity in service configurations.

Testing Strategies

Involves writing tests (e.g., using curl or a browser) to verify connectivity, proper SSL setup, database readiness, and successful WordPress installation. Compose is ideal for Integration Testing, where all services are tested together.

CI/CD Integration

Integrating Docker into continuous integration/deployment pipelines. The CI server would use the Dockerfile to build the image, run necessary tests, and then push the final image to a registry (e.g., Docker Hub) for deployment.

Infrastructure Architecture

Service Architecture Design

The project implements a microservices-like architecture where the application is split into specialized, isolated, and communicating services: NGINX (proxy), PHP-FPM (logic), and MariaDB (data). This promotes modularity and independent scaling.

Load Balancing

In a single-instance project, load balancing is conceptual. In a scalable context, a separate load balancer (like HAProxy or NGINX itself) would distribute traffic among multiple identical NGINX/WordPress container pairs.

Scalability Considerations

The architecture is inherently scalable: the stateless services (NGINX, PHP-FPM) can be easily replicated. The stateful service (MariaDB) is the bottleneck, requiring external solutions like database replication or clustering for true scalability.

Performance Optimization

Involves using minimal images, efficient Dockerfile layering, proper NGINX caching directives, and implementing a caching layer like Redis (a common bonus) to reduce database load and speed up response times.

Implementation Journey

Project Setup

Creating the main project directory, organizing subdirectories for each service (e.g., requirements/nginx), and setting up the .env file for credentials and the initial docker-compose.yml.

NGINX Container

Building the container: installing NGINX and OpenSSL, generating the self-signed SSL certificate, and configuring NGINX to listen on 443 and reverse proxy PHP requests to the WordPress container.

MariaDB Container

Building the container: installing MariaDB, configuring bind-address=0.0.0.0, creating a startup script to initialize the WordPress database and user, and ensuring the MariaDB server runs as the main container process.

WordPress Container

Building the container: installing PHP-FPM, necessary PHP extensions (php-mysql), and the wp-cli tool. A startup script uses wp-cli to download and install WordPress, configuring it to connect to the mariadb service via the network.

Network Configuration

Defining a custom inception_network in docker-compose.yml and attaching all three services to it. This facilitates communication using service names (e.g., mariadb and wordpress).

Volume Management

Defining and mounting two volumes: one for the MariaDB data (/var/lib/mysql) to ensure data persistence, and one for the WordPress files (/var/www/html) shared between the NGINX and WordPress containers.

Environment Configuration

Populating the .env file with secure, non-default values for the database user, password, root password, and WordPress configuration, which are then passed into the respective containers.

Bonus Features

Redis Cache

A separate container running the Redis in-memory data store. WordPress is configured (via a plugin) to use Redis as an object cache, significantly reducing database query load and improving page response speed.

FTP Server

A separate container running a service like vsftpd. This allows users to connect with an FTP client to the shared WordPress volume, enabling file management (uploads, edits) on the host machine.

Static Website

An extra NGINX configuration (e.g., in a second service or a new server block) to host a simple, non-dynamic HTML site. This demonstrates multi-site hosting and basic NGINX server block configuration.

Adminer

A single-file, web-based database management tool (similar to phpMyAdmin). It is run in a separate container and accessed via an NGINX reverse proxy to provide a graphical interface for managing the MariaDB database.

Additional Service

Any justified service, like a system monitoring tool (cAdvisor) or a different type of database, demonstrating the ability to integrate heterogeneous systems using Docker Compose networking.

Troubleshooting

Common Issues

Containers immediately exiting (usually due to the application not running in the foreground as PID 1), connectivity issues (misconfigured ports or network names), and SSL errors (incorrect certificate paths or NGINX misconfiguration).

Debugging Techniques

Using docker logs <container> to check service output, docker exec -it <container> /bin/bash to enter the container and manually check file paths/configurations, and docker inspect <container> to verify network and volume settings.

Performance Issues

High CPU or memory usage can indicate application bottlenecks (e.g., excessive MariaDB queries). Use docker stats and check application logs to identify resource-hungry processes or slow queries.

Connectivity Problems

Inability of containers to communicate is often due to misspelling the service name (hostname) in the application config or not having all services attached to the same Docker network.

Best Practices Learned

    Decoupling Services: Separating the web server (NGINX) from the application runtime (PHP-FPM) for better modularity.

    Separation of Concerns: Using a dedicated container for each process (single process per container rule).

    Configuration via Environment: Using .env and environment: for dynamic setup instead of hardcoding values.

    Foreground Processes: Ensuring services run as PID 1 in the foreground for graceful container shutdown.

    Immutable Infrastructure: Committing configuration and installation steps to the Dockerfile rather than modifying running containers.

Resources Used

List of helpful documentation, tutorials, and references consulted.

Reflection

Overall thoughts on the project and key learning outcomes.