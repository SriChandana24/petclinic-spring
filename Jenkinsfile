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
                sh 'mvn sonar:sonar -Dsonar.host.url=http://13.233.159.66:9000/ -Dsonar.login=sqa_6efb7be29058cb368f8fc097a44f939b21f75993 -Dsonar.login=admin -Dsonar.password=sonarqube -Dsonar.junit.reportPaths=target/surefire-reports -Dsonar.java.binaries=target'
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
                sh 'curl -sSf -u admin:Artifactory1! -X PUT -T target/spring-petclinic-*-SNAPSHOT.jar http://13.233.159.66:8081/artifactory/pet-clinic/'
            }
        }    

        stage ('Deploy using Ansible')  {
            steps{
                sh 'ansible-playbook ansible-playbook.yml'
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
