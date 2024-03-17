import { Providers } from "./providers";
import "@rainbow-me/rainbowkit/styles.css";
import { Metadata } from "next";
import { ScaffoldEthAppWithProviders } from "~~/components/ScaffoldEthAppWithProviders";
import { ThemeProvider } from "~~/components/ThemeProvider";
import "~~/styles/globals.css";

const baseUrl = process.env.VERCEL_URL
  ? `https://${process.env.VERCEL_URL}`
  : `http://localhost:${process.env.PORT || 3000}`;
const imageUrl = `${baseUrl}/thumbnail.jpg`;

export const metadata: Metadata = {
  metadataBase: new URL(baseUrl),
  title: {
    default: "Only Fanz App",
    template: "%s | Only Fanz",
  },
  description: "Built with 🏗 Only Fanz",
  openGraph: {
    title: {
      default: "Only Fanz App",
      template: "%s | Only Fanz",
    },
    description: "Built with 🏗 Only Fanz",
    images: [
      {
        url: imageUrl,
      },
    ],
  },
  twitter: {
    card: "summary_large_image",
    images: [imageUrl],
    title: {
      default: "Only Fanz",
      template: "%s | Only Fanz",
    },
    description: "Built with 🏗 for Only Fanz",
  },
  icons: {
    icon: [{ url: "/favicon.png", sizes: "32x32", type: "image/png" }],
  },
};

const ScaffoldEthApp = ({ children }: { children: React.ReactNode }) => {
  return (
    <html suppressHydrationWarning>
      <body>
        <Providers>
          <ThemeProvider enableSystem>
            <ScaffoldEthAppWithProviders>{children}</ScaffoldEthAppWithProviders>
          </ThemeProvider>
        </Providers>
      </body>
    </html>
  );
};

export default ScaffoldEthApp;
