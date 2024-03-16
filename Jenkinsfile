// JENKINS CI PIPELINE/
// Purpose: The Code will be built into executable file (.jar) & pushed to Dockerhub


pipeline {
    agent any
     // DECLARE THE VARIABLES HERE:
    environment {
        DOCKER_USERNAME = "badrivarun"     // check the 'ID' in your Jenkins credentials
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

        stage('6. Docker Image Build') {
            // Build Docker Image 
            steps{
                    // go to directory where 'Dockerfile' is stored
                    script {
                      def JOB = env.JOB_NAME.toLowerCase()           // Convert Jenkins Job name to lower-case
                      bat "docker build -t ${JOB}:${BUILD_NUMBER} ."  // 'JOB_NAME' & 'BUILD_NUMBER' are Jenkins Global variable
                    }
                }
            }
        
        
        stage('7. Docker Image Tag') {
            // Rename the Docker Image before pushing to Dockerhub
            steps{
                     // go to directory where Docker Image is created
                  script {
                    def JOB = env.JOB_NAME.toLowerCase() // Convert Jenkins Job name to lower-case
                    bat "docker tag ${JOB}:${BUILD_NUMBER} ${DOCKER_USERNAME}/${JOB}:v${BUILD_NUMBER}"
                   
                  }
                }
            } 
        stage('8. Trivy Image Scan') {
            // Scan Docker images for vulnerabilities 
            steps{
                script { 
                  def JOB = env.JOB_NAME.toLowerCase() // Convert Jenkins Job name to lower-case
                  bat "trivy image  ${DOCKER_USERNAME}/${JOB}:v${BUILD_NUMBER} > scan.txt"
                }
            }
        }
        stage('9. Docker Image Push') {
            // Login to Dockerhub & Push the image to Dockerhub
            steps{
                script { 
                 docker.withRegistry('', 'DOCKER_USERNAME' )  {
                    
                    def JOB = env.JOB_NAME.toLowerCase() // Convert Jenkins Job name to lower-case
                    bat "docker push ${DOCKER_USERNAME}/${JOB}:v${BUILD_NUMBER}"
                    
                  }
                }
            }
        }

        stage('10. Docker Image Cleanup') {
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
       

    

        
        
