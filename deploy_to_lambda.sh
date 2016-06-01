pip install awscli

function=continuousIntegrationTest

# Preparing and deploying Function to Lambda
zip -r LambdaTest.zip index.js
aws lambda update-function-code --function-name $function --zip-file fileb://LambdaTest.zip

# Publishing a new Version of the Lambda function
version=`aws lambda publish-version --function-name $function | jq -r .Version`

# Updating the PROD Lambda Alias so it points to the new function
aws lambda update-alias --function-name $function --function-version $version --name PROD

aws lambda get-function --function-name $function

# Invoking Lambda function from update PROD alias
aws lambda invoke --function-name $function --payload "$(cat data.json)" --qualifier PROD lambda_output.txt

cat lambda_output.txt

# Removeing old versions of the Lambda function
versions=(`aws lambda list-versions-by-function --function-name $function | jq -r .Versions[].Version`)

for v in "${versions[@]}"; do
  if [ $v != "\$LATEST" ]; then
    echo $v
    # aws lambda delete-function --function-name $function --qualifier $v
  fi
done
