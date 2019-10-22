node{

   //pipeline varibale definition
   //def tomcatIp = '172.31.20.233'
   //def tomcatUser = 'ec2-user'
   
   //echo env.BUILD_NUMBER
   //def BUILD_ID = env.BUILD_NUMBER
   
   try     { /* try start brace */
        
        // notifyBuild('STARTED')
        
        
        stage('Introduction')    {
    
        echo 'Hello-- Welcome to The Petclinic Demo'

    }
    
        stage('CheckOut From GIT')  {
        
        git 'https://topgear-training-gitlab.wipro.com/RA20080937/DevOpsProfessional_Batch17_CapstoneProject_OnlineAppointment_ThePetClinic.git'
        echo '*************CheckedOut from GIT Successfully*************'
        
    }
    
        stage ("Maven Compile & Unit Testing")  {
        
        def mvnHome = tool name: 'MAVEN_HOME', type: 'maven'
        
        //sh "${mvnHome}/bin/mvn test -Dtest=AppTest.java"
        sh "${mvnHome}/bin/mvn clean test compile"
	    
	    echo '*************Unit Test was Successful************'
	    
    }
    
    /*    stage('SonarQube PreBuild Analysis')    {
            
        def mvnHome = tool name: 'MAVEN_HOME', type: 'maven'
        
        withSonarQubeEnv('scan')    {
            sh "${mvnHome}/bin/mvn sonar:sonar -Dsonar.projectName=WorkOutQuality${BUILD_NUMBER} -Dv=${BUILD_NUMBER}"
            echo '*************Prebuild Analysis was Successful************'
        
        }
        
    }
    
        stage("Quality Gate Check") {
            timeout(time: 1, unit: 'HOURS') {
              def qg = waitForQualityGate()
              if (qg.status != 'Passed') {
                  error "Pipeline aborted due to quality gate failure: ${qg.status}"
                  echo '*************Quality Gate Check was Successful*************' 
              }
          }
      }*/

     
     
        stage('Maven Package')    {
    
        //get Maven home path
        def mvnHome = tool name: 'MAVEN_HOME', type: 'maven'
        sh "${mvnHome}/bin/mvn package"
        echo '*************Package build was Successful************'
        
    }
    
    
        stage('Build Docker Imager'){
  
        //sh "docker run dockerglam/extra"
        //sh "docker container ls -a"
    
        sh "docker build -t dockerglam/capstone_petclinic:${BUILD_ID} ."
        sh "docker tag dockerglam/capstone_petclinic:${BUILD_ID} dockerglam/capstone_petclinic:latest"
        
        echo '*************Docker Image build was Successful************'
    
    }


        stage('Push to Docker Hub') {    
 
        withCredentials([usernamePassword(credentialsId: 'ra20080937dockerglam', passwordVariable: 'dockerpass', usernameVariable: 'dockerlogin')])
        {
    	/*sh "docker login -u ${dockerlogin} -p ${dockerpass}"
    	echo '*************Dockerhub login was Successful************'
    	
    	//Push to Dockerhub
        sh "docker push dockerglam/capstone_petclinic:${BUILD_ID}"
        sh "docker push dockerglam/capstone_petclinic:latest"
        echo '*************Dockerhub Image Push was Successful************'
        
    	}
        
        //destroy local images
        sh "docker rmi dockerglam/capstone_petclinic:${BUILD_ID}"
        sh "docker rmi dockerglam/capstone_petclinic:latest"
        echo '*************Local Image destroy was Successful************' */
    }
    
        stage('Deploy to Dev Environment')  {
    
        sh "docker run -d -p 9000:8080 --name myclinic dockerglam/capstone_petclinic:latest"
        
    }


/*    stage('Anisble Playbook- Install Tomcat server'){
    sh label: '', script: 'cp tomcat-install.yml /opt/ansible/playbooks'
    
    step([$class: 'AnsiblePlaybookBuilder', additionalParameters: '', ansibleName: 'ansible-server', becomeUser: '', credentialsId: '', forks: 5, limit: '', playbook: '/opt/ansible/playbooks/tomcat-install.yml', skippedTags: '', startAtTask: '', sudoUser: '', tags: '', vaultCredentialsId: ''])
    
    //sshPublisher(publishers: [sshPublisherDesc(configName: 'ansible-server', transfers: [sshTransfer(cleanRemote: false, excludes: '', execCommand: 'ansible-playbook /opt/ansible/playbooks/tomcat-install.yml', execTimeout: 120000, flatten: false, makeEmptyDirs: false, noDefaultExcludes: false, patternSeparator: '[, ]+', remoteDirectory: '', remoteDirectorySDF: false, removePrefix: '', sourceFiles: '')], usePromotionTimestamp: false, useWorkspaceInPromotion: false, verbose: false)])
  }
 */
 
   } /* try end brace */
   
   
   catch (e) { /* catch start brace */
   
    // If there was an exception thrown, the build failed
    //currentBuild.result = "FAILED"
    throw e
    echo "Catch Block"
   } /* catch end brace */
    
   finally { /* finally start brace */
    // Success or failure, always send notifications
    // notifyBuild(currentBuild.result)
    //gitlabCommitStatus {
       // The result of steps within this block is what will be sent to GitLab
       //echo "Commit Status to Gitlab"
    //}
    echo "Finally Block"
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