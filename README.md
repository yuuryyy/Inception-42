# 🚀 Inception - Docker Infrastructure Project: Full Guide

## Project Overview

This project focuses on **system administration** and **infrastructure setup** using **Docker**. The core goal is to virtualize a multi-service web environment, specifically a **LEMP stack** (Linux, **E**ngine X/Nginx, **M**ariaDB, **P**HP-FPM) to host a **WordPress** site. It's a deep dive into container orchestration, networking, data persistence, and foundational security.

***

## Learning Objectives

The Inception project is designed to help you master the following core competencies:

* **Master Docker & Docker Compose:** Understand containerization, image creation with `Dockerfile` (using Debian as the base OS), and multi-container application management with `docker-compose`.
* **Systems Administration:** Configure core services like a web server (**NGINX**), a database (**MariaDB**), and a scripting engine (**PHP-FPM**), including proper **PID 1** process management.
* **Networking & Security:** Implement inter-container communication, **SSL/TLS** encryption (HTTPS) for the web server, and manage sensitive data securely using environment variables or Docker secrets.
* **Data Persistence:** Utilize **Docker Volumes** to ensure application data (database content, WordPress files) is persistent and shared correctly between services.

***

## 💻 Docker Fundamentals

| Concept | Explanation |
| :--- | :--- |
| **What is Docker?** | A platform that packages an application and all its dependencies into an isolated unit called a **container**. It ensures **environment parity** ("it works on my machine"). |
| **Containers vs Virtual Machines** | Containers share the host kernel (**OS-level isolation**; lightweight). VMs run a full guest OS (**hardware-level isolation**; heavyweight). |
| **Docker Images vs Containers** | An **Image** is the read-only **blueprint** or **template** built from a `Dockerfile`. A **Container** is a runnable, read-write **instance** of that image. |
| **Docker Engine Architecture** | The Engine is client-server based. The **Docker Client** (CLI) communicates with the background **Docker Daemon** (`dockerd`), which manages containers using the host kernel features (**cgroups** and **namespaces**). |

***

## 🛠️ Dockerfile Best Practices

