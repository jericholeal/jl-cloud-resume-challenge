# Cloud Resume Challenge - Jericho's Cloud Resume Website

Welcome to my crack at the Cloud Resume Challenge [Cloud Resume Challenge](https://cloudresumechallenge.dev/)!

---

## Project Overview

This is a fully serverless, highly available resume website built as part of the Cloud Resume Challenge.

Project features:
- A responsive HTML/CSS frontend
- A live visitor counter using JavaScript, API Gateway, Lambda, and DynamoDB
- Hosting through Amazon S3 and CloudFront
- A custom domain using Route 53
- Secure HTTPS via AWS Certificate Manager
- A custom 404/offline page

---

## Live Site

[https://jericho-crc-site.xyz](https://jericho-crc-site.xyz)

---

## Tech Stack

---

## Visitor Counter

The visitor counter updates every time someone loads the site.

Uses:
- **JavaScript** on the frontend to call an API
- **API Gateway** to expose a public endpoint
- **Lambda Function** in Python to increment a counter
- **DynamoDB** to store the count

---

## Project Structure

