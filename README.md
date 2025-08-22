# Azure Web Application with database connection


## Abstract
This repository contains Azure Containerized WebApp, the related database object creation script. Also there are 3 github pipelines: Build, Deploy and Provision.

## Repository Content
**.github** directory contents Github pipelines;<br>
**AzureWebApp2** directory contents the application code and Dockerfile;<br>
**Infrastructure** directory contents Terraform code for 3 environments deployemnt;<br>
**Database** directory contents .sql scripts for DB objects creation;<br>


## Application
There is dotnet application with 3 pages: root, check, info.<br>
**root** is the default root page;<br>
**info** is the page with database change functionality;<br>
**check** is **DVT** (Deployment Verification Test) page, it should check database connection and return the result.<br>
Application uses Azure Postgresql database.

### Build 
Build process (**build-AzureWebApp2.yml**) has the default "dotnet publish" command and container image upload to ACR.
Used ACR: arturzure.azurecr.io  

### Deployment and DVT
Deployment process (**deploy-AzureWebApp2.yml**) deploy the recent main-branch image from ACR to App Service.
Then Test stage process **DVT** using **check** status page.


## Infrastructure
Infrastructure is created based on "Initial task details" and contains: Azure App Svc, PostgreSQL database, Network resource and etc.<br>
**arturazuretfstate** storage account is used as Terraform state file storage.

### Provision process
Infrastructure is provisioned with **provision-AzureWebApp2.yml** pipeline which consist of 3 actions:<br>
1. Terraform Plan
2. Manual Plan output review
3. Terraform Apply


## Initial task details

**Note: part #2 is absent.**

Task Overview

1. Deploy an Application on Azure (Use Free Account)
- Create an Azure App Service that connects to a MySQL or PostgreSQL database using a private endpoint.
- The application should have a basic UI that interacts with the database (e.g., storing and retrieving data).
- Provide a simple web application (Node.js, Python, or any preferred language).
- Implement a test that verifies the database connection.
- All these Azure Resources should be created thought Infrastructure as Code (Terraform)

3. Containerization
- Package the application into a Docker image.
- Provide a Dockerfile to build and run the application locally.
- Run the application in a Docker container to ensure functionality. 

4. Infrastructure as Code (Terraform)
- Write a Terraform script that allows the infrastructure to be deployed in different environments (e.g., dev, staging, production).
- The script should provision:
    - Azure App Service
    - Azure Database (MySQL/PostgreSQL)
    - Vnet, Subnets
    - Private Endpoint
- Ensure variables can be used for different configurations. 

5. CI/CD Pipeline (Use Free Account)
Create a GitLab CI/CD or GitHub Actions pipeline to automate the following:
- Build and push the Docker image to a container registry (Azure Container Registry or Docker Hub).
- Deploy the Terraform infrastructure.
- Deploy the application to Azure App Service.
- Run some simple tests to verify the application.
