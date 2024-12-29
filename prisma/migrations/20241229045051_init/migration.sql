-- CreateTable
CREATE TABLE "merchants" (
    "id" SERIAL NOT NULL,
    "email" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "location" JSONB,
    "images" TEXT[],
    "points" INTEGER NOT NULL DEFAULT 0,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "merchants_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "coupon_types" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT,

    CONSTRAINT "coupon_types_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "coupons" (
    "id" SERIAL NOT NULL,
    "merchant_id" INTEGER NOT NULL,
    "type_id" INTEGER NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "discount_value" DECIMAL(65,30) NOT NULL,
    "total_quantity" INTEGER NOT NULL,
    "remaining_quantity" INTEGER NOT NULL,
    "points_price" INTEGER NOT NULL,
    "start_date" TIMESTAMP(3) NOT NULL,
    "end_date" TIMESTAMP(3) NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "coupons_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "player_coupons" (
    "id" SERIAL NOT NULL,
    "coupon_id" INTEGER NOT NULL,
    "player_id" TEXT NOT NULL,
    "pass_code" TEXT NOT NULL,
    "qr_code" TEXT,
    "status" TEXT NOT NULL DEFAULT 'unused',
    "used_at" TIMESTAMP(3),
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "player_coupons_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "recharge_codes" (
    "id" SERIAL NOT NULL,
    "code" TEXT NOT NULL,
    "points" INTEGER NOT NULL,
    "merchant_id" INTEGER NOT NULL,
    "status" TEXT NOT NULL DEFAULT 'unused',
    "used_at" TIMESTAMP(3),
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "recharge_codes_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "merchants_email_key" ON "merchants"("email");

-- CreateIndex
CREATE UNIQUE INDEX "player_coupons_pass_code_key" ON "player_coupons"("pass_code");

-- CreateIndex
CREATE UNIQUE INDEX "recharge_codes_code_key" ON "recharge_codes"("code");

-- AddForeignKey
ALTER TABLE "coupons" ADD CONSTRAINT "coupons_merchant_id_fkey" FOREIGN KEY ("merchant_id") REFERENCES "merchants"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "coupons" ADD CONSTRAINT "coupons_type_id_fkey" FOREIGN KEY ("type_id") REFERENCES "coupon_types"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "player_coupons" ADD CONSTRAINT "player_coupons_coupon_id_fkey" FOREIGN KEY ("coupon_id") REFERENCES "coupons"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "recharge_codes" ADD CONSTRAINT "recharge_codes_merchant_id_fkey" FOREIGN KEY ("merchant_id") REFERENCES "merchants"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
