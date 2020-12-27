aws cognito-idp confirm-sign-up \
  --client-id ${AWS_CLIENT_ID} \
  --username ${AWS_USER_EMAIL} \
  --confirmation-code ${AWS_CONFIRMATION_CODE}
