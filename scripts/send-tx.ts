#!/usr/bin/env bun
import { Connection, Keypair, SystemProgram, Transaction } from "@solana/web3.js";
import bs58 from "bs58";

const args = process.argv.slice(2);

if (args.length < 1) {
  console.error("Usage: send-tx.ts <sender_url>");
  console.error("  sender_url: Atlas txn sender HTTP endpoint (e.g. http://localhost:4014)");
  process.exit(1);
}

const rpcUrl = "https://api.mainnet-beta.solana.com";
const [senderUrl] = args;
const keypair = Keypair.generate();

console.log("RPC URL:", rpcUrl);
console.log("Sender URL:", senderUrl);
console.log("Pubkey:", keypair.publicKey.toBase58());

const connection = new Connection(rpcUrl, "confirmed");
const blockhash = await connection.getLatestBlockhash();
console.log("Blockhash:", blockhash.blockhash);

const tx = new Transaction({
  recentBlockhash: blockhash.blockhash,
  feePayer: keypair.publicKey,
}).add(
  SystemProgram.transfer({
    fromPubkey: keypair.publicKey,
    toPubkey: keypair.publicKey,
    lamports: 1,
  })
);

tx.sign(keypair);
const signature = bs58.encode(tx.signature!);
const serialized = tx.serialize();

console.log("Signature:", signature);
console.log("Transaction size:", serialized.length, "bytes");
console.log("Sending transaction to", senderUrl + "...");

const response = await fetch(senderUrl, {
  method: "POST",
  headers: { "Content-Type": "application/json" },
  body: JSON.stringify({
    jsonrpc: "2.0",
    id: 1,
    method: "sendTransaction",
    params: [serialized.toString("base64"), { encoding: "base64", skipPreflight: true }],
  }),
});

const text = await response.text();
console.log("Response status:", response.status);
console.log("Response headers:", Object.fromEntries(response.headers.entries()));
console.log("Response body:", text);

if (response.ok) {
  console.log("\nTransaction sent successfully!");
  console.log("Check landing with: solana confirm", signature);
}
