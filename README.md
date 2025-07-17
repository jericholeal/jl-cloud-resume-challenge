# Cloud Resume Challenge - Jericho's Cloud Resume Website

Welcome to my crack at the Cloud Resume Challenge [Cloud Resume Challenge](https://cloudresumechallenge.dev/)!

## Live Site
[https://jericho-crc-site.xyz](https://jericho-crc-site.xyz)

## Project Overview

**Key Features:**
- Static website hosted on Amazon S3, delivered globally via CloudFront
- Custom domain with HTTPS (ACM), DNSSEC-enabled Route53 DNS (KMS)
- Visitor counter API built with API Gateway, Lambda (Python), and DynamoDB
- Secure S3 access using CloudFront Origin Access Control (OAC)
- Infrastructure as Code (IaC) with Terraform for reproducibility and version control
- Automated Lambda packaging and deployment via GitHub Actions CI/CD

## Tech Stack

- **Frontend:** HTML, CSS, JavaScript
- **Hosting/CDN:** Amazon S3, Amazon CloudFront
- **CloudFront S3 Access:** Origin Access Control (OAC)
- **API:** Amazon API Gateway (REST)
- **API Security:** CORS configured on API Gateway
- **Database:** Amazon DynamoDB
- **DNS & Domain:** Amazon Route 53
- **DNS Security:** AWS Key Management Service (KMS) for DNSSEC
- **SSL/TLS:** AWS Certificate Manager (ACM)
- **Infrastructure as Code:** Terraform
- **CI/CD:** GitHub Actions
- **Monitoring/Logging:** AWS CloudWatch Logs
---

## Visitor Counter

The visitor counter updates every time someone loads the site.

Uses:
- **JavaScript** on the frontend to call an API
- **API Gateway** to expose a public endpoint
- **Lambda Function** in Python to increment a counter
- **DynamoDB** to store the count

## CI/CD
- **GitHub Actions** workflow for frontend deployment
- Uses stored 


## References & Credits

