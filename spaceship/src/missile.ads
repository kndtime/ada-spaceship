package Missile is
  type Missile_State is
      (ALIVE, TOUCHED, DEAD);

  type Missile is record
      State : Missile_State := DEAD;
      X : Integer;
      Y : Integer;
      Max_Y: Integer;
      Speed : Integer;
  end record;

  procedure appear_mis(s : in out Missile; X : Integer; Y : Integer; Max_Y : Integer);
  procedure move_mis(s : in out Missile);
end Missile;
