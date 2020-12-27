aws cognito-idp sign-up \
  --client-id ${AWS_CLIENT_ID} \
  --username ${AWS_USER_EMAIL} \
  --password ${AWS_PASSWORD} \
  --user-attribute "Name=email,Value=${AWS_USER_EMAIL}"
