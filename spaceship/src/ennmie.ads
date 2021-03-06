package Ennmie is
   type Dmg_range is new Integer range 1 .. 100;
   type Ennmie_State is
        (ALIVE, SHOOTING, DMG_DEALT, RECOVER, INVISIBLE, DEAD);
  type Ennmie is record
      State : Ennmie_State := DEAD;
      Life : Integer := 100;
      Damage  : Positive := 100;
      Boost : Integer := 0;
      X : Integer;
      Y : Integer;
      Max_X : Integer;
      Max_Y : Integer;
      Speed : Integer;
   end record;
   procedure appear_enn(s : in out Ennmie; X : Integer; Y : Integer; Max_X : Integer; Max_Y : Integer)
     with
       Pre => s.State = DEAD;
   procedure move_enn(s : in out Ennmie)
     with
       Pre => s.State /= DEAD;
   procedure set_dmg_enn(s : in out Ennmie; dmg: Integer)
     with
       Pre => s.State /= DEAD and dmg /= 0,
       Post => (if s.Life <= 0 then
                   s.State = DEAD);
   procedure test_enn;
end Ennmie;
