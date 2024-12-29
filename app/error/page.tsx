'use client';

import { useSearchParams } from 'next/navigation';

export default function ErrorPage() {
  const searchParams = useSearchParams();
  const error = searchParams.get('error');

  return (
    <div className="flex min-h-screen flex-col items-center justify-center">
      <h1 className="text-2xl font-bold text-red-600">Authentication Error</h1>
      <p className="mt-2 text-gray-600">{error}</p>
    </div>
  );
} 