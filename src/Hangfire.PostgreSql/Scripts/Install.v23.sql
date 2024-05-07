SET search_path = 'hangfire';

DO
$$
    BEGIN
        IF EXISTS(SELECT 1 FROM "schema" WHERE "version"::integer >= 23) THEN
            RAISE EXCEPTION 'version-already-applied';
        END IF;
    END
$$;

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" SCHEMA hangfire;

-- Добавляем временный столбец new_id типа UUID для таблицы "counter"
ALTER TABLE "counter" ADD COLUMN new_id UUID default gen_random_uuid();
-- Заполняем новый столбец new_id новыми значениями UUID для существующих записей
UPDATE "counter" SET new_id = gen_random_uuid();
-- Удаляем старый столбец id из таблицы "counter"
ALTER TABLE "counter" DROP COLUMN id;
-- Переименовываем временный столбец new_id в id для таблицы "counter"
ALTER TABLE "counter" RENAME COLUMN new_id TO id;

-- Повторяем те же шаги для остальных таблиц

-- Таблица "hash"
ALTER TABLE "hash" ADD COLUMN new_id UUID default gen_random_uuid();
UPDATE "hash" SET new_id = gen_random_uuid();
ALTER TABLE "hash" DROP COLUMN id;
ALTER TABLE "hash" RENAME COLUMN new_id TO id;

-- Таблица "state"
ALTER TABLE "state" ADD COLUMN new_id UUID default gen_random_uuid();
UPDATE "state" SET new_id = gen_random_uuid();
ALTER TABLE "state" DROP COLUMN id;
ALTER TABLE "state" RENAME COLUMN new_id TO id;

ALTER TABLE "state" ADD COLUMN new_jobid UUID;
UPDATE "state" SET new_jobid = gen_random_uuid();
ALTER TABLE "state" DROP COLUMN jobid;
ALTER TABLE "state" RENAME COLUMN new_jobid TO jobid;

-- Таблица "jobparameter"
ALTER TABLE "jobparameter" ADD COLUMN new_id UUID default gen_random_uuid();
UPDATE "jobparameter" SET new_id = gen_random_uuid();
ALTER TABLE "jobparameter" DROP COLUMN id;
ALTER TABLE "jobparameter" RENAME COLUMN new_id TO id;

ALTER TABLE "jobparameter" ADD COLUMN new_jobid UUID;
UPDATE "jobparameter" SET new_jobid = gen_random_uuid();
ALTER TABLE "jobparameter" DROP COLUMN jobid;
ALTER TABLE "jobparameter" RENAME COLUMN new_jobid TO jobid;

-- Таблица "jobqueue"
ALTER TABLE "jobqueue" ADD COLUMN new_id UUID default gen_random_uuid();
UPDATE "jobqueue" SET new_id = gen_random_uuid();
ALTER TABLE "jobqueue" DROP COLUMN id;
ALTER TABLE "jobqueue" RENAME COLUMN new_id TO id;

ALTER TABLE "jobqueue" ADD COLUMN new_jobid UUID;
UPDATE "jobqueue" SET new_jobid = gen_random_uuid();
ALTER TABLE "jobqueue" DROP COLUMN jobid;
ALTER TABLE "jobqueue" RENAME COLUMN new_jobid TO jobid;

-- Таблица "list"
ALTER TABLE "list" ADD COLUMN new_id UUID default gen_random_uuid();
UPDATE "list" SET new_id = gen_random_uuid();
ALTER TABLE "list" DROP COLUMN id;
ALTER TABLE "list" RENAME COLUMN new_id TO id;

-- Таблица "set"
ALTER TABLE "set" ADD COLUMN new_id UUID default gen_random_uuid();
UPDATE "set" SET new_id = gen_random_uuid();
ALTER TABLE "set" DROP COLUMN id;
ALTER TABLE "set" RENAME COLUMN new_id TO id;

-- Таблица "job"
ALTER TABLE "job" ADD COLUMN new_id UUID default gen_random_uuid();
UPDATE "job" SET new_id = gen_random_uuid();
ALTER TABLE "job" DROP COLUMN id;
ALTER TABLE "job" RENAME COLUMN new_id TO id;

ALTER TABLE "job" ADD COLUMN new_stateid UUID;
UPDATE "job" SET new_stateid = gen_random_uuid();
ALTER TABLE "job" DROP COLUMN stateid;
ALTER TABLE "job" RENAME COLUMN new_stateid TO stateid;


RESET search_path;