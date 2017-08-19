use v6.c;

use Factory;
use Identifier;
use Simple_identifier;
use Escaped_identifier;

=begin pod

=head1 SPEC

Product class
Targeting Identifiers

=end pod

class IdFactory is Factory {

method create(
Str $feed?,
Int @range?
--> Identifier
) {
  my Identifier $id;
  if $feed ~~ m/ ^\\ / { $id = Escaped_identifier.new($feed,@range) }
  else                 { $id = Simple_identifier.new($feed,@range) }
  ( $id.check and $id.check_range ) ?? $id !! Identifier;
}

} #--------------------- end of class
