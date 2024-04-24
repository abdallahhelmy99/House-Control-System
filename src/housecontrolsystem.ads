package HouseControlSystem with SPARK_Mode is
    type Door_State is (Open, Closed);
    type Window_State is (Open, Closed);
    type Heating_State is (On, Off);
    -- Variables for house temperature
    Min_Temperature : constant Float := 17.0; -- °C
    Max_Temperature : constant Float := 19.0; -- °C
    Current_Temperature : Float := 18.0;
    -- Variables for fridge and oven doors
    Fridge : Door_State := Closed;
    Oven : Door_State := Closed;
    -- Variables for window and heating
    Window : Window_State := Closed;
    Heating : Heating_State := Off;
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
   procedure Open_Window with
      Pre => Window = Closed,
      Global => (In_Out => Window),
      Depends => (Window => Window),
      Post => Window = Open;
   procedure Close_Window with
      Pre => Window = Open,
      Global => (In_Out => Window),
      Depends => (Window => Window),
      Post => Window = Closed;
   procedure Turn_Heating_On with
      Pre => Heating = Off,
      Global => (In_Out => Heating),
      Depends => (Heating => Heating),
      Post => Heating = On;
   procedure Turn_Heating_Off with
      Pre => Heating = On,
      Global => (In_Out => Heating),
      Depends => (Heating => Heating),
      Post => Heating = Off;
   procedure Check_CO_Level with
      Pre => CO_Level >= 0.0,
      Global => (In_Out => CO_Level),
      Depends => (CO_Level => CO_Level),
      Post => CO_Level >= 0.0 and CO_Level <= Safe_CO_Level;
    function Is_Temperature_Safe return Boolean with
        Global => (Input => Current_Temperature),
        Depends => (Is_Temperature_Safe'Result => Current_Temperature),
        Post => (Current_Temperature >= Min_Temperature and Current_Temperature <= Max_Temperature) = Is_Temperature_Safe'Result;
    function Are_Doors_Safe return Boolean with
        Global => (Input => (Fridge, Oven)),
        Depends => (Are_Doors_Safe'Result => (Fridge, Oven)),
        Post => (not (Fridge = Open and Oven = Open)) = Are_Doors_Safe'Result;
    function Is_Heating_Safe return Boolean with
        Global => (Input => (Heating, Window)),
        Depends => (Is_Heating_Safe'Result => (Heating, Window)),
        Post => (not (Heating = On and Window = Open)) = Is_Heating_Safe'Result;
    function Is_CO_Level_Safe return Boolean with
        Global => (Input => CO_Level),
        Depends => (Is_CO_Level_Safe'Result => CO_Level),
        Post => (CO_Level <= Safe_CO_Level) = Is_CO_Level_Safe'Result;
end HouseControlSystem;