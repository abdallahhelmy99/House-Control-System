with Ada.Text_IO; use Ada.Text_IO;

package body HouseControlSystem with SPARK_Mode is

   procedure Open_Fridge_Door is
   begin
      Fridge := Open;
      Put_Line("Fridge door has been opened.");
   end Open_Fridge_Door;
   procedure Close_Fridge_Door is
   begin
      Fridge := Closed;
      Put_Line("Fridge door has been closed.");
   end Close_Fridge_Door;
   procedure Open_Oven_Door is
   begin
      Oven := Open;
      Put_Line("Oven door has been opened.");
   end Open_Oven_Door;
   procedure Close_Oven_Door is
   begin
      Oven := Closed;
      Put_Line("Oven door has been closed.");
   end Close_Oven_Door;
   procedure Open_Window is
   begin
      Window := Open;
      Put_Line("Window has been opened.");
   end Open_Window;
   procedure Close_Window is
   begin
      Window := Closed;
      Put_Line("Window has been closed.");
   end Close_Window;
   procedure Turn_Heating_On is
   begin
      Heating := On;
      Put_Line("Heating has been turned on.");
   end Turn_Heating_On;
   procedure Turn_Heating_Off is
   begin
      Heating := Off;
      Put_Line("Heating has been turned off.");
   end Turn_Heating_Off;
   procedure Check_CO_Level is
   begin
      if CO_Level <= Safe_CO_Level then
         Put_Line("Carbon monoxide level is safe.");
      else
         Put_Line("Warning: Carbon monoxide level is unsafe!");
      end if;
   end Check_CO_Level;

   function Is_Temperature_Safe return Boolean is
   begin
      return Current_Temperature >= Min_Temperature and Current_Temperature <= Max_Temperature;
   end Is_Temperature_Safe;

   function Are_Doors_Safe return Boolean is
   begin
      return not (Fridge = Open and Oven = Open);
   end Are_Doors_Safe;

   function Is_Heating_Safe return Boolean is
   begin
      return not (Heating = On and Window = Open);
   end Is_Heating_Safe;

   function Is_CO_Level_Safe return Boolean is
   begin
      return CO_Level <= Safe_CO_Level;
   end Is_CO_Level_Safe;

end HouseControlSystem;