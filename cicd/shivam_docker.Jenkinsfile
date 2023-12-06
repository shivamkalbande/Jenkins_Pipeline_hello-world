pipeline {
    agent any
    options {
        disableConcurrentBuilds()
        disableResume()
        buildDiscarder(logRotator(numToKeepStr: '10'))
        timeout(time: 1, unit: 'HOURS')
    }
    tools {
        maven 'maven-3.6.3'
    }
    environment {
        TAG = "${BUILD_NUMBER}-${new Date().format('yyyyMMdd-HHmmss')}"
    }
    stages {
        stage('Build') {
            steps {
                script {
                    catchError {
                        sh './mvnw clean package'
                    }
                }
            }
        }
        stage('Docker Build') {
            steps {
                script {
                    docker.build("shivamkalbande/jenkins_pipeline_hello_world:${TAG}")
                }
            }
        }
        stage('Pushing Docker Image to Dockerhub') {
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'docker_credential') {
                        docker.image("shivamkalbande/jenkins_pipeline_hello_world:${TAG}").push()
                        docker.image("shivamkalbande/jenkins_pipeline_hello_world:${TAG}").push("latest")
                    }
                }
            }
        }
        stage('Deploy') {
            steps {
                sh "docker stop hello-world || true"
                sh "docker rm hello-world || true"
                sh "docker run --name hello-world -d -p 9004:8080 shivamkalbande/jenkins_pipeline_hello_world:${TAG}"
            }
        }
    }
    post {
        success {
            deleteDir()
        }
    }
}
