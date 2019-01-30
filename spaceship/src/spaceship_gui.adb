
with STM32.Board;         use STM32.Board;
with Ada.Real_Time;       use Ada.Real_Time;
with Ada.Numerics.Discrete_Random;


with STM32.DMA2D;         use STM32.DMA2D;
with STM32.DMA2D_Bitmap;  use STM32.DMA2D_Bitmap;
with HAL.Bitmap;          use HAL.Bitmap;
with HAL.Touch_Panel;     use HAL.Touch_Panel;
with BMP_Fonts;

with Ada.Text_IO;
with Spaceship;          use Spaceship;
with Missile;            use Missile;
with Ennmie;             use Ennmie;
with LCD_Std_Out;

procedure spaceship_gui
is
   X_Coord : Integer := 0;
   Y_Coord : Integer := 0;

   -- 480x272
   Width  : Natural;  -- 240
   Height : Natural;  -- 320

   MAX_WIDTH : Natural := 480;
   MAX_HEIGHT : Natural := 272;

   Shoot : Integer := 100;
   count : Integer := 0;

   subtype RGN_H is Integer range 150 .. MAX_HEIGHT;
   subtype RGN_W is Integer range 80 .. MAX_WIDTH;

   package Random_H is new Ada.Numerics.Discrete_Random (RGN_H); use Random_H;
   G : Generator;

   type GAMESTATE is (STARTING, RUNNING, PAUSE, OVER);
   g_state : GAMESTATE := STARTING;

   Period       : constant Time_Span := Milliseconds (1);
   Next_Release : Time := Clock;
   Next_missile : Integer := 0;
   Next_Ennmie  : Integer := 0;

   function Bitmap_Buffer return not null Any_Bitmap_Buffer;
   function Buffer return DMA2D_Buffer;

   Missiles : array (1 .. 8) of Missile.Missile;
   Ennmies : array (1 .. 4) of Ennmie.Ennmie;
   space : Spaceship.Spaceship;
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

   procedure update_Enn is
   begin
      if Next_Ennmie = 0 then
         for i in Ennmies'First .. Ennmies'Last loop
            if Ennmies(i).State = DEAD then
               Ennmie.appear_enn(Ennmies(i), MAX_HEIGHT - 5, RANDOM(G) , MAX_HEIGHT, MAX_WIDTH);
               exit;
            end if;
         end loop;
         Next_Ennmie := 45;
      else
         Next_Ennmie := Next_Ennmie - 1;
      end if;
      for i in Ennmies'First .. Ennmies'Last loop
          Ennmie.move_enn(Ennmies(i));
      end loop;
   end update_Enn;

   procedure update(X : Integer; Y : Integer) is
   begin
      if Next_missile = 0 then
      for i in Missiles'First .. Missiles'Last loop
         if Missiles(i).State = DEAD then
            Missile.appear_mis(Missiles(i), space.X, space.Y, Height);
            exit;
         end if;
         end loop;
         Next_missile := 10;
      else
         Next_missile := Next_missile - 1;
      end if;
      for i in Missiles'First .. Missiles'Last loop
          Missile.move_mis(Missiles(i));
      end loop;
      update_Enn;
      if X = 0 then
         return;
      end if;
      space.X := X;
      space.Y := Y;
   end update;

   procedure draw_mis(s : in Missile.Missile) is
   begin
     if s.State = DEAD then
       return;
     end if;

     Bitmap_Buffer.Set_Source (HAL.Bitmap.Yellow);
     Bitmap_Buffer.Fill_Rect ((Position => (s.X, s.Y),
                               Width    => Width / 80,
                               Height   => Height / 80));
   end draw_mis;

   procedure draw_space(s : in out Spaceship.Spaceship; X : Integer; Y : Integer) is
   begin
      s.X := X;
      s.Y := Y;
      if s.State = ALIVE then
         Bitmap_Buffer.Set_Source (HAL.Bitmap.Blue);
      else if s.State = DMG_DEALT then
            Bitmap_Buffer.Set_Source (HAL.Bitmap.White);
            end if;
      end if;
         Bitmap_Buffer.Fill_Rect ((Position => (X, Y),
                               Width    => Width / 8,
                                   Height   => Height / 8));
   end draw_space;

   procedure draw_enn(e : in Ennmie.Ennmie) is
   begin
      if e.State = ALIVE then
         Bitmap_Buffer.Set_Source (HAL.Bitmap.Red);
      else if e.State = DMG_DEALT then
            Bitmap_Buffer.Set_Source (HAL.Bitmap.White);
            end if;
      end if;
         Bitmap_Buffer.Fill_Rect ((Position => (45, 45),
                               Width    => Width / 12,
                                   Height   => Height / 12));
   end draw_enn;

   procedure draw(X : Integer; Y : Integer) is
   begin
      draw_space(space, X, Y);
      for i in Missiles'First .. Missiles'Last loop
         draw_mis(Missiles(i));
      end loop;
      for i in Ennmies'First .. Ennmies'Last loop
         draw_enn(Ennmies(i));
      end loop;
      end draw;

begin
   Reset(G);
   --  Initialize LCD
   Display.Initialize;
   Display.Initialize_Layer (1, HAL.Bitmap.ARGB_8888);

   Touch_Panel.Initialize;

   Width  := Bitmap_Buffer.Width;
   Height := Bitmap_Buffer.Height;

   space.Y := Height/2;
   space.X := Width/2;
   loop
     declare
        State : constant TP_State := Touch_Panel.Get_All_Touch_Points;
     begin
        if State'Length > 0 then
           X_Coord := State (State'First).X;
           Y_Coord := State (State'First).Y;
        end if;
      end;
      Bitmap_Buffer.Set_Source (HAL.Bitmap.Black);
      Bitmap_Buffer.Fill;

         update(X_Coord, Y_Coord);


      if X_Coord /= 0 then
         draw(X_Coord, Y_Coord);
      else
         draw(space.X, space.Y);
      end if;
           -- case g_state is
           --      when STARTING =>
           --        LCD_Std_Out.Put_Line ("Start State");
           --      when RUNNING =>
           --        LCD_Std_Out.Put_Line ("Running State");
           --      when PAUSE =>
           --        LCD_Std_Out.Put_Line ("Pause State");
           --      when OVER =>
           --        LCD_Std_Out.Put_Line ("Over State");
           -- end case;
      count := count + 10;
      Display.Update_Layers;
      Next_Release := Next_Release + Period;
      delay until Next_Release;

   end loop;

end spaceship_gui;
