pipeline {
    agent any
    environment {
        GITNAME = 'Hanseok-git'
        GITEMAIL = 'seogh31@gmail.com'
        GITWEBADD = 'https://github.com/Hanseok-git/fast-code.git'
        GITSSHADD = 'git@github.com:Hanseok-git/deployment1.git'
        GITCREDENTIAL = 'git_cre'
        DOCKERHUB = 'seogh31/fast'
        DOCKERHUBCREDENTIAL = 'docker_cre'
    }
    stages {
        stage('Checkout Github') {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [],
                userRemoteConfigs: [[credentialsId: GITCREDENTIAL, url: GITWEBADD]]])
            }
            post {
                failure {
                    sh "echo clone failed"
                }
                success {
                    sh "echo clone success"
                }
            }
        }
        stage('Docker Image Build') {
            steps {
                sh "docker build -t ${DOCKERHUB}:${currentBuild.number} ."
                sh "docker build -t ${DOCKERHUB}:latest ."
            }
            post {
                failure {
                    sh "echo image build failed"
                }
                success {
                    sh "echo image build success"
                }
            }
        }
        stage('Docker Image Push') {
            steps {
                withDockerRegistry(credentialsId: DOCKERHUBCREDENTIAL, url: '') {
                    sh "docker push ${DOCKERHUB}:${currentBuild.number}"
                    sh "docker push ${DOCKERHUB}:latest"
                }
            }
            post {
                failure {
                    sh "docker image rm -f ${DOCKERHUB}:${currentBuild.number}"
                    sh "docker image rm -f ${DOCKERHUB}:latest"
                    sh "echo push failed"
                }
                success {
                    sh "docker image rm -f ${DOCKERHUB}:${currentBuild.number}"
                    sh "docker image rm -f ${DOCKERHUB}:latest"
                    sh "echo push success"
                }
            }
        }
        stage('EKS Manifest File Update') {
            steps {
                git credentialsId: GITCREDENTIAL, url: GITSSHADD, branch: 'main'
                sh "git config --global user.email ${GITEMAIL}"
                sh "git config --global user.name ${GITNAME}"
                sh "sed -i 's@${DOCKERHUB}:.*@${DOCKERHUB}:${currentBuild.number}@g' fast.yml"
                sh "git add ."
                sh "git commit -m 'Update tag to ${currentBuild.number}'"
                sh "git push origin main"

                slackSend (
                    channel: '#dep02',
                    color: '#FFFF00',
                    message: "STARTED: ${currentBuild.number}"
                )
            }
            post {
                failure {
                    sh "echo manifest update failed"
                }
                success {
                    sh "echo manifest update success"
                }
            }
        }
    }
}              