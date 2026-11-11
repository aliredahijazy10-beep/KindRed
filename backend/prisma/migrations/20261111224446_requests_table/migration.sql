-- CreateEnum
CREATE TYPE "Urgency" AS ENUM ('critical', 'high', 'standard');

-- CreateEnum
CREATE TYPE "RequestStatus" AS ENUM ('open', 'fulfilled', 'cancelled', 'expired');

-- CreateTable
CREATE TABLE "blood_requests" (
    "id" SERIAL NOT NULL,
    "patient_name" TEXT NOT NULL,
    "blood_type" "BloodType" NOT NULL,
    "city" TEXT NOT NULL,
    "hospital_name" TEXT NOT NULL,
    "units_needed" INTEGER NOT NULL DEFAULT 1,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "needed_by_date" TIMESTAMP(3) NOT NULL,
    "urgency" "Urgency" NOT NULL DEFAULT 'standard',
    "status" "RequestStatus" NOT NULL DEFAULT 'open',
    "admin_id" INTEGER NOT NULL,

    CONSTRAINT "blood_requests_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "blood_requests_blood_type_city_status_idx" ON "blood_requests"("blood_type", "city", "status");

-- CreateIndex
CREATE INDEX "blood_requests_admin_id_idx" ON "blood_requests"("admin_id");

-- AddForeignKey
ALTER TABLE "blood_requests" ADD CONSTRAINT "blood_requests_admin_id_fkey" FOREIGN KEY ("admin_id") REFERENCES "admins"("id") ON DELETE CASCADE ON UPDATE CASCADE;
