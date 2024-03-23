// JENKINS CI PIPELINE/
// Purpose: The Code will be built into executable file (.jar) & pushed to Dockerhub


pipeline {
<<<<<<< HEAD
    agent any
     // DECLARE THE VARIABLES HERE:
    environment {
        DOCKER_USERNAME = "badrivarun"     // docker username
          // dockerpwd as check the 'ID' in your Jenkins credentials
=======
    agent any // This pipeline can be executed on any available agent
     // DECLARE THE VARIABLES HERE:
    environment {
        DOCKER_USERNAME = "badrivarun"     // docker username
          
>>>>>>> master

    }

    stages {
        stage ("1. Cleanup") {
            // Clean workspace directory for the current build
            steps {
<<<<<<< HEAD
                deleteDir ()             
=======
                deleteDir ()     // Deletes the current directory in a workspace        
>>>>>>> master
            }
           }
         
        stage ('2. Git Checkout') {
            // use pipeline syntax generator to generate below step
            // 'Pipeline syntax' --> Steps 'Smaple step' --> git (enter url & branch & generate)
            steps {
<<<<<<< HEAD
                
=======
                // Checks out code from the specified git repository
>>>>>>> master
                git branch: 'main', url: 'https://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@github.com/badrivarun02/Java2024.git'
                
            }
        } 
        stage("3. Maven Unit Test") {  
            // Test the individual units of code 
            steps{
<<<<<<< HEAD
                
=======
                 // Executes the maven command for unit testing
>>>>>>> master
                  bat 'mvn test'        
                }
        }
        

        stage('4. Maven Build') {
            // Build the application into an executable file (.jar)
            steps{
<<<<<<< HEAD
               
=======
               // Executes the maven command for building the project
>>>>>>> master
                  bat 'mvn clean install'   
                }
        }
        

        stage("5. Maven Integration Test") {
            //  Test the interaction between different units of code
            steps{
<<<<<<< HEAD
                
=======
                // Executes the maven command for integration testing
>>>>>>> master
                  bat 'mvn verify'          
                }
        }
        
        stage('archive and test result'){
          steps{
<<<<<<< HEAD
            
=======
            // Archives the artifacts (in this case, .jar files)
>>>>>>> master
            archiveArtifacts artifacts: '**/*.jar', followSymlinks: false
            }
        
        }

        stage('6. Docker Image Build and tag ') {
          steps{
           script {
                def JOB = env.JOB_NAME.toLowerCase() // Convert Jenkins job name to lowercase
<<<<<<< HEAD
                bat "docker build -t ${JOB}:${BUILD_NUMBER} ."
=======
                // Build the Docker image
                bat "docker build -t ${JOB}:${BUILD_NUMBER} ."
                // Tag the Docker image
>>>>>>> master
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
<<<<<<< HEAD
=======
                  // Scan the Docker image using Trivy
>>>>>>> master
                  bat "trivy image  ${DOCKER_USERNAME}/${JOB}:v${BUILD_NUMBER} > scan.txt"
                }
            }
        }
        stage('8. Docker Image Push') {
            // Login to Dockerhub & Push the image to Dockerhub
            steps{
                script { 
                    def JOB = env.JOB_NAME.toLowerCase() // Convert Jenkins job name to lowercase
<<<<<<< HEAD
                /* Method:1 
                    withDockerRegistry(credentialsId: 'dockerpwd') {
                        bat "docker push ${DOCKER_USERNAME}/${JOB}:v${BUILD_NUMBER}" 
                        */
                //Method:2
                // Convert Jenkins job name to lowercase
                    withCredentials([usernamePassword(credentialsId: 'dockerpwd', passwordVariable: 'dockerp', usernameVariable: 'dockeruser')]) {
                        bat "docker login -u %dockeruser% -p %dockerp%"   // login into docker account , we can also use like this- bat "docker login -u ${dockeruser} -p ${dockerp}"
=======
                
                // Method:1 
                    // withDockerRegistry(credentialsId: 'dockerpwd') {
                    //     bat "docker push ${DOCKER_USERNAME}/${JOB}:v${BUILD_NUMBER}" 
                    // }
                    // Method:2
                    // Convert Jenkins job name to lowercase
                    withCredentials([usernamePassword(credentialsId: 'dockerpwd', passwordVariable: 'dockerp', usernameVariable: 'dockeruser')]) {
                        // Login into Docker account
                        bat "docker login -u %dockeruser% -p %dockerp%"   // We can also use like this- bat "docker login -u ${dockeruser} -p ${dockerp}"
                        // Push the Docker image to Dockerhub
>>>>>>> master

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
<<<<<<< HEAD
=======
                    // This command removes all unused images not just dangling ones
>>>>>>> master
                  bat "docker image prune -af"
                }
            }
        }
        stage("deploy onto kubernetes"){
            steps{
<<<<<<< HEAD
=======
                // This step uses the Kubernetes configuration file to deploy the application
>>>>>>> master
                withCredentials([file(credentialsId: 'config', variable: 'CA_CERTIFICATE')]) {
                    kubeconfig(
                        credentialsId: 'config',
                        serverUrl: '',
                        caCertificate: '%env.CA_CERTIFICATE%'
                    ) {
<<<<<<< HEAD
                       bat 'kubectl apply -f SAforJenkins.yaml -f deployment.yaml -f service.yaml'
=======
                         // Apply the Kubernetes configuration files
                        bat 'kubectl apply -f SAforJenkins.yaml -f deployment.yaml -f service.yaml'
                        // Get the status of all Kubernetes resources
>>>>>>> master
                        bat 'kubectl get all'
                    }
                }
            }
        }  
    }
    
    
    post {
    always {
        script{
<<<<<<< HEAD
                env.BUILD_TIMESTAMP = new Date(currentBuild.startTimeInMillis).format('MMMM dd, yyy | hh:mm:ss aaa | z')
            }
=======
                  // Format the build timestamp
                env.BUILD_TIMESTAMP = new Date(currentBuild.startTimeInMillis).format('MMMM dd, yyy | hh:mm:ss aaa | z')
            }
            // Send an email with the build report
>>>>>>> master
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

    
     
    
       

    

        
        
