import type { NextApiRequest, NextApiResponse } from "next";
export default function h(_q:NextApiRequest,res:NextApiResponse){
  res.status(200).json({ ok:true, ts:Date.now() });
}
