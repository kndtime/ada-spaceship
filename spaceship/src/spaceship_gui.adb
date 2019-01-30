
with STM32.Board;         use STM32.Board;
with Ada.Real_Time;       use Ada.Real_Time;

with STM32.DMA2D;         use STM32.DMA2D;
with STM32.DMA2D_Bitmap;  use STM32.DMA2D_Bitmap;
with HAL.Bitmap;          use HAL.Bitmap;
with HAL.Touch_Panel;     use HAL.Touch_Panel;
with BMP_Fonts;

with Ada.Text_IO;
with Spaceship;
with LCD_Std_Out;

procedure spaceship_gui
is
   X_Coord : Integer := -1;
   Y_Coord : Integer := -1;

   Width  : Natural;  -- 240
   Height : Natural;  -- 320

   type GAMESTATE is (STARTING, RUNNING, PAUSE, OVER);
   state : GAMESTATE := STARTING;

   Period       : constant Time_Span := Milliseconds (100);
   Next_Release : Time := Clock;

   function Bitmap_Buffer return not null Any_Bitmap_Buffer;
   function Buffer return DMA2D_Buffer;

   -------------------
   -- Bitmap_Buffer --
   -------------------

   function Bitmap_Buffer return not null Any_Bitmap_Buffer is
   begin
      if Display.Hidden_Buffer (1).all not in DMA2D_Bitmap_Buffer then
         raise Program_Error with "We expect a DM2D buffer here";
      end if;

      return Display.Hidden_Buffer (1);
   end Bitmap_Buffer;

   ------------
   -- Buffer --
   ------------

   function Buffer return DMA2D_Buffer is
   begin
      return To_DMA2D_Buffer (Display.Hidden_Buffer (1).all);
   end Buffer;

 begin
   --  Initialize LCD
   Display.Initialize;
   Display.Initialize_Layer (1, HAL.Bitmap.ARGB_8888);

   Touch_Panel.Initialize;

   Width  := Bitmap_Buffer.Width;
   Height := Bitmap_Buffer.Height;


   loop
      Bitmap_Buffer.Set_Source (HAL.Bitmap.Dark_Green);
      Bitmap_Buffer.Fill;

      Bitmap_Buffer.Set_Source (HAL.Bitmap.Blue);
      Bitmap_Buffer.Fill_Rect ((Position => (0, 0),
                                Width    => Width / 2,
                                Height   => Height / 2));

           case state is
                when STARTING =>
                  LCD_Std_Out.Put_Line ("Start State");
                when RUNNING =>
                  LCD_Std_Out.Put_Line ("Running State");
                when PAUSE =>
                  LCD_Std_Out.Put_Line ("Pause State");
                when OVER =>
                  LCD_Std_Out.Put_Line ("Over State");
           end case;

      Display.Update_Layers;
      Next_Release := Next_Release + Period;

      delay until Next_Release;

   end loop;

end spaceship_gui;
