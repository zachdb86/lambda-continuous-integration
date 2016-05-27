pip install awscli

echo "hello world"

zip -r LambdaTest.zip index.js

aws lambda update-function-code --function-name continuousIntegrationTest --zip-file fileb://LambdaTest.zip

# Publishing a new Version of the Lambda function
#version=`aws lambda publish-version --function-name LambdaTest | jq -r .Version`

# Updating the PROD Lambda Alias so it points to the new function
#aws lambda update-alias --function-name LambdaTest --function-version $version --name PROD

#aws lambda get-function --function-name “LambdaTest”

# Invoking Lambda function from update PROD alias
#aws lambda invoke --function-name LambdaTest --payload "$(cat data.json)" --qualifier PROD lambda_output.txt

#cat lambda_output.txt
