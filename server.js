// Production server.js for Replit deployment
import { spawn } from 'child_process';
const PORT = process.env.PORT || 5000;

console.log(`Starting SmartFlowSite production server on port ${PORT}`);

// Start the Express TypeScript server using Node with tsx loader (production-safe)
const serverProcess = spawn(process.execPath, [
  '--loader', 'tsx',
  'server/index.ts'
], {
  stdio: 'inherit',
  env: { 
    ...process.env, 
    PORT: PORT, 
    NODE_ENV: 'production' 
  }
});

// Handle server process errors
serverProcess.on('error', (error) => {
  console.error(`Server startup error: ${error}`);
  process.exit(1);
});

serverProcess.on('exit', (code, signal) => {
  console.log(`Server process exited with code ${code} and signal ${signal}`);
  process.exit(code || 0);
});

// Handle graceful shutdown with proper signal forwarding
const shutdown = (signal) => {
  console.log(`Received ${signal}, shutting down gracefully`);
  serverProcess.kill(signal);
  
  // Wait for server to shutdown, then exit
  serverProcess.on('exit', () => {
    process.exit(0);
  });
  
  // Force exit after timeout
  setTimeout(() => {
    console.log('Force killing server process');
    serverProcess.kill('SIGKILL');
    process.exit(1);
  }, 10000);
};

process.on('SIGTERM', () => shutdown('SIGTERM'));
process.on('SIGINT', () => shutdown('SIGINT'));
