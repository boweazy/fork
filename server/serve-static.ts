import path from "node:path";
import { fileURLToPath } from "node:url";
import { existsSync } from "node:fs";
import type { Express } from "express";
import express from "express";

const __filename = fileURLToPath(import.meta.url);
const __dirname  = path.dirname(__filename);

export function attachStatic(app: Express) {
  // Try client/dist first (if built), then fall back to public directory
  const candidates = [
    path.resolve(__dirname, "../client/dist"),
    path.resolve(__dirname, "../public"),
    path.resolve(__dirname, "../")
  ];
  
  let staticRoot: string | null = null;
  let indexPath: string | null = null;
  
  for (const candidate of candidates) {
    const testIndex = path.join(candidate, "index.html");
    if (existsSync(testIndex)) {
      staticRoot = candidate;
      indexPath = testIndex;
      console.log(`📁 Serving static files from: ${staticRoot}`);
      break;
    }
  }
  
  if (!staticRoot || !indexPath) {
    console.error("❌ No valid static directory found with index.html");
    app.get("/", (_req, res) => {
      res.status(500).send("Server configuration error: No static files found");
    });
    return;
  }
  
  // Serve static files, but don't auto-serve index.html
  app.use(express.static(staticRoot, { index: false }));
  
  // Serve index.html for root
  app.get("/", (_req, res) => res.sendFile(indexPath));
  
  // SPA fallback - exclude API routes, status, health, and file extensions
  app.get(/^(?!\/api\/|\/status(?:\/|$)|\/health(?:\/|$)|\/__diag\/)(?!.*\.\w+$).*/, (_req, res) => {
    res.sendFile(indexPath);
  });
}