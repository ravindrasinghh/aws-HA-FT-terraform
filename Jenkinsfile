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
        sh "terraform init -input=false"
      }
    }
    tage('Terraform plan') {
        when {
                branch 'master'
            }
      steps {
        sh "terraform plan"
      }
    }
  }
}
