#!/bin/bash

echo "Wait please"
aws ecr get-login-password --region eu-north-1 | docker login --username AWS --password-stdin 728490037630.dkr.ecr.eu-north-1.amazonaws.com &>/dev/null

function arr {
  array=("$@")
  for i in ${!array[@]}; do
    echo "$(($i+1)): ${array[$i]}"
  done
  echo ""
  int='^[0-9]+$'
  while read tag
  do
    if [[ ${#tag} -eq 0 ]] #i if you press enter, it does not give a system error on the next if
    then
      echo "Input correct number please"   
      continue
    fi 
    if [ $tag = "q" ]
    then
      echo -e "\nFile commit.yml not created"
      exit
    fi
    if ! [[ $tag =~ $int ]] #if you input tag as string - not give a system error on the next if
    then 
      echo "Input correct number please"
    elif [ $tag -gt 0 ] && [ $tag -le ${#array[*]} ]
    then
      #echo $tag
      break
    else  
      echo "Input correct number please"  
    fi
  done  
}

array1=( $(aws ecr describe-images --region eu-north-1 --repository-name bigproject_nginx_release --query "reverse(sort_by(imageDetails,& imagePushedAt))[ * ].imageTags[ * ]" --output text) )
array2=( $(aws ecr describe-images --region eu-north-1 --repository-name bigproject_node_release --query "reverse(sort_by(imageDetails,& imagePushedAt))[ * ].imageTags[ * ]" --output text) )
array3=( $(aws ecr describe-images --region eu-north-1 --repository-name bigproject_nginx_master --query "reverse(sort_by(imageDetails,& imagePushedAt))[ * ].imageTags[ * ]" --output text) )
array4=( $(aws ecr describe-images --region eu-north-1 --repository-name bigproject_node_master --query "reverse(sort_by(imageDetails,& imagePushedAt))[ * ].imageTags[ * ]" --output text) )
echo -e "\nChange nubmer commit for branche RELEASE, service NGINX(q - exit):"
arr "${array1[@]}"
tag1=$tag

echo -e "\nChange nubmer commit for branche RELEASE, service NODE(q - exit):"
#array2=( $(aws ecr describe-images --region eu-north-1 --repository-name bigproject_node_release --query "reverse(sort_by(imageDetails,& imagePushedAt))[ * ].imageTags[ * ]" --output text) )
arr "${array2[@]}"
tag2=$tag

echo -e "\nChange nubmer commit for branche MASTER, service NGINX(q - exit):"
#array3=( $(aws ecr describe-images --region eu-north-1 --repository-name bigproject_nginx_master --query "reverse(sort_by(imageDetails,& imagePushedAt))[ * ].imageTags[ * ]" --output text) )
arr "${array3[@]}"
tag3=$tag

echo -e "\nChange nubmer commit for branche MASTER, service NODE(q - exit):"
#array4=( $(aws ecr describe-images --region eu-north-1 --repository-name bigproject_node_master --query "reverse(sort_by(imageDetails,& imagePushedAt))[ * ].imageTags[ * ]" --output text) )
arr "${array4[@]}"
tag4=$tag

sed "s/%NGSTAGE%/${array1[$tag1-1]}/; s/%NDSTAGE%/${array2[$tag2-1]}/; s/%NGPROD%/${array3[$tag3-1]}/; s/%NDPROD%/${array4[$tag4-1]}/" commit-tmp.yml > commit.yml
echo -e "\nFile commit.yml created"
