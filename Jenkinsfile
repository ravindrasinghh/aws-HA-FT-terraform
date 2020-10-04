pipeline {
  environment {
    TF_WORKSPACE = 'dev' //Sets the Terraform Workspace
  }
  stages {
    stage('Terraform Init') {
      steps {
        sh "${env.TERRAFORM_HOME}/terraform init -input=false"
      }
    }
  }
}
