import { prisma } from "@/lib/prisma";
import { NextResponse } from "next/server";

export async function POST(req: Request) {
  try {
    const data = await req.json();
    const merchant = await prisma.merchants.create({
      data: {
        email: data.email,
        name: data.name,
        description: data.description,
        location: data.location,
        images: data.images,
      },
    });
    return NextResponse.json(merchant);
  } catch (error) {
    return NextResponse.json({ error: "Failed to create merchant" }, { status: 500 });
  }
} 