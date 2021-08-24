pipeline {
    agent any
    parameters {
        string(name: 'PROJECT', defaultValue: 'https://github.com/rajapiconnect1/spring-boot-configmaps-demo.git', description: 'Enter Project anme ')
        string(name: 'SERVICE_NAME', defaultValue: 'defaultService', description: 'Enter Project anme ')

        }
    stages {
        stage('Checkout') {
            steps {

                 echo "Hello ${params.PROJECT}"


               checkout([$class: 'GitSCM', branches: [[name: '*/main']], userRemoteConfigs: [[url: 'https://github.com/rajapiconnect1/dynacachetest.git']]])
	
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
                sh 'docker build -t rajapiconnect1/rajdynacachetest .'
                sh 'docker logout'
                sh 'docker login -u rajapiconnect1 -p "Rajesh@3200" docker.io'
                sh 'docker tag rajapiconnect1/rajdynacachetest rajapiconnect1/rajdynacachetest'
                sh 'docker push rajapiconnect1/rajdynacachetest'
            }
        }

         stage('Deploy') { 
            steps {
                echo 'Deploying application into OCP'
                sh "oc login --token=${params.OCTOKEN} --server=https://api.sandbox.x8i5.p1.openshiftapps.com:6443"
                
                sh '''
                    status=$?
                    cmd="oc delete deployment rajdynacachetest"
                    if [ $cmd -eq 0 ]
                    then
                        echo "Success: Deployment Deleted"
                    else
                        echo "Failure: Deployment is not found "
                    fi

                    cmd="oc delete service rajdynacachetest"
                    if [ $cmd -eq 0 ]
                    then
                        echo "Success: Service Deleted"
                    else
                        echo "Failure: Service is not found "
                    fi
                    
                    
                '''
                
                
                sh 'oc create -f deployment.yaml' 

                timeout(time: 1, unit: 'MINUTES') {
                    
                }

                sh 'oc create -f service.yaml' 

                timeout(time: 1, unit: 'MINUTES') {
                    
                }

                sh "oc expose service/${params.SERVICE_NAME}"

                timeout(time: 1, unit: 'MINUTES') {
                    
                }
            }
        }

    }
}

