
type ('a, 'b, 'c) t =
   { matc : 'a;
     len : int;
     start : 'b;
     follow : 'b;
     self : 'c }
