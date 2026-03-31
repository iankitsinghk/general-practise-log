*&---------------------------------------------------------------------*
*& Report ZAKS_BP_01_SUM
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZAKS_AP_B.
*DATA lv_input1(2) type n.
*DATA lv_input2(2) type n.
*DATA lv_output(3) TYPE n.

DATA : lv_input1(2) type n VALUE 10, "First Input
     lv_input2(2) type n value 20, "Second Input
     lv_output(3) TYPE n. "Output

*lv_input1 = 12.
*lv_input2 = 28.

lv_output = lv_input1 + lv_input2.

write / lv_output.
