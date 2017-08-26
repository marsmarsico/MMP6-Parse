use v6.c;
use Identifier;

=begin pod

=head1 SPEC

abstract class
for simple and escaped hierarchical branches

simple_hierarchical_branch ::=
simple_identifier ( [ unsigned_number ] )? ( ( . simple_identifier ( [ unsigned_number ] )? )* )?

simple_hierarchical_identifier ::= simple_hierarchical_branch ( . escaped_identifier )?


=end pod

class Simple_Hier_Identifier does Identifier {

  method branch_seq_check (
  --> Bool
  ){
    if @.branch.elems > 0 {  &type_seq_chk(@.branch)  }
    else {True}
  }

  # check on types since the branch, for this class, must be
  # homogeneous in types
  sub type_seq_chk (
  Hash @branch --> Bool
  ){
    my @typearray = @branch.map({
      if $_.^name ~~ 'Simple_identifier' {
        1
      }
      elsif $_.^name ~~ 'Escaped_identifier' {
        2
      } else { False }
    });
    my $factor = [+] gather for @typearray {take $_}
    if $factor == @branch.elems {True}
    elsif $factor == @branch.elems *2 {True}
    else { False }
  }

  method check returns Bool {
    return &check($.contents)
  }

  sub check (Str:D $contents --> Bool) {
    my token whitespace { <[ \s \t \n \Z  ]> };
    my token not_whitespace { <-[ \s \t \n \Z ]> };
    if $contents ~~ m/ <-:BasicLatin> / { False }
    elsif $contents ~~ m/ ^ \\ / {
      if $contents ~~ m/ <whitespace> $ / {
        if $contents ~~ m/ <whitespace> <not_whitespace> <whitespace>  / { False } # thanks Francy
        else { True }
      }
      else { False}
    }
    else { False  }
  }

} #--------------------- end of class