| Concept | Explanation |
| :--- | :--- |
| **Writing Efficient Dockerfiles** | Use a **minimal base image** (e.g., Debian Slim), and chain commands with `&& \` to **reduce the number of image layers**. Place frequently changing instructions late in the file. |
| **Multi-stage Builds** | A technique using multiple `FROM` stages to separate the bulky **build environment** from the lean **runtime environment**. This **minimizes the final image size**. |
| **Layer Caching** | Each instruction creates an immutable layer. Docker reuses cached layers if the instruction and its context are unchanged, significantly speeding up rebuilds. |
| **Security Considerations** | Always use the `USER` instruction to switch from **root** to a non-privileged user after installation. **Never** store secrets directly in the Dockerfile. |

***

## ⚙️ Docker Compose

| Concept | Explanation |
| :--- | :--- |
| **YAML Configuration** | Compose uses the **YAML** (`.yml`) file format to declaratively define the entire multi-container application's structure (services, networks, and volumes) in a single configuration file. |
| **Service Definition** | A **service** is the definition for a container that runs a specific function (e.g., `nginx`). It specifies parameters like build context, image, ports, environment variables, and restart policies. |
| **Networks and Volumes** | Defined at the top level, custom **networks** enable service discovery, and **volumes** specify the persistent data storage location for services. |
| **Environment Variables** | Used for **dynamic configuration** and passed into containers at runtime via an external `.env` file or the `environment:` block. |

***

## 🔄 Container Orchestration

| Concept | Explanation |
| :--- | :--- |
| **Service Dependencies** | Managed by `depends_on`, which ensures services are **created and started in order**. **Does not verify service readiness** (it won't wait for the database to be listening). |
| **Health Checks** | A command defined in the `healthcheck` block that Docker periodically runs *inside* a container to confirm the service is **ready to handle requests**. |
| **Restart Policies** | Configured with the `restart` key (e.g., `unless-stopped`). It dictates how the Docker daemon should recover if a container exits, ensuring continuous availability. |
| **Resource Management** | Keys like `cpus` and `mem_limit` set limits on CPU and memory consumption. This prevents a single runaway container from destabilizing the host. |

***

## 🌐 Networking

| Concept | Explanation |
| :--- | :--- |
| **Docker Networks** | The default is a **bridge network**, acting as a virtual switch that connects a set of containers on a private network and isolates them from the public. |
| **Port Mapping** | The process of linking a container's internal port to a host machine's public port (e.g., `443:443`). Only mapped ports are externally accessible. |
| **Container Communication** | On a custom bridge network, containers use **Service Discovery** to communicate using their **service names as hostnames** (e.g., `mariadb:3306`). |
| **Network Security** | Achieved by only exposing the necessary external port (`443` for NGINX) while keeping all internal services (MariaDB, PHP-FPM) restricted to the private Docker network. |

***

## 💾 Data Management

| Concept | Explanation |
| :--- | :--- |
| **Docker Volumes** | The **recommended** method for persistent data storage. Volumes are managed by Docker and ensure critical data survives container restarts and rebuilds. |
| **Bind Mounts** | Links a specific file or directory from the **host machine's filesystem** directly into the container. Primarily used for local development (instant code reflection). |
| **Data Persistence** | The guarantee that application data (database contents, user uploads) remains intact across the container lifecycle, achieved through **Docker Volumes**. |
| **Backup Strategies** | Involves periodically taking snapshots of the Docker Volume data, often by running an export utility (`mysqldump`) from the container and saving the output externally. |

***

## 🔒 Security

| Concept | Explanation |
| :--- | :--- |
| **Environment Variables vs Secrets**| **Variables** are for non-sensitive config. **Secrets** are for highly sensitive data (passwords, keys) that should not be stored in plaintext environment variables or logs. |
| **Docker Secrets** | A secure method to inject sensitive data into a container only at runtime, typically using an in-memory filesystem to prevent persistence. |
| **SSL/TLS Configuration** | Involves generating a **self-signed certificate** and **private key** (using OpenSSL) and configuring NGINX to use them. This enables **HTTPS** (port 443) for encrypted communication. |
| **Container Security** | Minimize the attack surface by running containers with a **non-root user**, using minimal base images, and ensuring the NGINX reverse proxy is the only service exposed externally. |

***

## 🧩 Service-Specific Learning

| Concept | Explanation |
| :--- | :--- |
| **NGINX Configuration** | NGINX acts as a **Reverse Proxy**. It terminates HTTPS and **forwards** dynamic requests (PHP files) to the separate PHP-FPM container using the **FastCGI protocol**. |
| **WordPress + PHP-FPM Setup**| WordPress is installed with **PHP-FPM** (FastCGI Process Manager), which executes the PHP code. They are split into two containers to separate the web server (NGINX) from the application runtime (PHP-FPM). |
| **MariaDB Database Management**| The container must run a startup script to: 1) Initialize the service; 2) Create the database/user; 3) Grant privileges; and 4) Run the server process in the **foreground (PID 1)**. |

***

## 🏛️ System Administration

| Concept | Explanation |
| :--- | :--- |
| **Process Management (PID 1)** | The process started by `CMD` or `ENTRYPOINT` receives **PID 1**. It must correctly handle signals (like `SIGTERM`) and **reap zombie processes**. All daemons must run in the **foreground**. |
| **Daemon Processes** | Services (NGINX, MariaDB) that traditionally run in the background. In a container, they must be forced to run in the **foreground** so Docker recognizes the service is alive and doesn't terminate the container. |
| **Log Management** | Services must be configured to send all output to **`stdout`** and **`stderr`**. Docker captures these streams, which is the standard for centralized log collection. |
| **System Monitoring** | Observing container health and resource usage (`docker stats`). Bonus features often involve integrating tools like `cAdvisor` to gather and visualize CPU, memory, and network metrics. |

***

## 🚀 Implementation Journey (Walkthrough)

| Phase | Steps and Key Actions |
| :--- | :--- |
| **Project Setup** | Create the project structure, including `requirements/` subdirectories and the `.env` file for credentials. |
| **MariaDB Container** | Build the image, initialize the database/user with a startup script, and define the persistent **Volume**. |
| **WordPress Container** | Build the image, install PHP-FPM and `wp-cli`. Use a script to install WordPress and configure it to connect to the `mariadb` service name. |
| **NGINX Container** | Build the image, generate a **self-signed SSL certificate**. Configure NGINX to listen on **443** and **reverse proxy** PHP traffic to the `wordpress:9000` service. |
| **Network Configuration** | Define a custom `inception_network` and ensure all three services are attached for internal communication. |
| **Volume Management** | Mount volumes for the MariaDB data directory and the shared WordPress files. |
| **Final Run** | Execute the infrastructure with `docker-compose up --build -d`. Verify HTTPS connection and check logs (`docker logs <service>`) for errors. |

***

## 🎁 Bonus Features

| Bonus Feature | Purpose and Concepts |
| :--- | :--- |
| **Redis Cache** | An in-memory data store to improve WordPress performance by caching objects and reducing the load on MariaDB. Concept: **Integrating a caching layer**. |
| **FTP Server** | A service (e.g., **vsftpd**) that allows external file transfer access to the shared WordPress volume. Concept: **Network configuration, user permissions**. |
| **Adminer** | A web-based database management tool accessed via NGINX as another **reverse proxy** target. Concept: **Multi-site hosting, secure access**. |
| **Static Website** | Configuring NGINX to host a second, simple static HTML site alongside WordPress. Concept: **NGINX server blocks, file path handling**. |

***

## 🛑 Troubleshooting

| Common Issue | Debugging Technique |
| :--- | :--- |
| **Container Exits Immediately**| Check **PID 1**; the service likely detached from the foreground. Use `docker logs` and ensure the main process is configured to stay alive. |
| **"Can't connect to DB"** | Check the **Network Name** (hostname) in the WordPress config (`mariadb` not an IP), verify the MariaDB container logs. |
| **NGINX 502 Bad Gateway** | NGINX can't reach PHP-FPM. Check the PHP-FPM container logs and confirm the NGINX config points to the correct service and port (`wordpress:9000`). |
| **SSL Certificate Error** | Ensure the certificate path is correct in the NGINX configuration and that NGINX is listening on port **443**. |