use v6.c;
use Identifier;

=begin pod

=head1 SPEC

escaped_identifier ::= \ ( _any_ASCII_character_except_white_space_ )* _white_space_

=end pod


class Escaped_identifier does Identifier {

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

method check_no_branch {
  &check_no_branch(@.branch)
}

sub check_no_branch(
@branch
--> Bool
){
if @branch.elems != 0 {False} else {True}
}

} #--------------------- end of class
