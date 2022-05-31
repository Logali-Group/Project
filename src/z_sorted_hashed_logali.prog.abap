*&---------------------------------------------------------------------*
*& Report z_sorted_hashed_logali
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_sorted_hashed_logali.

DATA: gt_employees_sorted TYPE SORTED TABLE OF snwd_employees WITH UNIQUE KEY employee_id,
      gt_employees_hashed TYPE HASHED TABLE OF snwd_employees WITH UNIQUE KEY employee_id,
      gs_employee         TYPE snwd_employees.

gs_employee-employee_id = '0003'.

INSERT gs_employee INTO TABLE gt_employees_sorted.

gs_employee-employee_id = '0002'.

INSERT gs_employee INTO TABLE gt_employees_sorted.

*gs_employee-employee_id = '0003'.
*INSERT gs_employee INTO TABLE gt_employees_sorted.

gs_employee-employee_id = '0002'.

INSERT gs_employee INTO TABLE gt_employees_hashed.


WRITE: / 'FIN'.

cl_demo_output=>display( gt_employees_hashed ).
