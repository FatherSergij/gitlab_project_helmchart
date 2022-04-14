pipeline {
    agent any
    environment {
        IP_K8S="16.170.42.2"
        BRANCHNG="${params.BranchRun_ng}"
        TAGNG="${params.ImageTag_ng}" 
        BRANCHND="${params.BranchRun_nd}"
        TAGND="${params.ImageTag_nd}" 
    }    
    
    libraries {
         lib('lib-for-project')
    }    
    
    stages {       

        stage('Deploy on k8s with Helm Chart') {

            steps {
                sh "scp -o StrictHostKeyChecking=no -r helm/ ubuntu@${IP_K8S}:~/"
                script {
                sh("ssh ubuntu@${IP_K8S} \
                    pwd; \
                    cd helm/; \
                    sed 's/%BRNG%/${BRANCHNG}/; s/%TAGNG%/${TAGNG}/; \
                        s/%BRND%/${BRANCHND}/; s/%TAGND%/${TAGND}/' values_tmp.yaml > values.yaml;")
                  //  helm install test .;")
                }                                                     
            }
        } 
    }
}