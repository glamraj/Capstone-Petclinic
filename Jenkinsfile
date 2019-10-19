properties([pipelineTriggers([pollSCM('H/2 * * * *')])])

node{

   //pipeline varibale definition
   //def tomcatIp = '172.31.20.233'
   //def tomcatUser = 'ec2-user'
   
   //echo env.BUILD_NUMBER
   //def BUILD_ID = env.BUILD_NUMBER
    
    stage('Introduction'){
    
    echo 'Hello-- Welcome to The Petclinic Demo'
  }
    
    stage('SCM Checkout'){
    
    //script {
    //    properties([pipelineTriggers([pollSCM('H/2 * * * *')])])
    //}
    //git 'https://github.com/glamraj/Petclinic.git'
    //git 'https://topgear-training-gitlab.wipro.com/RA20080937/ILP_BookStoreWorkspace.git'
    git credentialsId: 'ra20080937wiprogitlab', url: 'https://topgear-training-gitlab.wipro.com/RA20080937/DevOpsProfessional_Batch17_CapstoneProject_OnlineAppointment_ThePetClinic.git'
  }
  
    stage('Maven Build'){ 
    
    //get Maven home path
    def mvnHome = tool name: 'MAVEN_HOME', type: 'maven'
    sh "${mvnHome}/bin/mvn clean package install"
  }
    
    stage('Anisble Playbook- Install Tomcat server'){
    sh label: '', script: 'cp tomcat-install.yml /opt/ansible/playbooks'
    
    step([$class: 'AnsiblePlaybookBuilder', additionalParameters: '', ansibleName: 'ansible-server', becomeUser: '', credentialsId: '', forks: 5, limit: '', playbook: '/opt/ansible/playbooks', skippedTags: '', startAtTask: '', sudoUser: '', tags: '', vaultCredentialsId: ''])
    
    //sshPublisher(publishers: [sshPublisherDesc(configName: 'ansible-server', transfers: [sshTransfer(cleanRemote: false, excludes: '', execCommand: 'ansible-playbook /opt/ansible/playbooks/tomcat-install.yml', execTimeout: 120000, flatten: false, makeEmptyDirs: false, noDefaultExcludes: false, patternSeparator: '[, ]+', remoteDirectory: '', remoteDirectorySDF: false, removePrefix: '', sourceFiles: '')], usePromotionTimestamp: false, useWorkspaceInPromotion: false, verbose: false)])
  }
  
}