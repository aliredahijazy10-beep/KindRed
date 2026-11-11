-- CreateEnum
CREATE TYPE "ResponseStatus" AS ENUM ('pending', 'accepted', 'rejected', 'donated', 'cancelled');

-- CreateTable
CREATE TABLE "responded_requests" (
    "id" SERIAL NOT NULL,
    "donor_id" INTEGER NOT NULL,
    "request_id" INTEGER NOT NULL,
    "responded_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "status" "ResponseStatus" NOT NULL DEFAULT 'pending',

    CONSTRAINT "responded_requests_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "responded_requests_request_id_status_idx" ON "responded_requests"("request_id", "status");

-- CreateIndex
CREATE UNIQUE INDEX "responded_requests_request_id_donor_id_key" ON "responded_requests"("request_id", "donor_id");

-- AddForeignKey
ALTER TABLE "responded_requests" ADD CONSTRAINT "responded_requests_donor_id_fkey" FOREIGN KEY ("donor_id") REFERENCES "donors"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "responded_requests" ADD CONSTRAINT "responded_requests_request_id_fkey" FOREIGN KEY ("request_id") REFERENCES "blood_requests"("id") ON DELETE CASCADE ON UPDATE CASCADE;
