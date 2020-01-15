--Jessica Byrd
--09/29/2019
--COSC 3319 Data Structures
--Topological Sorting
--3-D Game Board

with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with IOProcedures; use IOProcedures;


package body TopologicalSortPackage is

   type Node;
   type NodePtr is access Node;

   --Top is going to by nodes and those nodes will have fields
   --Suc and Next
   type Node is record
      SucValue : Integer;
      Next : NodePtr;

   end Record;

   --Set NA is integer is
   NA : Integer := 9;
   --Initialization & Declaration
   QLink : array(0..NA) of Integer;
   Kount : array(0..NA) of Integer;
   Top   : array(0..NA) of NodePtr;

   procedure Sort_It_Out is

      --Declare J,K,P,NP
      J : Integer;
      K : Integer;
      P : NodePtr;
      NP : NodePtr;

      --Front Pointer
      F : Integer;

      --Rear Pointer
      R : Integer;

      --Declare Temp & KN
      Temp : Integer;
      KN : Integer;

      --To hold each relation
      --String that holds three characters
      Relation_Holder : String(1..3);

   Begin

      P := new Node;
      P.Next := new Node;

      --Initialization & Get the number of actions
      for K in 1..NA
      Loop

         QLink(K) := 0;
         Kount(K) := 0;
         Top(K) := new Node;
         Top(K).SucValue := 0;
         Top(K).Next := NULL;

      End Loop;

      --Set KN to NA
      KN := NA;

      for i in 0 ..Read_In_File - 1
      Loop

         Relation_Holder := Getting_The_Array(i);

         --Part 1
         --Get the number of actions, NA
         --Number two get the first relation J < K

         --J is set to typecasted relation at spot 1 of relation holder
         --K is set to typecasted relation at spot 3 of relation holder
         J := Integer'Value(Relation_Holder(1..1));
         K := Integer'Value(Relation_Holder(3..3));

         --Increase Count by one
         Kount(K) := Kount(K) + 1;

         --Set P to new Node
         P := new Node;

         --Set P.succ <- K
         P.SucValue := K;

         --Set P.Next <- Top[J];
         P.Next := Top(J);

         --Top[J] <- P
         Top(J) := P;

         --Get the Next relation "J < K"
         --Repeat
         --Until out of transactions in the input

      End Loop;

      --Step 3
      --Initialize the output queue by linking all
      --QLink(K) where Kount(k) = 0;
      --Kount(K) = 0 indicates no task must precede the take K in the output
      --Set R = 0;
      R := 0;

      --Set QLink(0) = 0;
      QLink(0) := 0;

      for K in 1..NA
      Loop

         if(Kount(K) = 0)
         Then

            --Set QLInk(R) to K
            QLink(R) := K;

            --Set R to K
            R := K;

         End If;
      End Loop;

      F := QLink(0);

      --Set 4
      --While F not = 0 -- Loop

      While(F /= 0)
      Loop

         --Perform action F --write it in the output
         --Print Order of sort i.e. F
         --Print QLink F
         Put_Line("F is: " & Integer'Image(F));

         --Set KN = KN - 1;
         KN := KN - 1;

         --Set P to Top(F)
         P := Top(F);

         --Set Temp;
         Temp := Top(F).SucValue;

         --Top(I) points to all relations not yet cancelled 1 <= I <= NA
         --While P not = 0 Loop

         While(Temp /= 0)
         Loop

            --Kount(P.SucValue) := Kount(P.SucValue)) - 1;
            Kount(P.SucValue) := Kount(P.SucValue) - 1;

            --If Kount(P.SucValue) = 0 --Then
            if(Kount(P.SucValue) = 0)
            Then

               --Add it to the Queue
               --QLink(R) := P.SucValue;
               QLink(R) := P.SucValue;

               --Set R to P.SucValue;
               R := P.SucValue;

            End if;

            --Set P to P.Next
            P := P.Next;

            --Set Temp to P.SucValue
            Temp := P.SucValue;

         End Loop;

         --Set F to QLink(F)
         F := QLink(F);

      End Loop;

      --Step 5
      --If KN = 0 Then the topo sort has been completed successfully
      --All actions have been printed in the output stream
      if(KN = 0)
      Then

         Put_Line("The Topological Sort has been completed successfully");

         --Else if Kount is != to 0 then the relations have violated the
         --hypothesis for partial order. i.e. the relations contain a loop

      Elsif((KN) /= 0)
      Then

         Put_Line("Your actions can not be completed with the specified dependencies.");

         --For K in 1..NA loop
         for K in 1..NA
         Loop

            --Set QLink(K) to 0
            QLink(K) := 0;

            --End Loop
         End Loop;

         --Step 6 For K in 1..NA Loop
         for K in 1..NA
         Loop

            --Set P to New Node
            P := new node;

            --Set P to Top(K)
            P.SucValue := Top(K).SucValue;
            P.Next := Top(K).Next;

            --Set Top(K) to 0
            Top(K).SucValue := 0;

            --While P <> 0 --Loop
            While((P.SucValue) /= 0)
            Loop

               --Set QLink(P.SucValue) to K
               QLink(P.SucValue) := K;

               --If P <> 0 Then
               If((P.SucValue) /= 0)
               Then

                  --Set P to Next (P)
                  P := P.Next;

               End if;
            End Loop;
         End Loop;

         --At this point QLink(K) wil point to one of the predecessors of
         --action K for each action K that has not yet been processed

         --Step 7
         --Find a K with QLink(K) not = 0
         --This will be part of the loop.
         --Set K to 1
         K := 1;

         --While (QLink(K) = 0)
         --Set K to K + 1 --End Loop
         While(QLink(K) = 0)
         Loop
            K := K + 1;
            if K = QLink'Length
            Then

               Exit;
            End If;
         End Loop;

         --Look for the Loop & Mark it
         --Repeat
         --Set Top(K) to 1
         While(Top(K).SucValue = 0)
         Loop

            Top(K).SucValue := 1;

            --Set K to QLink(K)
            K := QLink(K);

         End Loop;

         --Until Top(K) is not = 0;
         --Step 9
         --Print the loop
         --While Top(K) is not = 0 --Loop
         While(Top(K).SucValue /= 0)
         Loop

            --Print process action K
            --Print the value of K.
            --K is the first node in the loop printed backwards.
            --This terminates the failed sort.
            Put_Line("The Loop is: " & Integer'Image(K));

            --Set Top(K) to 0;
            Top(K).SucValue := 0;

            --Set K to QLink(K)
            K := QLink(K);

         End Loop;

      End If;

   End Sort_It_Out;

End TopologicalSortPackage;

--End of Program







