*&---------------------------------------------------------------------*
*& Report ZAKS_BP_SYS_VAR
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZAKS_BP_SYS_VAR.

WRITE : / 'The name of user is :', sy-uname.

DO 10 TIMES.
  write : / 'SY-INDEX', sy-index,
          / 'SY-TABIX', sy-tabix.

ENDDO.

write : / 'current date is ', sy-datum.
write : / 'current time is ', sy-uzeit.
