--Jessica Byrd
--09/29/2019
--COSC 3319 Data Structures
--Topological Sorting
--3-D Game Board

with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with IOProcedures; use IOProcedures;
with TopologicalSortPackage; use TopologicalSortPackage;

Procedure Main is

   K : Integer;

Begin

   K := Read_In_File;

   fillInString(K);

   Sort_It_Out;

   end Main;
