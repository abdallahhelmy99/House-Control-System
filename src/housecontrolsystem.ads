with Ada.Text_IO;

package HouseControlSystem with SPARK_Mode is
   type Door_State is (Open, Closed);
   type Window_State is (Open, Closed);
   type Heating_State is (On, Off);
   type Room is range 1 .. 5; -- Assuming the house has 5 rooms
   -- Variables for house temperature
   Min_Temperature : constant Float := 17.0; -- °C
   Max_Temperature : constant Float := 19.0; -- °C
   Current_Temperature : array (Room) of Float := (others => 18.0);
   -- Variables for humidity
   Min_Humidity : constant Float := 30.0; -- %
   Max_Humidity : constant Float := 50.0; -- %
   Current_Humidity : array (Room) of Float := (others => 40.0);
   -- Variables for fridge and oven doors
   Fridge : Door_State := Closed;
   Oven : Door_State := Closed;
   -- Variables for window and heating
   Window : array (Room) of Window_State := (others => Closed);
   Heating : array (Room) of Heating_State := (others => Off);
   -- Variables for carbon monoxide level
   Safe_CO_Level : constant Float := 50.0; -- parts per million (ppm)
   CO_Level : Float := 0.0;
   
   procedure Open_Fridge_Door with
      Pre => Fridge = Closed,
      Global => (In_Out => Fridge),
      Depends => (Fridge => Fridge),
      Post => Fridge = Open;
   
   procedure Close_Fridge_Door with
      Pre => Fridge = Open,
      Global => (In_Out => Fridge),
      Depends => (Fridge => Fridge),
      Post => Fridge = Closed;
   
   procedure Open_Oven_Door with
      Pre => Oven = Closed,
      Global => (In_Out => Oven),
      Depends => (Oven => Oven),
      Post => Oven = Open;
  
   procedure Close_Oven_Door with
      Pre => Oven = Open,
      Global => (In_Out => Oven),
      Depends => (Oven => Oven),
      Post => Oven = Closed;
   
   procedure Open_Window (R : Room) with
      Pre => Window(R) = Closed and Heating(R) = Off,
      Global => (In_Out => Window, Input => Heating),
      Depends => (Window => Window, null => (R, Heating)),
      Post => Window(R) = Open;

   procedure Turn_Heating_On (R : Room) with
      Pre => Heating(R) = Off and Window(R) = Closed,
      Global => (In_Out => Heating, Input => Window),
      Depends => (Heating => Heating, null => (R, Window)),
      Post => Heating(R) = On;

   procedure Close_Window (R : Room) with
      Pre => Window(R) = Open,
      Global => (In_Out => Window),
      Depends => (Window => Window, null => R),
      Post => Window(R) = Closed;

   procedure Turn_Heating_Off (R : Room) with
      Pre => Heating(R) = On,
      Global => (In_Out => Heating),
      Depends => (Heating => Heating, null => R),
      Post => Heating(R) = Off;

   procedure Check_CO_Level with
      Pre => CO_Level >= 0.0,
      Global => (In_Out => CO_Level),
      Depends => (CO_Level => CO_Level),
      Post => CO_Level >= 0.0 and CO_Level <= Safe_CO_Level;
   
   function Is_Temperature_Safe (R : Room) return Boolean with
      Global => (Input => Current_Temperature),
      Depends => (Is_Temperature_Safe'Result => (Current_Temperature, R)),
      Post => (Current_Temperature(R) >= Min_Temperature and Current_Temperature(R) <= Max_Temperature) = Is_Temperature_Safe'Result;

   function Is_Heating_Safe (R : Room) return Boolean with
      Global => (Input => (Heating, Window)),
      Depends => (Is_Heating_Safe'Result => (Heating, Window, R)),
      Post => (not (Heating(R) = On and Window(R) = Open)) = Is_Heating_Safe'Result;

   function Is_Humidity_Safe (R : Room) return Boolean with
      Global => (Input => Current_Humidity),
      Depends => (Is_Humidity_Safe'Result => (Current_Humidity, R)),
      Post => (Current_Humidity(R) >= Min_Humidity and Current_Humidity(R) <= Max_Humidity) = Is_Humidity_Safe'Result;
   
   function Are_Doors_Safe return Boolean with
      Global => (Input => (Fridge, Oven)),
      Depends => (Are_Doors_Safe'Result => (Fridge, Oven)),
      Post => (not (Fridge = Open or Oven = Open)) = Are_Doors_Safe'Result;
   
   function Is_CO_Level_Safe return Boolean with
        Global => (Input => CO_Level),
        Depends => (Is_CO_Level_Safe'Result => CO_Level),
        Post => (CO_Level <= Safe_CO_Level) = Is_CO_Level_Safe'Result;
   
   procedure Increase_Temperature (R : Room) with
      Pre => Current_Temperature(R) < Max_Temperature,
      Global => (In_Out => Current_Temperature),
      Depends => (Current_Temperature => Current_Temperature, null => R),
      Post => Current_Temperature(R) = Current_Temperature'Old(R) + 1.0;
   
   procedure Decrease_Temperature (R : Room) with
      Pre => Current_Temperature(R) > Min_Temperature,
      Global => (In_Out => Current_Temperature),
      Depends => (Current_Temperature => Current_Temperature, null => R),
      Post => Current_Temperature(R) = Current_Temperature'Old(R) - 1.0;

end HouseControlSystem;