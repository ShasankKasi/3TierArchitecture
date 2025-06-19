# 🏗️ AWS 3-Tier Architecture with Terraform

## 📚 Overview

This Terraform project implements a **3-Tier Architecture** on AWS, dividing the application infrastructure into three logical layers:

- **Presentation Layer** (Public Subnet + ALB)
- **Application Layer** (EC2 Instances in Private Subnets with Auto Scaling)
- **Data Layer** (Amazon RDS in Private Subnets)

The infrastructure is deployed in a custom **VPC**, spans **two Availability Zones**, and uses modular Terraform design for scalability, reusability, and best practices.

---

## 🧱 Architecture Diagram

<img width="665" alt="3tier" src="https://github.com/user-attachments/assets/377f01e7-ecfd-4779-a6c2-394961707632" />

---

## 🔧 Terraform Modules Breakdown

### 1️⃣ Networking Module

Sets up the base networking layer, ensuring secure and isolated deployment.

**Resources Created:**

- `aws_vpc`: Virtual Private Cloud
- `aws_subnet`: Public and Private subnets (across AZ1 and AZ2)
- `aws_internet_gateway`: Internet access for public subnet
- `aws_nat_gateway`: Allows private subnet instances to reach the internet
- `aws_route_table` and `aws_route_table_association`: Routing rules

📌 Subnet Usage:

- **Public Subnet**: For Load Balancer, NAT Gateway
- **Private Subnet**: For EC2 (App Layer) and RDS (Data Layer)

---

### 2️⃣ Application Load Balancer (ALB) Module

Serves as the public-facing entry point for web traffic.

**Resources Created:**

- `aws_lb`: Application Load Balancer
- `aws_lb_listener`: For HTTP/HTTPS ports (80/443)
- `aws_lb_target_group`: Routes requests to EC2 instances
- `aws_security_group`: Controls access to the ALB

✅ ALB ensures traffic routing, health checks, and scaling integration.

---

### 3️⃣ Auto Scaling Group (ASG) Module

Provisions and manages EC2 instances in the **Application Layer**.

**Resources Created:**

- `aws_launch_template`: EC2 config (AMI, instance type, user data)
- `aws_autoscaling_group`: Automatically scales instances
- `aws_cloudwatch_metric_alarm`: CPU or custom metric-based alarms
- `aws_autoscaling_policy`: Scaling rules (e.g., CPU > 70%)

🚀 EC2 instances are deployed in private subnets and are registered with the ALB target group.

---

### 4️⃣ Database (RDS) Module

Deploys a secure and fault-tolerant **Data Layer** using Amazon RDS.

**Resources Created:**

- `aws_db_subnet_group`: Deploys DB across private subnets in multiple AZs
- `aws_db_instance`: Managed relational DB (e.g., MySQL/PostgreSQL)

🔒 No public access is provided; only EC2s from the Application Layer can access RDS.

---

### 5️⃣ Root Module: Integration

The root module orchestrates all other modules and wires the dependencies via Terraform `inputs` and `outputs`.

**Example Integrations:**

- `alb` module receives `vpc_id` and `public_subnet_ids` from `networking`
- `asg` module receives `target_group_arn` from `alb`, and `subnet_ids` from `networking`
- `database` module receives `private_subnet_ids` from `networking`

---

## 🔄 Request Flow

1. User sends request via the internet.
2. **ALB** in public subnet receives request.
3. Request forwarded to **EC2 instance** in private subnet.
4. EC2 processes request and, if needed, queries **RDS** in another private subnet.
5. Response flows back via ALB.

---

## 💡 Benefits of 3-Tier Architecture

- 🔒 **Security**: Private subnets, IAM roles, SGs, and no public DB access
- 📈 **Scalability**: Auto Scaling and Load Balancing
- 🧩 **Modularity**: Layered infrastructure via reusable modules
- 🔁 **High Availability**: Multi-AZ RDS and distributed subnets

---

## 📁 Folder Structure (Example)

```plaintext
.
├── modules/
│   ├── networking/
│   ├── alb/
│   ├── asg/
│   └── database/
├── main.tf
├── variables.tf
├── outputs.tf
└── README.md
