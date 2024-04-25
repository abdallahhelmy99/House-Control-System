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
  
   procedure Open_Window (R : Room) is
   begin
      Window(R) := Open;
      Put_Line("Window has been opened.");
   end Open_Window;

   procedure Close_Window (R : Room) is
   begin
      Window(R) := Closed;
      Put_Line("Window has been closed.");
   end Close_Window;
   
   procedure Turn_Heating_On (R : Room) is
   begin
      Heating(R) := On;
      Put_Line("Heating has been turned on.");
   end Turn_Heating_On;

   procedure Turn_Heating_Off (R : Room) is
   begin
      Heating(R) := Off;
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

   function Is_Temperature_Safe (R : Room) return Boolean is
   begin
      return Current_Temperature(R) >= Min_Temperature and Current_Temperature(R) <= Max_Temperature;
   end Is_Temperature_Safe;

   function Are_Doors_Safe return Boolean is
   begin
      return not (Fridge = Open and Oven = Open);
   end Are_Doors_Safe;

   function Is_Heating_Safe (R : Room) return Boolean is
   begin
      return not (Heating(R) = On and Window(R) = Open);
   end Is_Heating_Safe;
 
   function Is_CO_Level_Safe return Boolean is
   begin
      return CO_Level <= Safe_CO_Level;
   end Is_CO_Level_Safe;

   function Is_Humidity_Safe (R : Room) return Boolean is
   begin
      return Current_Humidity(R) >= Min_Humidity and Current_Humidity(R) <= Max_Humidity;
   end Is_Humidity_Safe;

   procedure Increase_Temperature (R : Room) is
   begin
      if Current_Temperature(R) < Max_Temperature then
         Current_Temperature(R) := Current_Temperature(R) + 1.0;
         Put_Line("Temperature in room " & Room'Image(R) & " has been increased.");
      else
         Put_Line("Temperature in room " & Room'Image(R) & " is already at the maximum.");
      end if;
   end Increase_Temperature;

   procedure Decrease_Temperature (R : Room) is
   begin
      if Current_Temperature(R) > Min_Temperature then
         Current_Temperature(R) := Current_Temperature(R) - 1.0;
         Put_Line("Temperature in room " & Room'Image(R) & " has been decreased.");
      else
         Put_Line("Temperature in room " & Room'Image(R) & " is already at the minimum.");
      end if;
   end Decrease_Temperature;

end HouseControlSystem;