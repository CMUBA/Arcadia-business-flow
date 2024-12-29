import { prisma } from "@/lib/prisma";
import { NextResponse } from "next/server";

export async function POST(req: Request) {
  try {
    const data = await req.json();
    const coupon = await prisma.coupons.create({
      data: {
        merchant_id: data.merchantId,
        type_id: data.typeId,
        name: data.name,
        description: data.description,
        discount_value: data.discountValue,
        total_quantity: data.quantity,
        remaining_quantity: data.quantity,
        points_price: data.pointsPrice,
        start_date: data.startDate,
        end_date: data.endDate,
      },
    });
    return NextResponse.json(coupon);
  } catch (error) {
    return NextResponse.json({ error: "Failed to create coupon" }, { status: 500 });
  }
} 