# Automatic Scanning of Container Images in a CI/CD Pipeline with Trivy

Containerized applications provide the ability to package an application into a single component and quickly deploy it to many different types of systems. Usually the creation of images is developed as part of
a Code-Pipeline, and this example provides a simple way to add the scanning of an Image into an AWS CodePipeline, although this example could be integrated into any software such as Jenkins. The project contains a buildspec.yml
file which lives in the root directory for CodeBuild to read an execute. This file tells CodeBuild to download Trivy, install and run Docker, and execute a scan against the docker image built. The output is then sent to an s3 bucket,
where it is stored and parsed using S3 Select for vulnerabilities.

So what exactly is Trivy? Trivy is a simple, open source container image scanning tool. It runs a scan against your image, checking vulnerabilitiies associated with the software used to generate your Docker Image. Because a Docker Image is simply a collection of different layers of software, some users forget to update their Dockerfiles, importing outdated and vulnerable software into their application.

S3 Select is a service offered by AWS that allows the querying of data in the cloud without having to first download it. It reads structured data such as JSON from files in S3 and allows you to use SQL-like syntax to query the datasets. It is very useful for when you want to mimic a database but don't need the hassle of standing up an entire new database.

## **How Does This Work?**

 In your commit, you detail exactly what Docker image you would like to scanned. When you push a commit, preface the image name with ::. For example, a commit with the message "Fixed yum for image ::mysql:latest" would be correctly parsed, and the build would know to scan the mysql-latest container image. The buildspec file finds our Docker file under the directory that you specify. In the project, it finds the Dockerfile under docker/centos. If you make a MySQL image, you would create a new Dockerfile under the docker/mysql directory. This allows custom image building without having to import the image from an external repostiory, but an image could also be imported from ECR. 

## **Solution Overview**

![Solution Diagram](https://raw.githubusercontent.com/hrmcardle0/codepipeline-trivy-container-scanning/master/trivy-solution-diagram.png)
