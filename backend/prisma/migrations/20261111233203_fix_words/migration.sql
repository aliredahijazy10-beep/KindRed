/*
  Warnings:

  - The values [0-] on the enum `BloodType` will be removed. If these variants are still used in the database, this will fail.

*/
-- AlterEnum
BEGIN;
CREATE TYPE "BloodType_new" AS ENUM ('A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-');
ALTER TABLE "donors" ALTER COLUMN "blood_type" TYPE "BloodType_new" USING ("blood_type"::text::"BloodType_new");
ALTER TABLE "blood_requests" ALTER COLUMN "blood_type" TYPE "BloodType_new" USING ("blood_type"::text::"BloodType_new");
ALTER TYPE "BloodType" RENAME TO "BloodType_old";
ALTER TYPE "BloodType_new" RENAME TO "BloodType";
DROP TYPE "public"."BloodType_old";
COMMIT;

-- DropForeignKey
ALTER TABLE "admins" DROP CONSTRAINT "admins_user_id_fkey";

-- DropForeignKey
ALTER TABLE "blood_requests" DROP CONSTRAINT "blood_requests_admin_id_fkey";

-- AddForeignKey
ALTER TABLE "admins" ADD CONSTRAINT "admins_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "blood_requests" ADD CONSTRAINT "blood_requests_admin_id_fkey" FOREIGN KEY ("admin_id") REFERENCES "admins"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
