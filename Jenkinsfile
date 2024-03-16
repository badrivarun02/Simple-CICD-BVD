// JENKINS CI PIPELINE/
// Purpose: The Code will be built into executable file (.jar) & pushed to Dockerhub


pipeline {
    agent any
     // DECLARE THE VARIABLES HERE:
    environment {
        DOCKER_USERNAME = "badrivarun"     // docker username
        DOCKERHUB_CREDENTIALS=credentials('dockercred')   // dockerpwd as check the 'ID' in your Jenkins credentials

    }

    stages {
        stage("1. Cleanup") {
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
            def JOB = env.JOB_NAME.toLowerCase()           // Convert Jenkins Job name to lower-case
            bat "docker build -t ${JOB}:${BUILD_NUMBER} ."
            bat "docker tag ${JOB}:${BUILD_NUMBER} ${DOCKER_USERNAME}/${JOB}:v${BUILD_NUMBER}"
            
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
                    withDockerRegistry(credentialsId: 'dockercred', url: 'https://registry-1.docker.io/v2/', variable: "dockerpos") {
                    //bat 'echo %DOCKERHUB_CREDENTIALS_PSW% | docker login -u %DOCKERHUB_CREDENTIALS_USR% --password-stdin'
                    bat 'docker login -u ${DOCKER_USERNAME} -p ${dockerpos}'
                    bat 'docker push ${DOCKER_USERNAME}/${JOB}:v${BUILD_NUMBER}'
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
    }
    
    
    post{
        always{
            emailext (
                    subject: "${currentBuild.currentResult}: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'",
                     body: """<p>STARTED: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]':</p>
                             <p>Check console output at <a href='${env.BUILD_URL}'>${env.BUILD_URL}</a></p>""",
                    to: 'badrivarun09@gmail.com',
                    attachLog: true
                )
           }
    }
     
}    
       

    

        
        
