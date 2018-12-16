#!/bin/bash

baseUrl='https://api.github.com/repos/fleboulch/fast-msg-heroku'

# env -i is a workaround (see: https://github.com/typicode/husky/issues/364)
currentBranchName=$(env -i git rev-parse --abbrev-ref HEAD)
prUrl="$baseUrl/pulls?state=opened&head=fleboulch:$currentBranchName"
prExisting=$(curl -s $prUrl | jq length)

if [[ $prExisting -eq 0 ]]; then

    file='../app.json'
    issuesUrl="$baseUrl/issues?state=all"
    nbIssues=$(curl -s $issuesUrl | jq length)
    newPrNb=$(($nbIssues+1))
    pattern="s/pr-\([0-9]*\)/pr-$newPrNb/"

    echo "PR has not been created"
    echo "There is $nbIssues issues"
    echo "New PR will be #$newPrNb"

    sed -i -e $pattern $file
    git add $file
    git commit --amend --no-edit
else
    echo "PR has already been created"
fi
