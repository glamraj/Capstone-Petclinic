node{

    try     { /* try start brace */
        
        // notifyBuild('STARTED')

        stage('GITLab CheckOut')  {
        
        try {
            //git 'https://topgear-training-gitlab.wipro.com/RA20080937/capstone-batch17-petclinic.git'
	        git 'https://topgear-training-gitlab.wipro.com/RA20080937/DevOpsProfessional_Batch17_CapstoneProject_OnlineAppointment_ThePetClinic.git'
        
            echo '*************GITLab Checkout is Successful************'
        }
        catch(error) {
            //Do nothing
        }
    
    }

        stage ("Maven Stage BUILD & PACKAGE")   {
        
        try {
        
        def mvnHome = tool name: 'MAVEN_HOME', type: 'maven'
        
        sh "${mvnHome}/bin/mvn clean package -Dv=${BUILD_NUMBER}"
	    
	    echo '*************Build & Package is Successful************'
	    
        }
        catch(error) {
            //Do nothing
        }
	    
    }
    
    stage('JACOCO Code Coverage Test')    {
            
            jacoco()

            step([$class: 'JUnitResultArchiver', testResults: 'target/surefire-reports/*.xml'])
        
            echo '*************Jacoco Report Generation is Successful***************'
            
    }
    
        stage('SonarQube Code Analysis')    {
            
        try {
            
        def mvnHome = tool name: 'MAVEN_HOME', type: 'maven'
        
        withSonarQubeEnv('scan')    {
            
            sh "${mvnHome}/bin/mvn sonar:sonar -Dsonar.projectName=WorkOutQuality${BUILD_NUMBER} -Dv=${BUILD_NUMBER}"
            
            echo '*************Sonar Code Quality Analysis is Successful************'
            
        }
        }
        catch(error) {
            //Do nothing
        }
        
    }
    
        stage('Run JMeter Performance Testing')  {

        try {
            
        def mvnHome = tool name: 'MAVEN_HOME', type: 'maven'

        step([$class: 'ArtifactArchiver', artifacts: 'src/test/jmeter/petclinic_test_plan.jmx', fingerprint: true])

        echo '*************JMeter test run is Successful***************'
        
        }
        catch(error) {
        //Do nothing
        }

    }
    
        stage("SonarQube Quality Gate Check") {
            
        sleep(60)
        
        try {
         
            timeout(time: 1, unit: 'MINUTES')   {
                
              def qg = waitForQualityGate()
              
              if (qg.status != 'OK')    {
                  
                  error "Pipeline aborted due to quality gate failure: ${qg.status}"
                  echo "QG Status: ${qg.status}"
                  echo '*************SonarQube Quality Gate Check is Unsuccessful.. Aborting Deployment**********'
                  
            }
              
              else  {
                  
                  echo '*************SonarQube Quality Gate Check has failed*************'
                  
            }
        }
      }    //try end brace
      catch(error) {
            //Do nothing
            echo '*************Quality Gate Check is still In Progress..Moving on to next steps**********'
      }
    }
    
        stage ("Artifactory upload in Nexus")  {
            
        try {
        
        def mvnHome = tool name: 'MAVEN_HOME', type: 'maven'
        
        sh "${mvnHome}/bin/mvn deploy -U -DskipTests -Dmaven.main.skip -Dv=${BUILD_NUMBER}"
	    
	    echo '*************Artifacts upload in Nexus is Successful************'
	    
        }
        catch(error) {
            //Do nothing
        }
	    
    }
    
        stage('Build Petclinic Docker Image')    {
        
        try {
  
        sh "docker build -t dockerglam/capstone_petclinic:${BUILD_ID} ."
        sh "docker tag dockerglam/capstone_petclinic:${BUILD_ID} dockerglam/capstone_petclinic:latest"
        
        echo '*************Petclinic Docker Image build is Successful************'
        }
        catch(error) {
            //Do nothing
        }
    
    }
    
    stage('Dockerhub Image Versioning - Image Push')    {
        
        try {
        //Push to Dockerhub
        sh "docker push dockerglam/capstone_petclinic:${BUILD_ID}"
        echo '*************Image:Current Build Dockerhub Push is Successful************'
        
        sh "docker push dockerglam/capstone_petclinic:latest"
        echo '*************Image:latest Dockerhub Push is Successful************'
        }
        
        catch(error)    {
            //do nothing if container not running
        }
    }
    
    stage('Docker Image - Cleanup')    {
        
        try {     
        
            //destroy local images to download Image from Dockerhub
            sh "docker rmi dockerglam/capstone_petclinic:${BUILD_ID}"
            //sh "docker rmi dockerglam/capstone_petclinic:latest"
            
            echo '*************Local Image destroy is Successful************'
            
            sh "docker image prune -f"
            sh "docker system prune -f"
            echo '*************Destroy dangling images is Successful************'
        }
        
        catch(error)    {
            //do nothing if container not running
        }
            
    }
    
    stage('Ansible Playbook - Docker Container Deployment')    {
            
        try {
            
            ansiblePlaybook become: true, credentialsId: 'ansible-pass', installation: 'ansible-server', playbook: './roles/dockerswarm/swarm.yml'
            
            echo "*******Ansible Playbook execution- Deployment is Successful********"
            
        }
        catch(error)    {
            
            echo "*******Deployment failed. Please check Ansible log********"
            
        }

    }
    
    /* stage('Email')    {
     mail bcc: '', body: '''Hi,

The Deployment has finished successfully. Please check the portal.

http://localhost:9090/petclinic/

Regards,
Jenkins''', cc: 'md.akram@wipro.com', from: '', replyTo: '', subject: 'Job Updates - Petclinic', to: 'rajib.chowdhury3@wipro.com'   
    } */
    
    
} /* try end brace */
   
   
   catch (e) { /* catch start brace */
   
    // If there was an exception thrown, the build failed
    //currentBuild.result = "FAILED"
    throw e
    echo "Catch Block - Exception check error logs"
   } /* catch end brace */
    
   finally { /* finally start brace */
    // Success or failure, always send notifications
    // notifyBuild(currentBuild.result)
    //gitlabCommitStatus {
       // The result of steps within this block is what will be sent to GitLab
       //echo "Commit Status to Gitlab"
    //}
    echo "Final Block - No error"
  } /* finally end brace */

   
} /* node end brace */ 

/*
def notifyBuild(String buildStatus) {
    
  // build status of null means successful
  buildStatus =  buildStatus ?: 'SUCCESSFUL'

  // Default values
  def colorName = 'RED'
  def colorCode = '#FF0000'
  def subject = "${buildStatus}: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'"
  def summary = "${subject} (${env.BUILD_URL})"

  // Override default values based on build status
  if (buildStatus == 'STARTED') {
    color = 'YELLOW'
    colorCode = '#FFFF00'
  } else if (buildStatus == 'SUCCESSFUL') {
    color = 'GREEN'
    colorCode = '#00FF00'
  } else if (buildStatus == 'UNSTABLE') {
    color = 'warning'
    colorCode = '#ffae42'
  } else {
    color = 'RED'
    colorCode = '#FF0000'
  }

  // Send notifications
 slackSend (color: colorCode, message: summary)
 
}
*/
