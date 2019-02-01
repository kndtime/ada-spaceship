package Spaceship is
   type Dmg_range is new Integer range 1 .. 100;
   type Spaceship_State is
        (ALIVE, SHOOTING, DMG_DEALT, RECOVER, INVISIBLE, DEAD);
  type Spaceship is record
      State : Spaceship_State := ALIVE;
      Life : Integer := 100;
      Damage  : Positive := 100;
      Boost : Integer := 0;
      X : Integer;
      Y : Integer;
      Speed : Integer;
   end record;
   procedure set_dmg(s : in out Spaceship; dmg: Integer)
   with
        Pre => s.State /= DEAD and dmg /= 0,
       Post => (if s.Life <= 0 then
                   s.State = DEAD);
   procedure shoot (s : in out Spaceship)
     with
         Pre => s.STATE /= DEAD and s.Life > 0;
   procedure move (s : in out Spaceship; X : Integer; Y : Integer)
     with
         Pre => s.State /= DEAD;
   procedure test;
end Spaceship;
