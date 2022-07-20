pipeline {
    
    agent {
            label 'maven'
        } 
    
    stages {        
                
        stage('SonarQube Analysis') {

            steps{
                sh 'mvn clean sonar:sonar -Dsonar.host.url=http://3.110.115.187:9000/   -Dsonar.login=sqa_6efb7be29058cb368f8fc097a44f939b21f75993 -Dsonar.login=admin -Dsonar.password=sonarqube -Dsonar.java.binaries=target/classes'
            }
        }

        stage ('Run Tests') {

            steps {                
                    sh 'mvn clean install'                
            }
        }

        stage ('Compile Stage') {

            steps {                
                    sh 'mvn clean compile'                
            }
        }
        
        stage ('Build') {
            steps {                
                    sh 'mvn package'                
            }
        }                
                
    }

    post {
            always {
                archiveArtifacts artifacts: 'target/*.jar', fingerprint: true
                junit 'target/surefire-reports/*.xml'
            }
        }
        


}
