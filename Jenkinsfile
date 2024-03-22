// JENKINS CI PIPELINE/
// Purpose: The Code will be built into executable file (.jar) & pushed to Dockerhub


pipeline {
    agent any
     // DECLARE THE VARIABLES HERE:
    environment {
        DOCKER_USERNAME = "badrivarun"     // docker username
          // dockerpwd as check the 'ID' in your Jenkins credentials

    }

    stages {
        stage ("1. Cleanup") {
            // Clean workspace directory for the current build
            steps {
                deleteDir ()             
            }
           }
         
        stage ('2. Git Checkout') {
            // use pipeline syntax generator to generate below step
            // 'Pipeline syntax' --> Steps 'Smaple step' --> git (enter url & branch & generate)
            steps {
                
                git branch: 'main', url: 'https://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@github.com/badrivarun02/Java2024.git'
                
            }
        } 
        stage("3. Maven Unit Test") {  
            // Test the individual units of code 
            steps{
                
                  bat 'mvn test'        
                }
        }
        

        stage('4. Maven Build') {
            // Build the application into an executable file (.jar)
            steps{
               
                  bat 'mvn clean install'   
                }
        }
        

        stage("5. Maven Integration Test") {
            //  Test the interaction between different units of code
            steps{
                
                  bat 'mvn verify'          
                }
        }
        
        stage('archive and test result'){
          steps{
            
            archiveArtifacts artifacts: '**/*.jar', followSymlinks: false
            }
        
        }

        stage('6. Docker Image Build and tag ') {
          steps{
           script {
                def JOB = env.JOB_NAME.toLowerCase() // Convert Jenkins job name to lowercase
                bat "docker build -t ${JOB}:${BUILD_NUMBER} ."
                bat "docker tag ${JOB}:${BUILD_NUMBER} ${DOCKER_USERNAME}/${JOB}:v${BUILD_NUMBER}"
                bat "docker tag ${JOB}:${BUILD_NUMBER} ${DOCKER_USERNAME}/${JOB}:latest"                    
             }
          }
        }
        stage('7. Trivy Image Scan') {
            // Scan Docker images for vulnerabilities 
            steps{
                script { 
                  def JOB = env.JOB_NAME.toLowerCase() // Convert Jenkins Job name to lower-case
                  bat "trivy image  ${DOCKER_USERNAME}/${JOB}:v${BUILD_NUMBER} > scan.txt"
                }
            }
        }
        stage('8. Docker Image Push') {
            // Login to Dockerhub & Push the image to Dockerhub
            steps{
                script { 
                    def JOB = env.JOB_NAME.toLowerCase() // Convert Jenkins job name to lowercase
                /* Method:1 
                    withDockerRegistry(credentialsId: 'dockerpwd') {
                        bat "docker push ${DOCKER_USERNAME}/${JOB}:v${BUILD_NUMBER}" 
                        */
                //Method:2
                // Convert Jenkins job name to lowercase
                    withCredentials([usernamePassword(credentialsId: 'dockerpwd', passwordVariable: 'dockerp', usernameVariable: 'dockeruser')]) {
                        bat "docker login -u %dockeruser% -p %dockerp%"   // login into docker account , we can also use like this- bat "docker login -u ${dockeruser} -p ${dockerp}"

                        bat "docker push ${DOCKER_USERNAME}/${JOB}:v${BUILD_NUMBER}"
                        bat "docker push ${DOCKER_USERNAME}/${JOB}:latest"
                      
                  }
                }
            }
        }
    

        stage('9. Docker Image Cleanup') {
            // Remove the unwanted (dangling) images created in Jenkins Server to free-up space
            steps{
                script { 
                  bat "docker image prune -af"
                }
            }
        }
        stage("deploy onto kubernetes"){
            steps{
                withCredentials([file(credentialsId: 'config', variable: 'CA_CERTIFICATE')]) {
                    kubeconfig(
                        credentialsId: 'config',
                        serverUrl: '',
                        caCertificate: '%env.CA_CERTIFICATE%'
                    ) {
                       bat 'kubectl apply -f SAforJenkins.yaml -f deployment.yaml -f service.yaml'
                        bat 'kubectl get all'
                    }
                }
            }
        }  
    }
    
    
    post {
    always {
        script{
                env.BUILD_TIMESTAMP = new Date(currentBuild.startTimeInMillis).format('MMMM dd, yyy | hh:mm:ss aaa | z')
            }
        emailext (
            subject: "${currentBuild.currentResult} Build Report as of ${BUILD_TIMESTAMP} — ${env.JOB_NAME}",
            body: """The Build report for ${env.JOB_NAME} executed via Jenkins has finished its latest run.

- Job Name: ${env.JOB_NAME}
- Job Status: ${currentBuild.currentResult}
- Job Number: ${env.BUILD_NUMBER}
- Job URL: ${env.BUILD_URL}

Please refer to the build information above for additional details.

This email is generated automatically by the system.

Thanks""",
            recipientProviders: [[$class: 'DevelopersRecipientProvider']],
            to: 'badrivarun09@gmail.com',
            attachLog: true
        )
    }
}
}

    
     
    
       

    

        
        
