node{

   //pipeline varibale definition
   //def tomcatIp = '172.31.20.233'
   //def tomcatUser = 'ec2-user'
   
   //echo env.BUILD_NUMBER
   //def BUILD_ID = env.BUILD_NUMBER
   
   def uploadSpec = """{
           "files": [
               {
               "pattern": "target/petclinic.war",
                   "target": "libs-snapshot-local/com/workout/BSP/1.1.${BUILD_NUMBER}-petclinic-SNAPSHOT/"
               }
               ]
    }"""

   
   try     { /* try start brace */
        
        // notifyBuild('STARTED')

        stage('Start')    {
    
        echo 'Hello-- Welcome to The Petclinic Demo'

    }
    
        stage('CheckOut From GIT')  {
        
        git 'https://topgear-training-gitlab.wipro.com/RA20080937/DevOpsProfessional_Batch17_CapstoneProject_OnlineAppointment_ThePetClinic.git'
        echo '*************CheckedOut from GIT Was Successful*************'
        
    }
    
        stage ("Maven - Package")  {
        
        def mvnHome = tool name: 'MAVEN_HOME', type: 'maven'
        
        //sh "${mvnHome}/bin/mvn test -Dtest=AppTest.java"
        sh "${mvnHome}/bin/mvn clean package"
	    
	    echo '*************Unit Test, Compile, Build & Package was Successful************'
	    
    }
    
        stage('Uploading to Artifactory') {
               withEnv( ["PATH+MAVEN=${tool MAVEN_HOME}/bin/"] ) {
                                 script {
                                        def server = Artifactory.server 'artifact' 
                                        server.bypassProxy = true
                                        def buildInfo = server.upload spec: uploadSpec
                                        echo '*************Uploaded artifacts to Artifactory was Successful*************'
                                        }
                    }
                
    }

    
    /*    stage('SonarQube Code Analysis')    {
            
        def mvnHome = tool name: 'MAVEN_HOME', type: 'maven'
        
        withSonarQubeEnv('scan')    {
            sh "${mvnHome}/bin/mvn sonar:sonar -Dsonar.projectName=WorkOutQuality${BUILD_NUMBER} -Dv=${BUILD_NUMBER}"
            
            echo '*************Sonar Code Quality Analysis was Successful************'
            
            jacoco()

            step([$class: 'JUnitResultArchiver', testResults: 'target/surefire-reports/*.xml'])
        
            echo '*************Jacoco Report was Generated************'

        
        }
        
    }
    
        stage("Quality Gate Check") {
            
            sleep(60)
            
            timeout(time: 1, unit: 'MINUTES') {
              def qg = waitForQualityGate()
              
              if (qg.status != 'OK') {
                  error "Pipeline aborted due to quality gate failure: ${qg.status}"
                  echo "QG Status: ${qg.status}"
                  echo '*************Quality Gate Check was Unsuccessful*************' 
            }
              
              else  {
                  
                  echo '*************Quality Gate Check was Successful*************'
            }
        }
    }
    */
        stage('Build Docker Imager'){
  
        //sh "docker run dockerglam/extra"
        //sh "docker container ls -a"
    
        sh "docker build -t dockerglam/capstone_petclinic:${BUILD_ID} ."
        sh "docker tag dockerglam/capstone_petclinic:${BUILD_ID} dockerglam/capstone_petclinic:latest"
        
        echo '*************Docker Image build was Successful************'
    
    }
    
    stage('Deploy to Dev Environment')  {
        
        try {
            //pre-requsites for deploying to dev environment
            //sh "docker pull dockerglam/capstone_petclinic:latest"
            
            sh "docker container stop mypetclinic"
            sh "docker container rm mypetclinic"
            
            echo '*************Removing previous container was Successful************'
            
        }
        catch(error)    {
            //do nothing if container not running
        }
        
        sh "docker run -d -p 9090:8080 --name mypetclinic dockerglam/capstone_petclinic:latest"
        
        echo '*************Petclinic container deployment was Successful :) ************'
        
        //sh "curl http://localhost:9090/petclinic"
        
    }
    
    /*
    try { //Dockerhub Versioning try start brace
    
        stage('Docker Hub Login')   {
        
        withCredentials([usernamePassword(credentialsId: 'ra20080937dockerglam', passwordVariable: 'dockerpass', usernameVariable: 'dockerlogin')]) {
            
    	sh "docker login -u ${dockerlogin} -p ${dockerpass}"
    	echo '*************Dockerhub login was Successful************'

        }
        
    }

        stage('Image Push to Docker Hub') {    
 
        //Push to Dockerhub
        sh "docker push dockerglam/capstone_petclinic:${BUILD_ID}"
        echo '*************Image Current Build Dockerhub Push was Successful************'
        
        sh "docker push dockerglam/capstone_petclinic:latest"
        echo '*************Image:latest Dockerhub Push was Successful************'
     
        //destroy local images
        //sh "docker rmi dockerglam/capstone_petclinic:latest"
        //sh "docker rmi dockerglam/capstone_petclinic:${BUILD_ID}"
        //echo '*************Local Image destroy was Successful************'
        
    }
    
    } //Dockerhub versioning try end brace
    
    catch(error)    {  //Dockerhub versioning catch start brace
        // To Prevent Jenkins Job failure in case in case Dockerhub is not connecting..
        echo '*************Dockerhub versioning was Unsuccessful due to Dockerhub connection failure************'
        
    }   //Dockerhub catch end brace
    
    */
    

        /*stage('Deploy to AWS Prod Environment')  {
    
        try {
            
        sshagent(['AWS-ec2-user']) {
        
        def dockerRun = 'docker run -d -p 9090:8080 --name mypetclinic dockerglam/capstone_petclinic:latest'
        sh "ssh -o StrictHostKeyChecking=no ec2-user@15.206.123.211 ${dockerRun}"
        //sh "ssh -o StrictHostKeyChecking=no ${tomcatUser}@${tomcatIp} ${dockerRmI}"
        
        echo '*************Deployment in AWS PROD was Successful************'
        }
        
        } //try brace
        
        catch(error){
		//  do nothing if there is an exception
	    }

    }*/


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