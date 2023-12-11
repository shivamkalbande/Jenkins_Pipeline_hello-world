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
        TAG = "${BUILD_NUMBER}-${new Date().format('yyyyMMdd-HH')}"
    }
    stages {
        stage('Build') {
            steps {
                script {
                    catchError {
                        sh 'chmod +x ./mvnw'
                        sh './mvnw clean package'
                    }
                }
            }
        }
        stage('Docker Build') {
            steps {
                script {
                    docker.build("shivamk23/jenkins_pipeline_hello_world:${TAG}")
                }
            }
        }
        stage('Pushing Docker Image to Dockerhub') {
            steps {
                script {
                    // // Use the 'withCredentials' block to securely access Docker Hub credentials
            //withCredentials([usernamePassword(credentialsId: 'docker_credential_ssk', passwordVariable: 'DOCKER_PASSWORD', usernameVariable: 'DOCKER_USERNAME')]) {
              //  // Use the 'sh' step to execute shell commands
                //sh "echo \$DOCKER_PASSWORD | docker login -u \$DOCKER_USERNAME --password-stdin https://registry.hub.docker.com"
                //docker.image("shivamk23/ssk_devops_repo:${TAG}").push("latest")

            docker.withRegistry('https://registry.hub.docker.com', 'docker_credential_ssk') {
            docker.image("shivamk23/ssk_devops_repo:${TAG}").push()
            //docker.image("shivamk23/ssk_devops_repo:${TAG}").push("latest")
                    }
                }
            }
        }
        stage('Deploy') {
            steps {
                sh "docker stop hello-world || true"
                sh "docker rm hello-world || true"
                sh "docker run --name hello-world -d -p 9004:8080 shivamk23/ssk_devops_repo:${TAG}"
                //sh "docker run hello-world"
            }
        }
    }
    post {
        success {
            deleteDir()
        }
    }
}
