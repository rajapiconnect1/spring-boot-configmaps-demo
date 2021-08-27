pipeline {
    agent any
    
    parameters {
        string(name: 'PROJECT', defaultValue: 'https://github.com/rajapiconnect1/spring-boot-configmaps-demo.git', description: 'Enter Project anme ')
               
        string(name: 'SERVICE_NAME', defaultValue: 'springboot-configmaps-demo', description: 'Enter Project anme ')

        }
    stages {
        stage('Checkout') {
            steps {
               

                echo "Hello ${params.PROJECT} "
                checkout([$class: 'GitSCM', branches: [[name: '*/master']], userRemoteConfigs: [[url: "${params.GIT_URL}"]]])
            
            }
        }    
        stage('Build') { 
            steps {
                  
                echo 'Hello World!!!'
                sh 'mvn clean package' 
            
            }
        }

        stage('Dockerize') { 
            steps {
               
                    echo 'Dockerizing application'
                    
                    sh 'docker logout'
                    sh 'docker login -u rajapiconnect1 -p "Rajesh@3200" docker.io'
                    sh "docker build -t rajapiconnect1/${params.SERVICE_NAME} ."
                    sh "docker tag rajapiconnect1/${params.SERVICE_NAME} rajapiconnect1/${params.SERVICE_NAME}"
                    sh "docker push rajapiconnect1/${params.SERVICE_NAME}"
                
                    sh "oc create -f ${env.WORKSPACE}/deployment.yaml"

                   
                    sh "oc create -f ${env.WORKSPACE}/service.yaml"

                   
                    sh "oc expose service/${params.SERVICE_NAME}"

                    

                    sh "oc get routes"
               
                
            }   
                
               
        }
    }
}

