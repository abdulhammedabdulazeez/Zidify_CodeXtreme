export const AUTH_MESSAGES = {
  INVALID_PASSWORD: 'Invalid password',
  INVALID_TOKEN: 'Invalid token',
  INVALID_EMAIL_CREDENTIALS: 'Invalid Email or Password',
  INVALID_PHONE_CREDENTIALS: 'Invalid Phone Number or Password',
  USER_NOT_FOUND: 'User not found! Please sign up',
  EMAIL_ALREADY_EXISTS: 'Email already exists',
  USER_ALREADY_EXISTS: 'User already exists! Email or Number already in use',
  PASSWORDS_DO_NOT_MATCH: 'Passwords do not match',
  CURRENT_PASSWORD_INCORRECT: 'Current password is incorrect',
  PASSWORD_RESET_TOKEN_INVALID: 'Password reset token is invalid',
  PASSWORD_RECENTLY_CHANGED: 'Password recently changed. Please login',
  RESET_TOKEN_SENT: 'Reset token sent to email',
  RESET_OTP_SENT: 'Reset OTP sent',
  USER_NOT_FOUND_OR_TOKEN_EXPIRED: 'User not found or reset link has expired',
  USER_NOT_FOUND_OR_OTP_EXPIRED: 'User not found or OTP expired',
  PASSWORD_CHANGED: 'Password changed successfully',
  PASSWORD_RESET: 'Password reset successfully',
  VERIFICATION_EMAIL_SENT: 'Verification link sent to email',
  EMAIL_VERIFIED: 'Email verified successfully',
};

export const USER_MESSAGES = {
  NOT_FOUND: `User doesn't exist`,
  HANDLE_ALREADY_EXISTS: (handle: string) => `Handle ${handle} already exists`,
  USER_ALREADY_IN_THE_WAITLIST: 'You are already in the waitlist',
};

export const ERROR_MESSAGES = {
  BAD_REQUEST: 'Bad request',
  NOT_FOUND: 'Not found',
  SUBDOMAIN_NOT_FOUND: 'Subdomain or domain could not be determined',
  HOST_MISSING: 'Host header is missing',
};

export const INVITE_MESSAGES = {
  INVITE_NOT_FOUND: 'Invite not found',
};

export const ACTIVITYDESCRIPTIONS = {
  REGISTER: 'Account Registered',
  CREATE_SAVEGOAL: 'SaveGoal Created',
  CREATE_LOCKBOX: 'LockBox Created',
  WITHDRAWAL: 'Withdrawal',
  DEPOSIT: 'Deposit',
};
