package body Missile is

  procedure appear_mis(s : in out Missile; X : Integer; Y : Integer; Max_Y : Integer) is
   begin
      if s.State /= DEAD then
         return;
      end if;
    s.X := X + 10;
    s.Y := Y + 40;
    s.Max_Y := Max_Y;
    s.State := ALIVE;
  end appear_mis;

  procedure move_mis(s : in out Missile) is
  begin
    if s.State = DEAD then
      return;
    end if;

    s.Y := (s.Y + 1);

   if S.Max_Y <= s.Y then
     s.State := DEAD;
   end if;
  end move_mis;



end Missile;
