pipeline {
    agent {
        docker {
            image 'docker:24.0.5'
            args '-v /var/run/docker.sock:/var/run/docker.sock'
        }
    }

    environment {
        DOCKER_HUB_USER = '6530394'
        IMAGE_NAME = 'todo-app'
        DOCKER_HUB_CREDS = 'docker-hub-credentials'
        DOCKER_CONFIG = "${WORKSPACE}/.docker"
    }

    stages {

        stage('Build') {
            steps {
                echo 'Skipping npm install in CI'
            }
        }

        stage('Test') {
            steps {
                sh 'echo "No tests"'
            }
        }

        stage('Containerize') {
            steps {
                sh '''
                mkdir -p $DOCKER_CONFIG
                docker build -t ${DOCKER_HUB_USER}/${IMAGE_NAME}:latest .
                '''
            }
        }

        stage('Push') {
            steps {
                withCredentials([usernamePassword(credentialsId: "${DOCKER_HUB_CREDS}", usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh '''
                    mkdir -p $DOCKER_CONFIG
                    echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin
                    docker push ${DOCKER_HUB_USER}/${IMAGE_NAME}:latest
                    '''
                }
            }
        }

    }
}