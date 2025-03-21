pipeline {
    agent any
    
    triggers {
        // Schedule to run at 6 AM EST (11 AM UTC)
        cron('0 11 * * *')
    }
    
    parameters {
        choice(name: 'ENVIRONMENT', choices: ['both', 'onPrem', 'cloud'], description: 'Select environment to run tests')
    }
    
    stages {
        stage('Checkout') {
            steps {
                // Checkout the master branch
                checkout scm
            }
        }
        
        stage('Setup') {
            steps {
                // Install dependencies
                sh 'npm install'
                sh 'npx playwright install'
            }
        }
        
        stage('Run Tests on onPrem Dev') {
            when {
                expression { return params.ENVIRONMENT == 'both' || params.ENVIRONMENT == 'onPrem' }
            }
            steps {
                // Run the onPrem dev tests
                sh 'npm run pretest-onPrem-dev'
                sh 'npm run test-onPrem-dev'
            }
            post {
                always {
                    // Archive test reports
                    archiveArtifacts artifacts: 'Reports/TestReports/**', allowEmptyArchive: true
                    
                    // Publish HTML reports
                    publishHTML(target: [
                        allowMissing: true,
                        alwaysLinkToLastBuild: true,
                        keepAll: true,
                        reportDir: 'Reports/TestReports',
                        reportFiles: 'index.html',
                        reportName: 'OnPrem Dev Test Report'
                    ])
                }
            }
        }
        
        stage('Run Tests on Cloud Dev') {
            when {
                expression { return params.ENVIRONMENT == 'both' || params.ENVIRONMENT == 'cloud' }
            }
            steps {
                // Run the cloud dev tests
                sh 'npm run pretest-cloud-dev'
                sh 'npm run test-cloud-dev'
            }
            post {
                always {
                    // Archive test reports
                    archiveArtifacts artifacts: 'Reports/TestReports/**', allowEmptyArchive: true
                    
                    // Publish HTML reports
                    publishHTML(target: [
                        allowMissing: true,
                        alwaysLinkToLastBuild: true,
                        keepAll: true,
                        reportDir: 'Reports/TestReports',
                        reportFiles: 'index.html',
                        reportName: 'Cloud Dev Test Report'
                    ])
                }
            }
        }
    }
    
    post {
        always {
            // Clean workspace after build
            cleanWs(cleanWhenNotBuilt: false,
                    deleteDirs: true,
                    disableDeferredWipeout: true,
                    patterns: [[pattern: 'Reports/TestReports/**', type: 'INCLUDE']])
        }
        success {
            // Send email notification on success
            emailext (
                subject: "KonfigAI Test Automation: SUCCESS",
                body: "KonfigAI automation tests completed successfully. See ${BUILD_URL} for details.",
                to: 'team@example.com',
                attachmentsPattern: 'Reports/TestReports/**/*.html'
            )
        }
        failure {
            // Send email notification on failure
            emailext (
                subject: "KonfigAI Test Automation: FAILURE",
                body: "KonfigAI automation tests failed. See ${BUILD_URL} for details.",
                to: 'team@example.com',
                attachmentsPattern: 'Reports/TestReports/**/*.html'
            )
        }
    }
}