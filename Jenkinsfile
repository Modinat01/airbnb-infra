def COLOR_MAP = [
    'SUCCESS': 'good',
    'FAILURE': 'danger',
]    
pipeline {
    agent any

    stages {
        stage('Git checkout') {
            steps {
                echo 'Cloning project codebase'
                git branch: 'main', url: 'https://github.com/Modinat01/airbnb-infra.git'
                sh 'ls'
            }
        }
        stage('Verify terraform version') {
            steps {
                echo 'Verifying the Terraform version...'
                sh 'terraform --version'
            }
        }
        stage('Terraform init') {
            steps {
                echo 'Initialiazing Terraform project...'
                sh 'terraform init'
            }
        }
        stage('Terraform Validate') {
            steps {
                echo 'Validate Terraform project...'
                sh 'terraform validate'
            }
        }
        stage('Terraform plan') {
            steps {
                echo 'Terraform plan for the dry run...'
                sh 'terraform plan'
            }
        }
        stage('checkov scan') {
            steps {
                
                sh """
                sudo pip3 install checkov
            
                checkov -d . --skip-check CKV_AWS_79
                """
            }
        }
        stage('Manual approval') {
            steps {
                input 'Approval required for deployment'
            }
        }
        stage('Terraform apply') {
            steps {
                echo 'Terraform apply...'
                sh 'sudo terraform apply --auto-approve'
            }
        }
    }
    
    
    post { 
        always { 
            echo 'I will always say Hello again!'
            slackSend channel: '#glorious-w-f-devops-alerts', color: COLOR_MAP[currentBuild.currentResult], message: "*${currentBuild.currentResult}:* Job ${env.JOB_NAME} build ${env.BUILD_NUMBER} \n More info at: ${env.BUILD_URL}"


        }
    }
    
    
}
