-- CreateTable
CREATE TABLE "vehicle" (
    "idvehicle" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "plate" TEXT NOT NULL,
    "detail" TEXT NOT NULL,
    "year" INTEGER NOT NULL,
    "price_per_day" DOUBLE PRECISION NOT NULL,
    "long_description" TEXT NOT NULL,
    "categoryIdcategory" INTEGER,
    "modelIdmodel" INTEGER,
    "dealerIddealer" INTEGER,
    "deleted" BOOLEAN NOT NULL,

    CONSTRAINT "vehicle_pkey" PRIMARY KEY ("idvehicle")
);

-- CreateTable
CREATE TABLE "brand" (
    "idbrand" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "url" TEXT NOT NULL,
    "deleted" BOOLEAN NOT NULL,

    CONSTRAINT "brand_pkey" PRIMARY KEY ("idbrand")
);

-- CreateTable
CREATE TABLE "model" (
    "idmodel" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "brandIdbrand" INTEGER,
    "deleted" BOOLEAN NOT NULL,

    CONSTRAINT "model_pkey" PRIMARY KEY ("idmodel")
);

-- CreateTable
CREATE TABLE "dealer" (
    "iddealer" SERIAL NOT NULL,
    "address" TEXT NOT NULL,
    "state" TEXT NOT NULL,
    "city" TEXT NOT NULL,
    "country" TEXT NOT NULL,
    "zip_code" INTEGER NOT NULL,

    CONSTRAINT "dealer_pkey" PRIMARY KEY ("iddealer")
);

-- CreateTable
CREATE TABLE "user" (
    "iduser" SERIAL NOT NULL,
    "first_name" TEXT,
    "last_name" TEXT,
    "phone" INTEGER,
    "email" TEXT NOT NULL,
    "identification" TEXT,
    "password" TEXT NOT NULL,
    "address" TEXT,
    "city" TEXT,
    "state" TEXT,
    "country" TEXT,
    "zip_code" INTEGER,
    "idrole" INTEGER NOT NULL DEFAULT 2,
    "deleted" BOOLEAN NOT NULL,

    CONSTRAINT "user_pkey" PRIMARY KEY ("iduser")
);

-- CreateTable
CREATE TABLE "role" (
    "idrole" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "deleted" BOOLEAN NOT NULL,

    CONSTRAINT "role_pkey" PRIMARY KEY ("idrole")
);

-- CreateTable
CREATE TABLE "image" (
    "idimage" SERIAL NOT NULL,
    "url" TEXT NOT NULL,
    "vehicleIdvehicle" INTEGER NOT NULL,
    "deleted" BOOLEAN NOT NULL,

    CONSTRAINT "image_pkey" PRIMARY KEY ("idimage")
);

-- CreateTable
CREATE TABLE "category" (
    "idcategory" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "url" TEXT NOT NULL,
    "deleted" BOOLEAN NOT NULL,

    CONSTRAINT "category_pkey" PRIMARY KEY ("idcategory")
);

-- CreateTable
CREATE TABLE "specification" (
    "idspecification" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "url" TEXT NOT NULL,
    "vehicleIdvehicle" INTEGER NOT NULL,
    "deleted" BOOLEAN NOT NULL,

    CONSTRAINT "specification_pkey" PRIMARY KEY ("idspecification")
);

-- CreateTable
CREATE TABLE "favorite" (
    "idvehicle" INTEGER NOT NULL,
    "iduser" INTEGER NOT NULL,

    CONSTRAINT "favorite_pkey" PRIMARY KEY ("iduser","idvehicle")
);

-- CreateTable
CREATE TABLE "rating" (
    "idvehicle" INTEGER NOT NULL,
    "iduser" INTEGER NOT NULL,
    "rate" INTEGER NOT NULL,
    "date" TIMESTAMP(3) NOT NULL,
    "description" TEXT,

    CONSTRAINT "rating_pkey" PRIMARY KEY ("iduser","idvehicle")
);

