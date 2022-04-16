pipeline {
    agent any
    environment {
        BRANCHNG="${params.BranchRunNginx}"
        TAGNG="${params.ImageTagNginx}" 
        BRANCHND="${params.BranchRunNode}"
        TAGND="${params.ImageTagNode}" 
        BRANCH_DEV="${params.BranchRun_dev}"
        TAG_DEV="${params.ImageTag_dev}" 
    }    
    
    libraries {
         lib('lib-for-project')
    }    
    
    stages {       


        stage('Deploy on k8s') {

            steps {
                script {
                    if ("${BRANCH_DEV}" == 'develop') {
                        DeployHelm ("${BRANCH_DEV}", "${TAG_DEV}", "${BRANCH_DEV}", "${TAG_DEV}")
                    } else {
                        DeployHelm ("${BRANCHNG}", "${TAGNG}", "${BRANCHND}", "${TAGND}")
                    }                                             
                }                                                       
            }
        } 
    }
}