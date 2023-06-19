pipeline {
    properties([disableConcurrentBuilds(), buildDiscarder(logRotator(artifactDaysToKeepStr: '', artifactNumToKeepStr: '', daysToKeepStr: '', numToKeepStr: '5')), pipelineTriggers([githubPush()])])
    agent {label '192.168.3.145'}
    environment {
        def int lastrelis = "${env.BUILD_NUMBER}"
    }

    stages {
        stage('Hello') {
            steps {
                echo 'blog2-web_rails'
            }
        }
        stage('Source') { // Get code
            steps {
                // get code from our git repository web-rails
                git branch: 'main', url: 'https://github.com/alexandr755/blog2-web_rails.git'
            }
        }
		stage('Build Docker Image') {
            steps {
                // Шаг для сборки Docker-образа
                script {
                    sh 'echo docker build1 '
                //    docker.build("blog4_traefik-web_rails_jenkins")
                //    sh 'docker-compose up -d'
                }
            }
        }
        stage('Cleanup') {
            steps {
                // Шаг для очистки ресурсов
                script {
                echo "Docker remove is now  ${env.BUILD_NUMBER}"
                echo "Docker remove is last  ${env.lastrelis}"
                //    docker.image("blog4_traefik-web_rails_jenkins:${env.BUILD_NUMBER}").remove()
               // sh "docker rmi --force blog4_traefik-web_rails_jenkins:${env.BUILD_NUMBER}" /* clean up dockerfile images*/
                sh "docker image prune -f"
                }
            }
        }
        stage('Compile') { // Compile and do unit testing
            steps {
                // run gradle to execute compile and unit testing
                //sh "gradle clean compileJava test"
                sh 'echo docker build '
                //echo "Active user is now ${params.USERID}"
            }
        }
        stage('Run Container') {
            steps {
                script {
                // Шаг для запуска контейнера
                sh "docker-compose down &> /dev/null || true &> /dev/null"
                timeout (time:10, unit: 'SECONDS') {
                sh "docker-compose up -d"       
                }
                }
            }
        }
    }
    post {
    always {
      mail to: 'buk.av@tot.biz.ua',
        subject: "Status of pipeline: ${env.PROJECT_NAME} / ${currentBuild.fullDisplayName}",
        body: "${env.PROJECT_NAME} / ${env.BUILD_URL} has result ${currentBuild.result}  Active user is now ${params.USERID}"
    }
  }
    
}
