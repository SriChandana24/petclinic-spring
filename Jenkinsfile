pipeline {
    
    agent {
            label 'maven'
        } 
    
    stages {

        stage ('setup') {

            steps {                
                    sh 'mvn clean install'                
            }
        }

        stage ('test Stage') {

            steps {                
                    sh 'mvn test'                
            }
        }
        stage ('Compile Stage') {

            steps {                
                    sh 'mvn clean compile'                
            }
        }
        stage('SonarQube Analysis') {

            steps{
                sh 'mvn clean sonar:sonar -Dsonar.host.url=http://43.204.145.100:9000/   -Dsonar.login=sqa_6efb7be29058cb368f8fc097a44f939b21f75993 -Dsonar.login=admin -Dsonar.password=sonarqube -Dsonar.java.binaries=target'
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
