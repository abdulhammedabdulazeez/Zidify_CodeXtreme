export type JwtPayload = {
  id: string;
  email: string;
  phoneNumber: string;
  aud: string;
  iss: string;
  iat: number;
  type?: JwtType;
};

export enum JwtType {
  ACCESS = 'access',
  REFRESH = 'refresh',
}
