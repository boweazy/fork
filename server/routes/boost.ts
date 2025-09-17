import { Router } from "express";
const r = Router();
r.get("/health", (_req, res) => res.status(200).json({ ok: true, ts: Date.now() }));
r.options("/api/boost", (_req, res) => { res.setHeader("Access-Control-Allow-Origin","*"); res.status(200).end(); });
r.get("/api/boost", (_req, res) => { res.setHeader("Access-Control-Allow-Origin","*"); res.status(200).json({ ok:true, ts: Date.now(), count: 1 }); });
export default r;