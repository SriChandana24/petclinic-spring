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

        stage ('Artifactory configuration') {
            steps {
                rtServer (
                    id: 'jfrog-artifactory-server',
                    url: 'http://13.233.159.66:8081',
                    username: 'admin',
                    password: 'Artifactory1!'

                )

                rtUpload (
                    serverId: 'jfrog-artifactory-server',
                    specPath: '/var/jenkins-new/workspace/pet-clinic/target/*.jar',
 
                    // Optional - Associate the uploaded files with the following custom build name and build number.
                    // If not set, the files will be associated with the default build name and build number (i.e the
                    // the Jenkins job name and number).
                    //buildName: 'holyFrog',
                    //buildNumber: '42',
                    // Optional - Only if this build is associated with a project in Artifactory, set the project key as follows.
                    project: 'pet-clinic'
)
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
