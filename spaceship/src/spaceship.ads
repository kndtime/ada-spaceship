package Spaceship is
   type Dmg_range is new Integer range 1 .. 100;
   type Spaceship_State is
        (ALIVE, SHOOTING, DMG_DEALT, RECOVER, INVISIBLE, DEAD);
  type Spaceship is record
      State : Spaceship_State;
      Life : Integer := 100;
      Damage  : Positive := 100;
      Boost : Integer := 0;
      X : Integer;
      Y : Integer;
      Speed : Integer;
   end record;
   procedure set_dmg(s : in out Spaceship; dmg: Integer);
   procedure shoot (s : in out Spaceship);
   procedure move (s : in out Spaceship; X : Integer; Y : Integer);
   procedure test;
end Spaceship;
