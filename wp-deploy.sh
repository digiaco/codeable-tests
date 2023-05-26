#!/bin/bash
ssh_="ubuntu@157.90.161.252"
key_path="~/.ssh/deploy"
git_=$(git config --get remote.origin.url)
rname=$(basename `git rev-parse --show-toplevel`)

echo $git_
echo $rname
#echo "REPOSITORY_PATH=${rname}\n" >> ".env"


ssh -i ${key_path} -o IdentitiesOnly=yes ${ssh_} "git -c 'core.sshCommand=ssh -i ~/.ssh/git' clone ${git_}"

# mkdir temp
# cd temp
# git clone ${git_}
# scp -r -i --exclude 'temp/.git' ${key_path} ../temp ${ssh_}:~/${rname} 
# cd ../
# rm -rf temp

scp -i ${key_path} .env ${ssh_}:~/${rname}/.env
ssh -i ${key_path} ${ssh_} "export RNAME=${rname}; bash ${rname}/bin/deploy-wp.sh"
