pipeline
{
    agent any
    options
    {
        buildDiscarder(logRotator(numToKeepStr: "10")) 
    } 
  stages {
    stage('Terraform Init') {
        when {
                branch 'master'
            }
      steps {
        sh "${env.TERRAFORM_HOME}/terraform init -input=false"
      }
    }
  }
}
