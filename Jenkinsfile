pipeline {
    agent any
    environment {
        GITNAME = 'Hanseok-git'
        GITMAIL = 'seogh31@gmail.com'
        GITWEBADD = 'https://github.com/Hanseok-git/fast-code.git'
        GITSSHADD = 'git@github.com:Hanseok-git/fast-code.git'
        GITCREDENTIAL = 'git_cre'
        DOCKERHUB = 'seogh31/fast'
        DOCKERHUBCREDENTIAL = 'docker_cre'
    }
    stages {
        stage('start') {
            steps {
                sh "echo hello jenkins!!!"
            }
            post {
                failure {
                    sh "echo failed"
                }
                success {
                    sh "echo success"
                }
            }
        }
    }
}
