project_dir=$(pwd)
current_dir=$project_dir/deploy/Development

ecr=001043692857.dkr.ecr.eu-central-1.amazonaws.com
dockerImage=$ecr/pm-demo:latest

taskDefinitionFile=$current_dir/TaskDefinition.json
createServiceDefinitionFile=$current_dir/CreateServiceDefinition.json

replace=$project_dir/deploy/Replace.py

#Build
go build --trimpath --mod=vendor --buildmode=plugin -o ./build/backend.so

#ECR
aws ecr get-login-password --region eu-central-1 | docker login --username AWS --password-stdin $ecr && \
docker image build --network=host -t $dockerImage -f $current_dir/Dockerfile $current_dir && \
docker push $dockerImage && \

# Register Task Definition Processes  
python3 $replace $taskDefinitionFile "#IMAGE#" $dockerImage && \
taskDefinitionArn=$(echo "$(aws ecs register-task-definition --output json --cli-input-json file://$taskDefinitionFile)" | jq -r '.taskDefinition.taskDefinitionArn') && \
python3 $replace $taskDefinitionFile $dockerImage "#IMAGE#" && \

 # Create Service Processes
 #python3 $replace $createServiceDefinitionFile "#TASKDEFINITION#" $taskDefinitionArn && \
 #aws ecs create-service --cli-input-json file://$createServiceDefinitionFile > /dev/null && \
 #python3 $replace $createServiceDefinitionFile $taskDefinitionArn "#TASKDEFINITION#" && \

#Update
aws ecs update-service --cluster PM-Cluster --service PM-Platform --task-definition $taskDefinitionArn --force-new-deployment > /dev/null && \
echo "Updated ==> $taskDefinitionArn"

