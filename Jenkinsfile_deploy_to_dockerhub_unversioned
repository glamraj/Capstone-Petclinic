properties([pipelineTriggers([pollSCM('')])])

node{
    
   //pipeline varibale definition
   def tomcatIp = '172.31.20.233'
   def tomcatUser = 'ec2-user'
    
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
    
    stage('Build Docker Imager'){
  
    sh 'docker build -t dockerglam/petclinic:1.0 .'
 }
    
    stage('Push to Docker Hub'){
 
    withCredentials([string(credentialsId: 'DockerPwd', variable: 'DockerHubPwd')]) {
    sh "docker login -u dockerglam -p ${DockerHubPwd}"
    }
    sh 'docker push dockerglam/petclinic:1.0'
 }
    
    stage('Remove Previous Container'){
	try{
		def dockerRm = 'docker rm -f myclinic'
                def dockerRmI = 'docker rmi docker.io/dockerglam/petclinic:1.0'
		sshagent(['Linux-Server']) {
			sh "ssh -o StrictHostKeyChecking=no ${tomcatUser}@${tomcatIp} ${dockerRm}"
                        sh "ssh -o StrictHostKeyChecking=no ${tomcatUser}@${tomcatIp} ${dockerRmI}"
		}
	}catch(error){
		//  do nothing if there is an exception
	}
 }
    
        
    stage('Deploy to Dev Environment'){
    
    def dockerRun = 'docker run -d -p 9000:8080 --name myclinic dockerglam/petclinic:1.0'      
    sshagent(['Linux-Server']) {
    sh "ssh -o StrictHostKeyChecking=no ${tomcatUser}@${tomcatIp} ${dockerRun}"
    }
 }
    
}