-- CreateTable
CREATE TABLE "reservation" (
    "idreservation" SERIAL NOT NULL,
    "checkin_date" TIMESTAMP(3) NOT NULL,
    "checkout_date" TIMESTAMP(3) NOT NULL,
    "vehicleIdvehicle" INTEGER NOT NULL,
    "userIduser" INTEGER NOT NULL,

    CONSTRAINT "reservation_pkey" PRIMARY KEY ("idreservation")
);

-- CreateTable
CREATE TABLE "order" (
    "idorder" SERIAL NOT NULL,
    "days" INTEGER NOT NULL,
    "total" DOUBLE PRECISION NOT NULL,
    "userIduser" INTEGER NOT NULL,

    CONSTRAINT "order_pkey" PRIMARY KEY ("idorder")
);

-- CreateTable
CREATE TABLE "availabilityPeriod" (
    "id" SERIAL NOT NULL,
    "startDate" TIMESTAMP(3) NOT NULL,
    "endDate" TIMESTAMP(3) NOT NULL,
    "vehicleId" INTEGER NOT NULL,

    CONSTRAINT "availabilityPeriod_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "plate_UNIQUE" ON "vehicle"("plate");

-- CreateIndex
CREATE UNIQUE INDEX "brand_name" ON "brand"("name");

-- CreateIndex
CREATE UNIQUE INDEX "model_name" ON "model"("name");

-- CreateIndex
CREATE UNIQUE INDEX "email_UNIQUE" ON "user"("email");

-- CreateIndex
CREATE UNIQUE INDEX "category_UNIQUE" ON "category"("name");

-- AddForeignKey
ALTER TABLE "vehicle" ADD CONSTRAINT "vehicle_categoryIdcategory_fkey" FOREIGN KEY ("categoryIdcategory") REFERENCES "category"("idcategory") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "vehicle" ADD CONSTRAINT "vehicle_modelIdmodel_fkey" FOREIGN KEY ("modelIdmodel") REFERENCES "model"("idmodel") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "vehicle" ADD CONSTRAINT "vehicle_dealerIddealer_fkey" FOREIGN KEY ("dealerIddealer") REFERENCES "dealer"("iddealer") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "model" ADD CONSTRAINT "model_brandIdbrand_fkey" FOREIGN KEY ("brandIdbrand") REFERENCES "brand"("idbrand") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "user" ADD CONSTRAINT "user_idrole_fkey" FOREIGN KEY ("idrole") REFERENCES "role"("idrole") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "image" ADD CONSTRAINT "image_vehicleIdvehicle_fkey" FOREIGN KEY ("vehicleIdvehicle") REFERENCES "vehicle"("idvehicle") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "specification" ADD CONSTRAINT "specification_vehicleIdvehicle_fkey" FOREIGN KEY ("vehicleIdvehicle") REFERENCES "vehicle"("idvehicle") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "favorite" ADD CONSTRAINT "favorite_idvehicle_fkey" FOREIGN KEY ("idvehicle") REFERENCES "vehicle"("idvehicle") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "favorite" ADD CONSTRAINT "favorite_iduser_fkey" FOREIGN KEY ("iduser") REFERENCES "user"("iduser") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "rating" ADD CONSTRAINT "rating_idvehicle_fkey" FOREIGN KEY ("idvehicle") REFERENCES "vehicle"("idvehicle") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "rating" ADD CONSTRAINT "rating_iduser_fkey" FOREIGN KEY ("iduser") REFERENCES "user"("iduser") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "reservation" ADD CONSTRAINT "reservation_vehicleIdvehicle_fkey" FOREIGN KEY ("vehicleIdvehicle") REFERENCES "vehicle"("idvehicle") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "reservation" ADD CONSTRAINT "reservation_userIduser_fkey" FOREIGN KEY ("userIduser") REFERENCES "user"("iduser") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "order" ADD CONSTRAINT "order_userIduser_fkey" FOREIGN KEY ("userIduser") REFERENCES "user"("iduser") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "availabilityPeriod" ADD CONSTRAINT "availabilityPeriod_vehicleId_fkey" FOREIGN KEY ("vehicleId") REFERENCES "vehicle"("idvehicle") ON DELETE CASCADE ON UPDATE CASCADE;
