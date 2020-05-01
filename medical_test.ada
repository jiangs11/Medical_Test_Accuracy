-- Authors: Xiaohui Xie, Jasdip Dhillon, Steven Jiang
-- Date: 10/14/19
-- Purpose: Ada Programming Homework

with Ada.Text_IO, Ada.Integer_Text_IO, Ada.Float_Text_IO;
use Ada.Text_IO, Ada.Integer_Text_IO, Ada.Float_Text_IO;

procedure Main is

   numPatients : Integer;      -- Number of patients
   first : Integer;            -- Patient number, not needed, just skipped
   second : Integer;           -- Has disease
   third : Integer;            -- Test1 Positive
   fourth : Integer;           -- Test2 Positive

   index : Integer := 1;       -- Index for loop

   num1s_in_third : Float := 0.0;       -- Counts number of 1's in Test1 column
   num1s_in_fourth : Float := 0.0;      -- Counts number of 1's in Test2 column
   num0s_in_third : Float := 0.0;       -- Counts number of 0's in Test1 column
   num0s_in_fourth : Float := 0.0;      -- Counts number of 0's in Test2 column

   second_and_third1 : Float := 0.0;    -- Counts number of (1 and 1) in 2nd and 3rd column
   second_and_third0 : Float := 0.0;    -- Counts number of (0 and 0) in 2nd and 3rd column
   second_and_fourth1 : Float := 0.0;   -- Counts number of (1 and 1) in 2nd and 4th column
   second_and_fourth0 : Float := 0.0;   -- Counts number of (0 and 0) in 2nd and 4th column

   probD_Pos1 : Float;
   probD_Pos2 : Float;
   probH_Neg1 : Float;
   probH_Neg2 : Float;

begin

   Put_Line("Enter number of patients: ");
   Get(numPatients);

   while index <= numPatients loop
                    
      -- Grab each number on the input
      -- first isn't needed, just used Get() so we can get the other numbers
      Get(first);
      Get(second);
      Get(third);
      Get(fourth);
      
      
      if third = 1 then
         num1s_in_third := num1s_in_third + 1.0;
      else
         num0s_in_third := num0s_in_third + 1.0;
      end if;

      if fourth = 1 then
         num1s_in_fourth := num1s_in_fourth + 1.0;
      else
         num0s_in_fourth := num0s_in_fourth + 1.0;
      end if;


      if (second = 1) and (third = 1) then
         second_and_third1 := second_and_third1 + 1.0;
      end if;

      if (second = 1) and (fourth = 1) then
         second_and_fourth1 := second_and_fourth1 + 1.0;
      end if;

      if (second = 0) and (third = 0) then
         second_and_third0 := second_and_third0 + 1.0;
      end if;

      if (second = 0) and (fourth = 0) then
         second_and_fourth0 := second_and_fourth0 + 1.0;
      end if;

      index := index + 1;
         
   end loop;
   
   New_Line;

   
   -- Compute the probabilities
   probD_Pos1 := second_and_third1 / num1s_in_third;
   probD_Pos2 := second_and_fourth1 / num1s_in_fourth;
   probH_Neg1 := second_and_third0 / num0s_in_third;
   probH_Neg2 := second_and_fourth0 / num0s_in_fourth;


   Put("P(D | Pos1) = ");
   Put(probD_Pos1, 0, 2, 0);
   New_Line;

   Put("P(D | Pos2) = ");
   Put(probD_Pos2, 0, 2, 0);
   New_Line;

   Put("P(H | Neg1) = ");
   Put(probH_Neg1, 0, 2, 0);
   New_Line;

   Put("P(H | Neg2) = ");
   Put(probH_Neg2, 0, 2, 0);
   New_Line;

   
   -- Determine which test is better
   if (probD_Pos1 > probD_Pos2) and (probH_Neg1 > probH_Neg2) then
      Put_Line("Test 1 is better");
   elsif (probD_Pos2 > probD_Pos1) and (probH_Neg2 > probH_Neg1) then
      Put_Line("Test 2 is better");
   else
      Put_Line("Neither test is better");
   end if;
   
   New_Line;
   
end Main;

