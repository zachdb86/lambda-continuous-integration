pip install awscli

echo "hello world"

# Preparing and deploying Function to Lambda
zip -r LambdaTest.zip index.js
aws lambda update-function-code --function-name continuousIntegrationTest --zip-file fileb://LambdaTest.zip

# Publishing a new Version of the Lambda function
version=`aws lambda publish-version --function-name continuousIntegrationTest | jq -r .Version`

# Updating the PROD Lambda Alias so it points to the new function
aws lambda update-alias --function-name continuousIntegrationTest --function-version $version --name PROD

aws lambda get-function --function-name “continuousIntegrationTest”

# Invoking Lambda function from update PROD alias
aws lambda invoke --function-name continuousIntegrationTest --payload "$(cat data.json)" --qualifier PROD lambda_output.txt

cat lambda_output.txt
