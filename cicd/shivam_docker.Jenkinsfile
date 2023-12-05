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
    DATE = new Date().format('yy.M')
    TAG = "${DATE}.${BUILD_NUMBER}"
  }
  stages {
    stage ('Build') {
      steps {
        sh 'mvn clean package'
      }
    }
    stage('Docker Build') {
      steps {
        script {
          docker.build("shivamkalbande/Jenkins_Pipeline_hello-world:${TAG}")
        }
      }
    }
    stage('Pushing Docker Image to Dockerhub') {
      steps {
        script {
          docker.withRegistry('https://registry.hub.docker.com', 'docker_credential') {
            docker.image("shivamkalbande/Jenkins_Pipeline_hello-world:${TAG}").push()
            docker.image("shivamkalbande/Jenkins_Pipeline_hello-world:${TAG}").push("latest")
          }
        }
      }
    }
    stage('Deploy'){
      steps {
        sh "docker stop hello-world | true"
        sh "docker rm hello-world | true"
        sh "docker run --name hello-world -d -p 9004:8080 shivamkalbande/Jenkins_Pipeline_hello-world:${TAG}"
      }
    }
  }
  post {
    always {
      deleteDir()
    }
  }
}
