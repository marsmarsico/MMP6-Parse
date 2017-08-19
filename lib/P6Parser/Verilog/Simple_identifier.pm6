use v6.c;
use Identifier;

=begin pod

=head1 SPEC

simple_identifier ::= [a-zA-Z_] ( [a-zA-Z0-9_$] )*

=end pod


class Simple_identifier is Identifier {

method check returns Bool {
  return &check($.contents)
}

sub check (Str:D $contents --> Bool) {
  my token letter { <[a..zA..Z]> || <[ _ ]>  };
  my token alphanumdollar { <[a..zA..Z]> || <[1234567890]> || <[ $ _ ]> };
  my regex  identifier { ^ <letter>+ <alphanumdollar>* $ };
  if $contents ~~ m/ <identifier> / { True }
  else { False }
}

} #--------------------- end of class
