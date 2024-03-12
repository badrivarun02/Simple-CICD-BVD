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
    }
    post{
        always{
            emailext (
                    subject: "Jenkins Build ${env.JOB_NAME} #${env.BUILD_NUMBER}",
                    body: """<p>See the attached build log for details.</p>""",
                    to: 'badrivarun09@gmail.com',
                    attachLog: true
                )
}
    }
     
       
       
}
    

        
        
