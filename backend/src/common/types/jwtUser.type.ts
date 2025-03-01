export type JwtUser = {
  id: string;
  email?: string;
  phoneNumber?: string;
} & (
  | { email: string; phoneNumber?: string }
  | { email?: string; phoneNumber: string }
);
