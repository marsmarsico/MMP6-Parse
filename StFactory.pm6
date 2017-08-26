use v6.c;

use Factory;
use Stringa;

=begin pod

=head1 SPEC

Product class
Targeting Strings

=end pod

class StFactory does Factory {

method create(
Str $feed?
--> Stringa
) {
  my Stringa $id;
  $id = Stringa.new($feed) ;
  $id.check ?? $id !! Stringa;
}

} #--------------------- end of class
