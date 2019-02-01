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

   procedure appear_mis(s : in out Missile; X : Integer; Y : Integer; Max_Y : Integer)
   with
       Pre => Y /= Max_Y and s.State /= ALIVE,
       Post => s.State = ALIVE;
   procedure move_mis(s : in out Missile)
   with
       Pre => s.State /= DEAD;
end Missile;
