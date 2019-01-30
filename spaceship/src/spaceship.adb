package body Spaceship is
  procedure set_dmg(s : in out Spaceship; dmg: Integer) is
    begin
      s.Life := s.Life - dmg;
  end set_dmg;

  procedure shoot (s : in out Spaceship) is
   begin
      s.Life := s.Life + 20;
  end shoot;

  procedure move (s : in out Spaceship; X: Integer; Y : Integer) is
    begin
      s.X := X;
      s.Y := Y;
  end move;

   procedure test is
     s : Spaceship := (ALIVE, 100, 100, 0, 0, 0, 0);
    begin
      set_dmg(s, 100);
   end test;

end Spaceship;
