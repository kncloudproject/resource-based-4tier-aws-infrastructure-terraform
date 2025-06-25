# Resource-Based 4-Tier AWS Infrastructure Using Terraform

This repository contains Terraform code to provision a **4-tier AWS architecture**, where each AWS resource type is defined in its own file within a single directory.

---

## 📌 Features

✅ Resource-based files (VPC, subnets, IGW, NAT Gateway, Security Groups, EC2, RDS, etc.)  
✅ Clean, flat directory structure  
✅ 4-tier architecture: **Web**, **Reverse Proxy**, **App**, **Database**  
✅ Security best practices: database in private subnet, restricted security groups  

---

👉 **Note:**  
This initial version uses a resource-based structure with separate files for each resource.  
In the next stage, this project will be **refactored to use a module-based architecture** for better reusability, scalability, and cleaner management.
