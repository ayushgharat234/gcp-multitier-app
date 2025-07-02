# GCP Multi-Tier Application Infrastructure

[![Terraform](https://img.shields.io/badge/Terraform-1.0+-7B42BC?style=for-the-badge&logo=terraform)](https://www.terraform.io/)
[![Google Cloud](https://img.shields.io/badge/Google_Cloud-4285F4?style=for-the-badge&logo=google-cloud&logoColor=white)](https://cloud.google.com/)
[![CI/CD](https://img.shields.io/badge/CI/CD-GCP_Cloud_Build-4285F4?style=for-the-badge&logo=google-cloud&logoColor=white)](https://cloud.google.com/build)

---

## 🚀 Project Overview

This project delivers a **production-grade, modular Infrastructure as Code (IaC) solution** for deploying a secure, scalable, and highly available multi-tier application on Google Cloud Platform using Terraform. It demonstrates best practices in cloud architecture, automation, and security—making it ideal for real-world enterprise workloads and a strong showcase for recruiters and technical reviewers.

---

## 🏗️ Architecture Overview

The infrastructure is designed for reliability, scalability, and security:
- **Custom VPC** with segmented subnets for frontend, application, and database tiers
- **Managed Instance Groups** for each tier, using startup scripts for automation
- **Global HTTP(S) Load Balancer** for high availability and traffic distribution
- **Fine-grained Firewall Rules** and IAM bindings for robust security
- **Cloud NAT** for secure internet access from private subnets

**Architecture Diagram:**

![Architecture Diagram](architecture/architecture.png)

---

## 📁 Project Structure

```
gcp-multitier-app/
├── architecture/                # Architecture diagrams
│   └── architecture.jpg
├── screenshots/                 # Step-by-step implementation screenshots
│   ├── 01_github_authentication.png
│   ├── 02_github_repo_cloning_tf_scripts.png
│   └── ...
├── modules/                     # Terraform modules (compute, network, loadbalancer, security)
├── scripts/                     # Startup scripts for each tier
├── main.tf                      # Root Terraform configuration
├── variables.tf                 # Input variables
├── outputs.tf                   # Output values
├── providers.tf                 # Provider configuration
├── backend.tf                   # Remote state backend
├── terraform.tfvars             # Variable values for deployment
└── README.md                    # Project documentation
```

---

## 📸 Implementation Walkthrough

Each step of the project is documented with screenshots and concise explanations:

### 1️⃣ GitHub Authentication in gcloud CLI
![GitHub Authentication](screenshots/01_github_authentication.png)
- **Purpose:** Secure authentication for CI/CD and cloud automation.

### 2️⃣ Cloning Terraform Scripts from GitHub
![Cloning Repo](screenshots/02_github_repo_cloning_tf_scripts.png)
- **Purpose:** Version control and reproducibility.

### 3️⃣ Configuring Variables and Self Links
![Configuring Variables](screenshots/03_configurations_of_variables_and_self_links.png)
- **Purpose:** Parameterization for flexible deployments.

### 4️⃣ Creating Bucket for Terraform State Files
![Creating Bucket](screenshots/04_creating_bucket_for_terraform_state_files.png)
- **Purpose:** Remote state management for team collaboration.

### 5️⃣ Initializing Terraform
![Terraform Init](screenshots/05_initialization_of_terraform.png)
- **Purpose:** Provider and backend initialization.

### 6️⃣ Enabling Required APIs
![Enabling APIs](screenshots/06_enabling_required_apis.png)
- **Purpose:** API enablement for resource provisioning.

### 7️⃣ Running VM Instances
![Running VMs](screenshots/07_running_vm_instances.png)
- **Purpose:** Automated compute provisioning with Managed Instance Groups.

### 8️⃣ Custom Firewall Rules
![Firewall Rules](screenshots/08_custom_firewall_rules.png)
- **Purpose:** Secure, least-privilege network access.

### 9️⃣ NIC Network Analysis
![NIC Analysis](screenshots/09_nic_network_analysis.png)
- **Purpose:** Network segmentation and security validation.

### 🔟 Instance Network Topology
![Instance Topology](screenshots/10_instance_netwrok_topology.png)
- **Purpose:** Visualizing and verifying instance connectivity.

### 1️⃣1️⃣ Frontend Load Balancer Topology
![Load Balancer Topology](screenshots/11_frontend_loadbalancer_topology.png)
- **Purpose:** High availability and traffic distribution.

### 1️⃣2️⃣ NIC Connectivity Test: Frontend to App
![NIC Connectivity Test](screenshots/12_nic_connectivity_test_frontend2app.png)
- **Purpose:** Verifying secure, functional inter-tier connectivity.

---

## ⚡ Quick Start

1. **Clone the repository**
   ```sh
   git clone <repo-url>
   cd gcp-multitier-app
   ```
2. **Configure variables**
   - Edit `terraform.tfvars` for your project and network settings.
3. **Initialize Terraform**
   ```sh
   terraform init
   ```
4. **Plan the deployment**
   ```sh
   terraform plan
   ```
5. **Apply the configuration**
   ```sh
   terraform apply
   ```
6. **Access the Application**
   - The output will display the load balancer's external IP. Open it in your browser.

---

## 🔍 Verification Commands

- **Check VPCs and Subnets**
  ```sh
  gcloud compute networks list
  gcloud compute networks subnets list
  ```
- **Check Compute Instances**
  ```sh
  gcloud compute instances list
  ```
- **Check Firewall Rules**
  ```sh
  gcloud compute firewall-rules list
  ```
- **Check IAM Permissions**
  ```sh
  gcloud projects get-iam-policy <YOUR_PROJECT_ID>
  ```

---

## 🧹 Clean Up

To destroy all resources:
```sh
terraform destroy
```

---

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

---

## 📝 License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---

## 🆘 Support

If you encounter any issues or have questions:
- Check the [Issues](../../issues) page
- Review the documentation
- Create a new issue with detailed information

---

**Note:** All screenshots and architecture diagrams are for documentation and demonstration purposes. For actual infrastructure deployment, use the provided Terraform modules and scripts. 