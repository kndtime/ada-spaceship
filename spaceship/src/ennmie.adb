package body Ennmie is

  procedure appear_enn(s : in out Ennmie; X : Integer; Y : Integer; Max_X : Integer; Max_Y : Integer) is
  begin
    if s.State /= DEAD then
       return;
    end if;
    s.X := X;
    s.Y := Y;
    s.Max_X := Max_X;
    s.Max_Y := Max_Y;
    s.State := ALIVE;
  end appear_enn;

  procedure move_enn(s : in out Ennmie) is
   begin
      s.X := s.X - 1;
      s.Y := s.Y - 1;

      if s.X > s.Max_X then
        s.X := s.Max_X - 5;
      end if;

      if s.Y > s.Max_Y then
        s.Y := s.Max_Y - 5;
      end if;
  end move_enn;

  procedure set_dmg_enn(s : in out Ennmie; dmg: Integer) is
    begin
      s.Life := s.Life - dmg;
  end set_dmg_enn;

   procedure test_enn is
     s : Ennmie := (ALIVE, 100, 100, 0, 0, 0, 0, 0, 0);
    begin
      set_dmg_enn(s, 100);
   end test_enn;

end Ennmie;
