pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
               checkout([$class: 'GitSCM', branches: [[name: '*/main']],
    userRemoteConfigs: [[url: 'https://github.com/rajapiconnect1/spring-boot-configmaps-demo.git']]])
	
            }
        }    
        stage('Build') { 
            steps {
                echo 'Buildig application'
                sh 'mvn clean package' 
            }
        }

        stage('Dockerize') { 
            steps {
                echo 'Dockerizing application'
                sh 'docker build -t rajapiconnect1/spring-boot-configmaps-demo  .'
                sh 'docker logout'
                sh 'docker login -u rajapiconnect1 -p "Rajesh@3200" docker.io'
                sh 'docker tag rajapiconnect1/spring-boot-configmaps-demo rajapiconnect1/spring-boot-configmaps-demo'
                sh 'docker push rajapiconnect1/spring-boot-configmaps-demo'
            }
        }

         stage('Deploy') { 
            steps {
                echo 'Deploying application into OCP'
                sh 'oc login --token=sha256~JPpy-cbpiiooFf-XYGFKhd7VctLwi8oqoWNORHzFZUE --server=https://api.sandbox.x8i5.p1.openshiftapps.com:6443'
                
                sh '''
                    status=$?
                    cmd="oc delete deployment spring-boot-configmaps-demo"
                    if [ $cmd -eq 0 ]
                    then
                        echo "Success: Deployment Deleted"
                    else
                        echo "Failure: Deployment is not found "
                    fi

                    cmd="oc delete service spring-boot-configmaps-demo"
                    if [ $cmd -eq 0 ]
                    then
                        echo "Success: Service Deleted"
                    else
                        echo "Failure: Service is not found "
                    fi
                    
                    
                '''
                
                
                sh '''
                   cmd = 'oc create -f spring-boot-configmaps-demo.yaml' 

                    if [ $cmd -eq 0 ]
                    then
                        echo "Success: application deployed"
                    else
                        echo "Failure: Error in deploying application "
                    fi

                    cmd = 'oc create -f spring-boot-configmaps-service.yaml' 

                    if [ $cmd -eq 0 ]
                    then
                        echo "Success: service created"
                    else
                        echo "Failure: Error in creating service "
                    fi

                    cmd = 'oc expose service/springboot-configmaps-demo' 

                    if [ $cmd -eq 0 ]
                    then
                        echo "Success: service created"
                    else
                        echo "Failure: Error in creating service "
                    fi

                '''
                timeout(time: 1, unit: 'MINUTES') {
                    
                }
            }
        }

    }
}

