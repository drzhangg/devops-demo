pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/drzhangg/devops-demo.git']]])
            }
        }

        stage('Build') {
            steps {
                sh 'go build -o myapp'
            }
        }

        stage('Deploy') {
            steps {
                sshagent(['my-ssh-key']) {
                    sh 'ssh root@172.31.73.66 "mkdir -p /path/to/deploy"'
                    sh 'scp myapp root@172.31.73.66:/path/to/deploy/myapp'
                    sh 'ssh root@172.31.73.66 "systemctl restart myapp.service"'
                }
            }
        }
    }

    post {
        success {
            slackSend message: "Build and deploy of myapp succeeded!", channel: '#myapp-builds'
        }

        failure {
            slackSend message: "Build or deploy of myapp failed!", channel: '#myapp-builds'
        }
    }
}
