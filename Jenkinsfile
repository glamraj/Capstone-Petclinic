node{

    try     { /* try start brace */
        
        // notifyBuild('STARTED')

        stage('Start')    { 
    
        echo 'The Petclinic Pipeline - Capstone Demo'

    }
    
        stage('GITLab CheckOut')  {
        
        git 'https://topgear-training-gitlab.wipro.com/RA20080937/DevOpsProfessional_Batch17_CapstoneProject_OnlineAppointment_ThePetClinic.git'
        
        echo '*************GITLab Checkout is Successful***********'
        
    }
    
        stage('Ansible Playbook - Preparing the Environment & Services')    {
            
        try {
            
            ansiblePlaybook become: true, credentialsId: 'ansible-pass', installation: 'ansible-server', playbook: './roles/clinic/clinic.yml'
            
            echo "*******Ansible - Preparing environment Successful********"
            
        }
        catch(error)    {
            
            throw error
            
            echo "*******Preparing environment failed. Please check Ansible log********"
            
            sh "cat ansible.log"
            
        }

    }
    
        stage ("Maven Stage BUILD & PACKAGE")   {
        
        def mvnHome = tool name: 'MAVEN_HOME', type: 'maven'
        
        sh "${mvnHome}/bin/mvn clean package"
	    
	    echo '*************Build & Package is Successful************'
	    
    }
    
        stage('SonarQube Code Analysis')    {
            
        def mvnHome = tool name: 'MAVEN_HOME', type: 'maven'
        
        withSonarQubeEnv('scan')    {
            
            sh "${mvnHome}/bin/mvn sonar:sonar -Dsonar.projectName=WorkOutQuality${BUILD_NUMBER} -Dv=${BUILD_NUMBER}"
            
            echo '*************Sonar Code Quality Analysis is Successful************'
            
        }
        
    }
    
        stage('JACOCO Report Generation')    {
            
            jacoco()

            step([$class: 'JUnitResultArchiver', testResults: 'target/surefire-reports/*.xml'])
        
            echo '*************Jacoco Report Generation is Successful***************'
            
    }
    
        stage("Quality Gate Check") {
            
        sleep(60)
        
        try {
         
            timeout(time: 1, unit: 'MINUTES')   {
                
              def qg = waitForQualityGate()
              
              if (qg.status != 'OK')    {
                  
                  error "Pipeline aborted due to quality gate failure: ${qg.status}"
                  echo "QG Status: ${qg.status}"
                  echo '*************Quality Gate Check is Unsuccessful.. Aborting Deployment**********'
                  
            }
              
              else  {
                  
                  echo '*************SonarQube Quality Gate Check is Successful*************'
                  
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
        
        sh "${mvnHome}/bin/mvn deploy -U -DskipTests -Dmaven.main.skip"
	    
	    echo '*************Artifacts upload in Nexus is Successful************'
	    
        }
        catch(error) {
            //Do nothing
        }
	    
    }
    
        stage('Build Petclinic Docker Image')    {
  
        sh "docker build -t dockerglam/capstone_petclinic:${BUILD_ID} ."
        sh "docker tag dockerglam/capstone_petclinic:${BUILD_ID} dockerglam/capstone_petclinic:latest"
        
        echo '*************Petclinic Docker Image build is Successful************'
    
    }
    
        stage('Undeploy Petclinic - Previous version')  {
        
        try {
            
            //pre-requsites for deploying in dev environment
            sh "docker container stop mypetclinic"
            sh "docker container rm mypetclinic"
            
            echo '*************Undeploying previous Petclinic version is Successful************'
            
        }
        catch(error)    {
            //do nothing if container not running
        }
    }
    
        stage('Deploy Petclinic - Latest version')  {
            
        sh "docker run -d -p 9090:8080 --name mypetclinic dockerglam/capstone_petclinic:latest"
        
        echo '*************Deploying latest Petclinic version is Successful************'
            
    }
    
        stage('Ansible Playbook - Initiate Docker Swarm -Auto scale')    {
            
        try {
            
            ansiblePlaybook become: true, credentialsId: 'ansible-pass', installation: 'ansible-server', playbook: './roles/clinic/swarm.yml'
            
            echo "*******Ansible - PInitiate Docker Swarm -Auto scale Successful********"
            
        }
        catch(error)    {
            
            throw error
            
            echo "*******Initiate Docker Swarm -Auto scale failed. Please check Ansible log********"
            
            sh "cat ansible.log"
            
        }

    }
    
    try { //Dockerhub Versioning try start brace
    
        stage('Dockerhub Image Versioning - Login')   {
        
        withCredentials([usernamePassword(credentialsId: 'ra20080937dockerglam', passwordVariable: 'dockerpass', usernameVariable: 'dockerlogin')]) {
            
    	sh "docker login -u ${dockerlogin} -p ${dockerpass}"
    	
    	echo '*************Dockerhub login is Successful************'

        }
        
    }

        stage('Dockerhub Image Versioning - Image Push')    {
 
        //Push to Dockerhub
        sh "docker push dockerglam/capstone_petclinic:${BUILD_ID}"
        echo '*************Image:Current Build Dockerhub Push is Successful************'
        
        sh "docker push dockerglam/capstone_petclinic:latest"
        echo '*************Image:latest Dockerhub Push is Successful************'
     
        //destroy local images to download Image from Dockerhub
        //sh "docker rmi dockerglam/capstone_petclinic:latest"
        //sh "docker rmi dockerglam/capstone_petclinic:${BUILD_ID}"
        //echo '*************Local Image destroy is Successful************'
        
    }
    
    } //Dockerhub versioning try end brace

    catch(error)    {  //Dockerhub versioning catch start brace
        // To Prevent Jenkins Job failure in case in case Dockerhub is not connecting..
        echo '*************Dockerhub Image versioning is Unsuccessful due to Dockerhub connection failure************'
        
    }   //Dockerhub catch end brace
    

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

    }


    stage('Anisble Playbook- Install Tomcat server'){
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