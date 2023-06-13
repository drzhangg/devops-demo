pipeline {

  agent {
    label 'go'
  }

  environment {

    // 您 Docker Hub 仓库的地址
    REGISTRY = 'docker.io'

    // 您的 Docker Hub 用户名
    DOCKERHUB_USERNAME = 'drzhangg'

    // Docker 镜像名称
    APP_NAME = 'devops-go-demo'

    // 'dockerhubid' 是您在 KubeSphere 用 Docker Hub 访问令牌创建的凭证 ID
    DOCKERHUB_CREDENTIAL = credentials('dockerhub')

    // 您在 KubeSphere 创建的 kubeconfig 凭证 ID
    KUBECONFIG_CREDENTIAL_ID = 'k8s'

    // 您在 KubeSphere 创建的项目名称，不是 DevOps 项目名称
    PROJECT_NAME = 'test-devops'

  }


  stages {

    stage('checkout scm'){
       steps{
          checkout(scm)
       }
    }

    stage('docker login') {
      steps{
        container ('go') {
          sh 'echo $DOCKERHUB_CREDENTIAL_PSW | docker login -u $DOCKERHUB_CREDENTIAL_USR --password-stdin'
        }
      }
    }

    stage('build & push') {
      steps {
        container ('go') {

//           sh 'git clone https://github.com/drzhangg/devops-demo.git'

          // sh 'cd devops-demo && docker build -t $REGISTRY/$DOCKERHUB_USERNAME/$APP_NAME .'
//           sh 'cd devops-demo && docker build -t $DOCKERHUB_USERNAME/$APP_NAME .'
             sh 'docker build -t $DOCKERHUB_USERNAME/$APP_NAME .'

          // sh 'docker push $REGISTRY/$DOCKERHUB_USERNAME/$APP_NAME'
          sh 'docker push $DOCKERHUB_USERNAME/$APP_NAME'

        }
      }
    }

    stage ('deploy app') {
      steps {
         container ('go') {
            withCredentials([
              kubeconfigFile(

                credentialsId: env.KUBECONFIG_CREDENTIAL_ID,

                variable: 'KUBECONFIG')

              ]) {

              sh 'envsubst < deploy/deploy.yaml | kubectl apply -f -'
            }
         }
      }
    }
  }
}
