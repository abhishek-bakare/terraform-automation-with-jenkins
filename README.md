# Terraform Automation with Jenkins
# Steps:-
- Launch EC2, install java & Jenkins
- Install Terraform
- Clone the code using link https://github.com/abhishek-bakare/terraform-automation-with-jenkins.git
- Write the pipeline as below
- Store tfstate file in S3 and lock it using DynamoDB

## To store tfstate file in S3 and lock using DynamoDB follow below steps
- First we need to create 'backend.tf' file as available in this repo
- Then manually create S3 bucket with uniwue name & also create DynamoDB table
- Don't forget to enable versioning on bucket
- Then add names of bucker and DB table in 'backend.tf' file
## Here's is the Jenkins pipeline file you need to put in scripts
```
pipeline {
    agent any

    stages {
        stage('Clonig git') {
            steps {
                checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/abhishek-bakare/terraform-automation-with-jenkins.git']])
            }
        }
        
        stage('Terraform init') {
            steps {
                sh 'terraform init --reconfigure'
            }
        }
        
        stage('Terraform validate') {
            steps {
                sh 'terraform validate'
            }
        }
        
        stage('Terraform actions') {
            steps {
                echo 'Select actions to perform ${action}'
                sh ('terraform ${action} --auto-approve')
            }
        }
    }
}
```

> Here in Jenkins I have use "This project is parameterized" option to set up parameters at the time of Build/Run job.
