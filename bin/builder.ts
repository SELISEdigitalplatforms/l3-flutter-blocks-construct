const PROD = [
  "LOGIN=${BLOCK_ORIGIN_URL}/authentication/v1/oauth/token",
  "LOGOUT=${BLOCK_ORIGIN_URL}/authentication/v1/Authentication/Logout",
  "RECOVER=${BLOCK_ORIGIN_URL}/iam/v1/Account/Recover",
  "RESET_PASSWORD=${BLOCK_ORIGIN_URL}/iam/v1/Account/ResetPassword",
  "PROFILE_URL=${BLOCK_ORIGIN_URL}/iam/v1/User/GetAccount",
  "CHANGE_PASSWORD=${BLOCK_ORIGIN_URL}/iam/v1/Account/ChangePassword",
  "UPDATE_PROFILE=${BLOCK_ORIGIN_URL}/iam/v1/user/UpdateAccount",
];

const STAGE = [
  "LOGIN=${BLOCK_ORIGIN_URL}/authentication/v1/oauth/token",
  "LOGOUT=${BLOCK_ORIGIN_URL}/authentication/v1/Authentication/Logout",
  "RECOVER=${BLOCK_ORIGIN_URL}/iam/v1/Account/Recover",
  "RESET_PASSWORD=${BLOCK_ORIGIN_URL}/iam/v1/Account/ResetPassword",
  "PROFILE_URL=${BLOCK_ORIGIN_URL}/iam/v1/User/GetAccount",
  "CHANGE_PASSWORD=${BLOCK_ORIGIN_URL}/iam/v1/Account/ChangePassword",
  "UPDATE_PROFILE=${BLOCK_ORIGIN_URL}/iam/v1/user/UpdateAccount",
];

function env(env, blockOriginUrl) {
  switch (env) {
    case "stage":
      STAGE.forEach((value, index) => {
        STAGE[index] = value.replace("${BLOCK_ORIGIN_URL}", blockOriginUrl);
      });
      return STAGE;
    case "prod":
      PROD.forEach((value, index) => {
        PROD[index] = value.replace("${BLOCK_ORIGIN_URL}", blockOriginUrl);
      });
      return PROD;
    default:
      return STAGE;
  }
}

export default function builder(functionName: string, ...args): any {
  switch (functionName) {
    case "env":
      return env(args[0], args[1]);
    default:
      console.log("Function not found in builder");
      throw new Error("Function not found in builder");
  }
}
