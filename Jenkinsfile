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
                sh 'mvn sonar:sonar -Dsonar.host.url=http://65.2.142.150:9000/ -Dsonar.login=sqa_6efb7be29058cb368f8fc097a44f939b21f75993 -Dsonar.login=admin -Dsonar.password=sonarqube -Dsonar.junit.reportPaths=target/surefire-reports -Dsonar.java.binaries=target'
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

        // stage ('Artifactory Configuration') {
        //     steps {
        //         sh 'curl -sSf -u admin:Artifactory1! -X PUT -T target/spring-petclinic-*-SNAPSHOT.jar http://3.108.250.217:8081/artifactory/pet-clinic/'
        //         sh 'curl -sSf -u admin:Artifactory1! -X PUT -T target/spring-petclinic-*-SNAPSHOT.jar http://3.108.250.217:8081/artifactory/pet-clinic/spring-petclinic-${BUILD_NUMBER}-SNAPSHOT.jar'
        //     }
        // }  

        stage ('Docker Image Configuration') {

            steps {   
                    sh 'sudo service docker start'    
                    sh 'sudo docker login -u="srichandana" -p="docker@2022"'        
                    sh 'sudo docker build --tag srichandana/petclinic:${BUILD_NUMBER} .'
                    //sh 'docker tag srichandana/petclinic:latest srichandana/petclinic:${BUILD_NUMBER}'
                    sh 'sudo docker push srichandana/petclinic:${BUILD_NUMBER}'               
            }
        } 

        stage ('Deploy to EKS') {

            steps {   
                    
                    sh 'helm upgrade --install pet-clinic --set image.tag=${BUILD_NUMBER} ./helm/pet-clinic'    
                                  
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
