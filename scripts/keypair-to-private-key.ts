#!/usr/bin/env bun
import { Keypair } from "@solana/web3.js";
import bs58 from "bs58";

const input = process.argv[2];

if (!input) {
  console.error("Usage: keypair-to-private-key.ts '<json_array>'");
  process.exit(1);
}

const keypair = Keypair.fromSecretKey(Uint8Array.from(JSON.parse(input)));
console.log(bs58.encode(keypair.secretKey));
