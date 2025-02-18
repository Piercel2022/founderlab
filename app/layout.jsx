// app/layout.jsx
import Navigation from '@/components/Navigation';

export default function RootLayout({ children }) {
  return (
    <html lang="en">
      <body>
        <Navigation>
          {children}
        </Navigation>
      </body>
    </html>
  );
}