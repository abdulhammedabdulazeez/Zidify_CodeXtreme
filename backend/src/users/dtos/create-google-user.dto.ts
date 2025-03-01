/**
 * @class contains all the necessary information typically retrieved from a user's Google profile
 * during the OAuth2 authentication process.
 * Also, it complements UpdateUserDto class with the fields that are not included in the AdditionalUserDto class.
 */
export class CreateGoogleUserDto {
  firstName: string;
  lastName: string;
  email: string;
  avatar: string;
  verified: boolean;
  authType: string;
  googleId: string;
}
