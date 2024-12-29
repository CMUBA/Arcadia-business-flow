'use client';

import { signIn } from 'next-auth/react';
import { Button } from '@/components/ui/button';

export function LoginButton() {
  return (
    <Button
      onClick={() => signIn('github', { callbackUrl: '/dashboard' })}
      className="w-full"
    >
      Sign in with GitHub
    </Button>
  );
} 