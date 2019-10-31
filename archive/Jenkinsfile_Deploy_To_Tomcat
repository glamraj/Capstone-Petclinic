properties([pipelineTriggers([pollSCM('')])])

node{
    
   //pipeline varibale definition
   def tomcatIp = '172.31.20.233'
   def tomcatUser = 'ec2-user'
   def stopTomcat = "ssh ${tomcatUser}@${tomcatIp} /opt/tomcat/bin/shutdown.sh"
   def startTomcat = "ssh ${tomcatUser}@${tomcatIp} /opt/tomcat/bin/startup.sh"
   def copyWar = "scp -o StrictHostKeyChecking=no target/petclinic.war ${tomcatUser}@${tomcatIp}:/opt/tomcat/webapps/petclinic.war"
    
    stage('Introduction'){
        
    echo 'Hello-- Welcome to Pipeline Demo'
  }
    
    stage('SCM Checkout'){
        
    git 'https://github.com/glamraj/Petclinic.git'
  }

    stage('Maven Build'){ 
    
    //get Maven home path
    def mvnHome = tool name: 'M2', type: 'maven'
    sh "${mvnHome}/bin/mvn clean package"
  }
    
    stage('Deploy to Tomcat'){
        
        sshagent(['Linux-Server']) {
        sh "${stopTomcat}"
        sh 'ssh ec2-user@172.31.20.233 rm -rf /opt/tomcat/webapps/petclinic*'
        sh "${copyWar}"
        sh "${startTomcat}"
    }
  }
    
    stage('Finish'){
    echo 'Hello-- Success.. Deployed'
  }   
}
