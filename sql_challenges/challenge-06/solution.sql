-- 1) BEFORE INSERT trigger
CREATE OR REPLACE TRIGGER trg_petcarelog_insert
BEFORE INSERT ON pet_care_log
FOR EACH ROW
BEGIN
  -- assign current date and user
  :NEW.update_datetime := SYSDATE;
  :NEW.updated_by_user := USER;

EXCEPTION
  WHEN OTHERS THEN
    RAISE_APPLICATION_ERROR(-20001, 'Error inserting into PET_CARE_LOG');
END;
/

-- 2) BEFORE UPDATE trigger
CREATE OR REPLACE TRIGGER trg_petcarelog_update
BEFORE UPDATE ON pet_care_log
FOR EACH ROW
BEGIN
  -- check if the same user is updating
  IF :OLD.updated_by_user <> USER THEN
    RAISE_APPLICATION_ERROR(-20002, 'You can only update your own records');
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    RAISE_APPLICATION_ERROR(-20003, 'Error updating PET_CARE_LOG');
END;
/

-- 3) BEFORE DELETE trigger
CREATE OR REPLACE TRIGGER trg_petcarelog_delete
BEFORE DELETE ON pet_care_log
FOR EACH ROW
BEGIN
  -- only manager can delete
  IF USER <> 'JOEMANAGER' THEN
    RAISE_APPLICATION_ERROR(-20004, 'Only JOEMANAGER can delete records');
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    RAISE_APPLICATION_ERROR(-20005, 'Error deleting from PET_CARE_LOG');
END;
/