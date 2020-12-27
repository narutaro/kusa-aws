aws cognito-idp admin-initiate-auth \
  --user-pool-id ${AWS_USER_POOL_ID} \
  --client-id ${AWS_CLIENT_ID} \
  --auth-flow ADMIN_NO_SRP_AUTH \
  --auth-parameters "USERNAME=${AWS_USER_EMAIL},PASSWORD=${AWS_PASSWORD}"
