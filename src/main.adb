with HouseControlSystem; use HouseControlSystem;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Float_Text_IO;

procedure Main is

  procedure ShowInformation is
   package FIO renames Ada.Float_Text_IO;
   begin
      Put_Line("------------------------------");
      Put_Line("Welcome to the House Control System!");
      Put_Line("Current Status:");
      Put("Temperature: ");
      FIO.Put(Item => Current_Temperature, Fore => 1, Aft => 2, Exp => 0);
      Put_Line(" °C");      Put_Line("Fridge Door Status: " & Door_State'Image(Fridge));
      Put_Line("Oven Door Status: " & Door_State'Image(Oven));
      Put_Line("Window Status: " & Window_State'Image(Window));
      Put_Line("Heating Status: " & Heating_State'Image(Heating));
      Put("Carbon Monoxide Level: ");
      FIO.Put(Item => CO_Level, Fore => 1, Aft => 2, Exp => 0);
      Put_Line(" PPM");
      Put_Line("---------------------------------------");
   end ShowInformation;

   procedure UserInputting is
   begin
      Put_Line("____________________________________________");
      Put_Line("Please select an action:");
      Put_Line("1. Open Fridge Door");
      Put_Line("2. Close Fridge Door");
      Put_Line("3. Open Oven Door");
      Put_Line("4. Close Oven Door");
      Put_Line("5. Open Window");
      Put_Line("6. Close Window");
      Put_Line("7. Turn Heating On");
      Put_Line("8. Turn Heating Off");
      Put_Line("9. Check Carbon Monoxide Level");
      Put_Line("10. Quit");
      Put_Line("____________________________________________");
   end UserInputting;

begin
   loop
      ShowInformation;
      UserInputting;
      Put("Enter selection: ");
      declare
         Selection : Integer := Integer'Value(Get_Line);
      begin
         case Selection is
            when 1 =>
               if Oven = Closed then
                  if Fridge = Closed then
                     Open_Fridge_Door;
                  else
                     Put_Line("Error: Fridge door is already open.");
                  end if;
               else
                  Put_Line("Error: Oven door is already open.");
               end if;
            when 2 =>
               if Fridge = Open then
                  Close_Fridge_Door;
               else
                  Put_Line("Error: Fridge door is already closed.");
               end if;
            when 3 =>
               if Fridge = Closed then
                  if Oven = Closed then
                     Open_Oven_Door;
                  else
                     Put_Line("Error: Oven door is already open.");
                  end if;
               else
                  Put_Line("Error: Fridge door is already open.");
               end if;
            when 4 =>
               if Oven = Open then
                  Close_Oven_Door;
               else
                  Put_Line("Error: Oven door is already closed.");
               end if;
            when 5 =>
               if Heating = Off then
                  Open_Window;
               else
                  Put_Line("Error: Cannot open window while heating is on.");
               end if;
            when 6 =>
               if Window = Open then
                  Close_Window;
               else
                  Put_Line("Error: Window is already closed.");
               end if;
            when 7 =>
               if Window = Closed then
                  Turn_Heating_On;
               else
                  Put_Line("Error: Cannot turn heating on while window is open.");
               end if;
            when 8 =>
               if Heating = On then
                  Turn_Heating_Off;
               else
                  Put_Line("Error: Heating is already off.");
               end if;
            when 9 =>
               Check_CO_Level;
            when 10 =>
               New_Line;
               Put_Line("Good Bye !");
               exit;
            when others =>
               Put_Line("Invalid selection. Please try again.");
         end case;
      end;
   end loop;
end Main;