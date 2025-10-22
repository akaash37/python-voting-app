pipeline {
    agent any

    environment {
        AWS_REGION     = "us-east-1"
        AWS_ACCOUNT    = "493287571019"
        ECR_REPO       = "${AWS_ACCOUNT}.dkr.ecr.${AWS_REGION}.amazonaws.com/python_app"
        IMAGE_TAG      = "${ECR_REPO}:vote-v${BUILD_NUMBER}"
        APP_USER       = "ubuntu"
        APP_HOST       = "10.0.4.220"
        SSH_CRED_ID    = "app-host-key"
    }

    stages {
        stage('Checkout') {
            steps {
                echo "📦 Checking out source code..."
                checkout scm
            }
        }

        stage('Build & Push Docker Image') {
            steps {
                sh '''
                    cd vote
                    echo "🔐 Logging in to AWS ECR..."
                    aws ecr get-login-password --region ${AWS_REGION} | docker login --username AWS --password-stdin ${AWS_ACCOUNT}.dkr.ecr.${AWS_REGION}.amazonaws.com

                    echo "🐳 Building Docker image..."
                    docker build -t ${IMAGE_TAG} .

                    echo "📤 Pushing image to ECR..."
                    docker push ${IMAGE_TAG}
                '''
            }
        }

        stage('Deploy to App Host') {
            steps {
                echo "🚀 Deploying on EC2 app host..."
                sshagent (credentials: [SSH_CRED_ID]) {
                    sh '''
                        ssh -o StrictHostKeyChecking=no ${APP_USER}@${APP_HOST} "
                            echo '🔐 Logging in to ECR...'
                            aws ecr get-login-password --region ${AWS_REGION} | docker login --username AWS --password-stdin ${AWS_ACCOUNT}.dkr.ecr.${AWS_REGION}.amazonaws.com
                            
                            echo '📥 Pulling latest image...'
                            docker pull ${IMAGE_TAG} || true
                            
                            echo '🛑 Stopping old container (if running)...'
                            docker stop vote_app || true
                            docker rm vote_app || true
                            
                            echo '🚢 Starting new container...'
                            docker run -d --name vote_app -p 80:80 ${IMAGE_TAG}
                        "
                    '''
                }
            }
        }
    }

    post {
        success {
            echo "✅ Deployment completed successfully!"
        }
        failure {
            echo "❌ Pipeline failed. Check Jenkins logs for details."
        }
    }
}
