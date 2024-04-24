with Ada.Text_IO; use Ada.Text_IO;

package HouseControlSystem with SPARK_Mode is

   type Door_State is (Open, Closed);
   type Window_State is (Open, Closed);
   type Heating_State is (On, Off);

   -- Variables for house temperature
   Min_Temperature : constant Float := 17.0; -- °C
   Max_Temperature : constant Float := 19.0; -- °C
   Current_Temperature : Float := 18.0; -- in °C

   -- Variables for fridge and oven doors
   Fridge : Door_State := Closed;
   Oven : Door_State := Closed;

   -- Variables for window and heating
   Window : Window_State := Closed;
   Heating : Heating_State := Off;

   -- Variables for carbon monoxide level
   Safe_CO_Level : constant Float := 50.0; -- parts per million (ppm)
   CO_Level : Float := 0.0; -- in ppm

   procedure Open_Fridge_Door;
   procedure Close_Fridge_Door;
   procedure Open_Oven_Door;
   procedure Close_Oven_Door;
   procedure Open_Window;
   procedure Close_Window;
   procedure Turn_Heating_On;
   procedure Turn_Heating_Off;
   procedure Check_CO_Level;
   function Is_Temperature_Safe return Boolean;
   function Are_Doors_Safe return Boolean;
   function Is_Heating_Safe return Boolean;
   function Is_CO_Level_Safe return Boolean;

end HouseControlSystem;