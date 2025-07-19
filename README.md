# Cloud Resume Challenge - Jericho's Cloud Resume Website

Welcome to my crack at the [Cloud Resume Challenge](https://cloudresumechallenge.dev/)!

## Live Site
[https://jericho-crc-site.xyz](https://jericho-crc-site.xyz)

## Project Overview

**Key Features:**
- Static website hosted on Amazon S3, delivered globally via CloudFront
- Custom domain with HTTPS (ACM), DNSSEC-enabled Route53 DNS (KMS)
- Visitor counter API built with API Gateway, Lambda (Python), and DynamoDB
- Secure S3 access using CloudFront Origin Access Control (OAC)
- Infrastructure as Code (IaC) with Terraform
- Automated Lambda packaging and deployment via GitHub Actions CI/CD

## Visitor Counter

The visitor counter updates every time someone loads the site.

Uses:
- **API Gateway** to expose a public endpoint
- **JavaScript** on the frontend to call the API
- **Lambda** function in Python to increment a counter, triggered by the API
- **DynamoDB** table to store the count

## CI/CD
- **GitHub Actions** workflow for frontend deployment
- Uses stored GitHub Actions secrets for credentials and resource IDs

## References & Credits
- **Cloud Resume Challenge** originally created by [Forrest Brazeal](https://forrestbrazeal.com/).
- This project follows the guidelines and structure outlined in Forrest's [Cloud Resume Challenge Guidebook](https://cloudresumechallenge.dev/docs/the-challenge/aws/), which is an excellent resource for anyone looking to get a hands-on start in cloud engineering.
- Big thanks to Forrest and the broader cloud community for making this path accessible, practical, and rewarding.
