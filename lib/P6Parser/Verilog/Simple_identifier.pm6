use v6.c;
use Identifier;

=begin pod

=head1 SPEC

simple_identifier ::= [a-zA-Z_] ( [a-zA-Z0-9_$] )*

=end pod


class Simple_identifier does Identifier {

method check returns Bool {
  return &check($.contents) and &check_no_branch(@.branch)
}

sub check (Str:D $contents --> Bool) {
  my token letter { <[a..zA..Z]> || <[ _ ]>  };
  my token alphanumdollar { <[a..zA..Z]> || <[1234567890]> || <[ $ _ ]> };
  my regex  identifier { ^ <letter>+ <alphanumdollar>* $ };
  if $contents ~~ m/ <identifier> / { True }
  else { False }
}

method check_no_branch returns Bool {
  &check_no_branch(@.branch)
}
sub check_no_branch(
Hash @branch
--> Bool
){
if @branch.elems != 0 {False} else {True}
}


} #--------------------- end of class
