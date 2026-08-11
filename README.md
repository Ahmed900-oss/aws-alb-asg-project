# 🚀 AWS Auto Scaling Web Application with Load Balancer

## 📖 Project Overview

This project demonstrates a **highly available, auto-scaling web application** deployed on AWS. It uses an Application Load Balancer (ALB) with an Auto Scaling Group (ASG) to automatically handle traffic spikes and maintain application availability.

### 🎯 What I Built

- **Auto Scaling Group** with 2-5 EC2 instances
- **Application Load Balancer** to distribute traffic
- **Launch Template** with User Data for automatic configuration
- **Multi-AZ deployment** for high availability
- **Scaling policies** based on CPU utilization

---

## 🏗️ Architecture Diagram
<img width="619" height="1372" alt="aws_architecture" src="https://github.com/user-attachments/assets/9437507a-2687-4190-8924-f60a7937448b" />


### Components:
| Component | Name | Purpose |
|-----------|------|---------|
| VPC | Default VPC | Network boundary |
| Subnets | 2 Public Subnets | Multi-AZ deployment |
| Security Group | WebApp-SG | Allow HTTP (port 80) |
| Launch Template | WebApp-LT | EC2 instance blueprint |
| Auto Scaling Group | WebApp-ASG | Manages instance count |
| Target Group | WebApp-TG | Health checks |
| Application Load Balancer | WebApp-ALB | Traffic distribution |
| EC2 Instances | WebApp-1,2,... | Web servers running Apache |

---

## ⚙️ How It Works

1. **User** sends request to **ALB DNS name**
2. **ALB** distributes traffic across healthy instances in **Target Group**
3. **Auto Scaling Group** maintains desired instance count (2)
4. When **CPU > 60%** for 5 minutes → ASG scales **OUT** (adds 1 instance)
5. When **CPU < 30%** for 5 minutes → ASG scales **IN** (removes 1 instance)
6. **Health checks** replace unhealthy instances automatically

---

## 📸 Screenshots

### Load Balancer DNS
<img width="865" height="521" alt="image" src="https://github.com/user-attachments/assets/8911cfe1-368a-4efe-9903-ba9aa61c733d" />

### Running Instances
<img width="865" height="483" alt="image" src="https://github.com/user-attachments/assets/20d9be9c-0e39-444f-b3ac-f9e49982c2c4" />

### Auto Scaling in Action
<img width="865" height="484" alt="image" src="https://github.com/user-attachments/assets/9038fb5b-52ea-427b-9151-bdf3d5a010cc" />


### Load Balancer Test (Multiple Instances)
<img width="865" height="486" alt="image" src="https://github.com/user-attachments/assets/b2424815-1905-4706-a64c-0a962f4c7689" />


### Target Group Health
 <img width="865" height="482" alt="image" src="https://github.com/user-attachments/assets/a3b57e01-68cf-4f1a-a987-a0c34c0bd287" />


---

## 🔧 Technologies Used

- **Amazon EC2** - Virtual servers
- **Application Load Balancer (ALB)** - Traffic distribution
- **Auto Scaling Group (ASG)** - Automatic scaling
- **Launch Template** - Instance configuration
- **Amazon Linux 2** - Operating system
- **Apache HTTP Server** - Web server

---

## 🚀 How to Deploy

### Prerequisites
- AWS Account (Free tier eligible)
- AWS CLI installed and configured
- SSH key pair

### Deployment Steps

1. **Clone this repository**
   ```bash
   git clone https://github.com/your-username/aws-alb-asg-project.git
   cd aws-alb-asg-project
   ```

2. **Create Launch Template**
   - Go to EC2 → Launch Templates → Create launch template
   - Name: `WebApp-LT`
   - AMI: Amazon Linux 2
   - Instance Type: `t2.micro`
   - User Data: Copy from `scripts/user-data.sh`

3. **Create Target Group**
   - Name: `WebApp-TG`
   - Protocol: HTTP, Port: 80
   - Health Check Path: `/`

4. **Create Load Balancer**
   - Name: `WebApp-ALB`
   - Scheme: Internet-facing
   - Listener: HTTP on port 80
   - Forward to: `WebApp-TG`

5. **Create Auto Scaling Group**
   - Name: `WebApp-ASG`
   - Launch Template: `WebApp-LT`
   - Desired: 2, Min: 2, Max: 5
   - Attach to: `WebApp-ALB`

6. **Test**
   ```bash
   # Get ALB DNS from AWS Console
   curl http://your-alb-dns.elb.amazonaws.com
   ```

---

## 🧪 Testing

### Test Load Balancing
```bash
# Send 10 requests to see different instances
for i in {1..10}; do
    curl http://your-alb-dns.elb.amazonaws.com
    echo ""
done
```

### Test Auto Scaling
```bash
# Install stress tool
sudo amazon-linux-extras install epel -y
sudo yum install stress -y

# Generate CPU load (triggers scale out)
stress --cpu 4 --timeout 600
```

### Expected Results
- Different Instance IDs appear (load balancing)
- New instances launch when CPU > 60% (scale out)
- Instances terminate when CPU < 30% (scale in)
- Failed instances are replaced automatically

---



## 🎯 Key Learnings

- ✅ How to create a Launch Template with User Data
- ✅ How to set up an Application Load Balancer
- ✅ How to configure an Auto Scaling Group
- ✅ How to create scaling policies (CPU-based)
- ✅ How to implement health checks
- ✅ How to achieve high availability with multi-AZ
- ✅ How to test load balancing and auto scaling

---

## 📚 Resources

- [AWS Auto Scaling Documentation](https://docs.aws.amazon.com/autoscaling/)
- [AWS Elastic Load Balancing Documentation](https://docs.aws.amazon.com/elasticloadbalancing/)
- [AWS EC2 User Data Documentation](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/user-data.html)

---

## 📧 Contact

**Author:** Ahmed Nasr Thabit
**LinkedIn:** https://www.linkedin.com/in/ahmed-thapit/
**Email:** thaahmed89@gmail.com

---

## 📝 License

This project is for educational purposes only.
```

