use v6.c;

=begin pod

=head1 SPEC

string ::= " ( _any_ASCII_Character_except_new_line_ )* "

=end pod


class Stringa {
 has Str $.contents is rw;

method new ( Str $contents? ) {
  print "S";
  self.bless( :$contents );
}

method check {
  &check($.contents)
}

sub check (Str:D $contents --> Bool) {
  my token quotes { <["]> }; #"
  my token whitespace { <[ \s \t \n \Z  ]> };
  my token not_whitespace { <-[ \s \t \n \Z ]> };
  if $contents ~~ m/ ^ <quotes> / {
  if $contents ~~ m/ <quotes> $ / {
  if $contents ~~ m/ <-:BasicLatin> / { False }
  else {
      if $contents ~~ m/ <whitespace> / { False } # thanks Francy
      else { True }
    }
  } else { False }
  } else { False }
}

} #--------------------- end of class
