pipeline {
    agent any

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
                dir ("javapp"){
                  sh 'mvn test'        
                }
            }
        }

        stage('4. Maven Build') {
            // Build the application into an executable file (.jar)
            steps{
                dir ("javapp"){
                  sh 'mvn clean install'   
                }
            }
        }

        stage("5. Maven Integration Test") {
            //  Test the interaction between different units of code
            steps{
                dir ("javapp"){
                  sh 'mvn verify'          
                }
            }
        }
       stage('archive and test result'){
          steps{
            dir ("javapp"){ 
            junit '**/surefire-reports/*.xml'
            archiveArtifacts artifacts: '**/*.war', followSymlinks: false
            }
        }
       }
    }   
       
       
}
    

        
        
