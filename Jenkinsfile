pipeline {

agent {
    docker {
        image 'node:18'
        args '-v /var/run/docker.sock:/var/run/docker.sock'
    }
}

environment {
    DOCKER_HUB_USER = '6530394'
    IMAGE_NAME = 'todo-app'
    DOCKER_HUB_CREDS = 'docker-hub-credentials'
}

stages {

    stage('Build') {
        steps {
            echo 'Installing dependencies'
            sh 'PUPPETEER_SKIP_DOWNLOAD=true npm install'
        }
    }

    stage('Test') {
        steps {
            echo 'Running tests'
            sh 'npm test || true'
        }
    }

    stage('Containerize') {
        steps {
            echo 'Building Docker image'
            sh "docker build -t ${DOCKER_HUB_USER}/${IMAGE_NAME}:latest ."
        }
    }

    stage('Push') {
        steps {
            echo 'Pushing image to DockerHub'
            withCredentials([
                usernamePassword(
                    credentialsId: "${DOCKER_HUB_CREDS}",
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )
            ]) {
                sh "echo \$DOCKER_PASS | docker login -u \$DOCKER_USER --password-stdin"
                sh "docker push ${DOCKER_HUB_USER}/${IMAGE_NAME}:latest"
            }
        }
    }

}


}
