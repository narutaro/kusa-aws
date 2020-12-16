#!/bin/bash

if [ $# -lt 2 ]; then
  echo "Usage: $0 lambda_project_name code_file"
else
  zip lambda_function.zip $2 &&
  aws lambda update-function-code --function-name $1 --zip-file fileb://lambda_function.zip
fi


