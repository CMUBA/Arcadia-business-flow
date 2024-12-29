import { Resend } from 'resend';

const resend = new Resend(process.env.RESEND_API_KEY);

export async function sendVerificationEmail(email: string, url: string) {
  try {
    const { data, error } = await resend.emails.send({
      from: 'Arcadia <onboarding@resend.dev>',
      to: email,
      subject: 'Verify your email',
      html: `
        <h1>Welcome to Arcadia</h1>
        <p>Click the link below to verify your email:</p>
        <a href="${url}">${url}</a>
      `,
    });

    if (error) {
      console.error('Failed to send verification email:', error);
      return false;
    }

    return true;
  } catch (error) {
    console.error('Error sending verification email:', error);
    return false;
  }
} 