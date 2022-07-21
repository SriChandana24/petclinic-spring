pipeline {
    
    agent {
            label 'maven'
        } 
    
    stages {        
                
        stage ('Run Tests') {

            steps {                
                    sh 'mvn clean install'                
            }
        }

        stage('SonarQube Analysis') {

            steps{
                sh 'mvn sonar:sonar -Dsonar.host.url=http://3.110.222.216:9000/ -Dsonar.login=sqa_6efb7be29058cb368f8fc097a44f939b21f75993 -Dsonar.login=admin -Dsonar.password=sonarqube -Dsonar.junit.reportPaths=target/surefire-reports -Dsonar.java.binaries=target'
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

        stage ('Artifactory Configuration') {
            steps {
                sh 'curl -sSf -u admin:Artifactory1! -X PUT -T target/spring-petclinic-*-SNAPSHOT.jar http://3.110.222.216:8081/artifactory/pet-clinic/'
                sh 'curl -sSf -u admin:Artifactory1! -X PUT -T target/spring-petclinic-*-SNAPSHOT.jar http://3.110.222.216:8081/artifactory/pet-clinic/spring-petclinic-${BUILD_NUMBER}-SNAPSHOT.jar'
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
