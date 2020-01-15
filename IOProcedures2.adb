--Jessica Byrd
--09/29/2019
--COSC 3319 Data Structures
--Topological Sorting
--3-D Game Board

with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;


package body IOProcedures is

   --Read file open and close
   function Read_In_File return Integer is
      ReadFileIn : File_Type;

      Counter : Integer;

   Begin

      Counter := 0;

      --Open File
      Open(ReadFileIn, In_File, "DataSetD1.txt");

      While not End_Of_File(ReadFileIn)
      Loop

         Declare
            Line_To_Read : String := Get_Line(ReadFileIn);

         Begin

            --Increments here
            Counter := Counter + 1;
         End;

      End Loop;

      --Close File
      Close(ReadFileIn);

      return Counter;

   End Read_In_File;

   storedInfo : array(0..Read_In_File) of String(1..3);

   procedure fillInString(Counter : in Integer) is

      ReadFileIn : File_Type;

   Begin

      Open(ReadFileIn, In_File, "DataSetD1.txt");

      --While not End_Of_File(ReadFileIn)
      for i in 0 .. Counter - 1
      Loop

         Declare

            gettingStoredInfo : String := Get_Line(ReadFileIn);

         Begin

            storedInfo(i) := gettingStoredInfo(1..3);

         End;
      End Loop;

      Put_Line("The DataSet D1 Read from the file is: ");

      for i in 0 .. Counter - 1
      Loop

         Put_Line(storedInfo(i));

      End Loop;

      --Close File
      Close(ReadFileIn);

   End fillInString;

   --Making a function here to return the value stored in the array
   function Getting_The_Array(Value_Stored_In_Array : in Integer) return String is

   Begin

      return(storedInfo(Value_Stored_In_Array));

   End Getting_The_Array;

End IOProcedures;

--End of Program
