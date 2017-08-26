use v6.c;

=begin pod

=head1 SPEC

identifier ::= simple_identifier | escaped_identifier

unsigned_number ::= decimal_digit ( _ | decimal_digit )*

%branch_element = (
si => <Identifier>,
un => <unsigned_number>
);

@branch = < %be1 %be2 %be3 ... %ben >

=end pod

role Identifier {
  has Str $.contents is rw;
  has Int @.range is rw = ();
  has Hash @.branch is rw = ();


  method new (
  Str $contents? ,
  Int @range?,
  Hash @branch?
  ) {
    print "I";
    self.bless( :$contents, :@range, :@branch);
  }


method branch_items_check (
--> Bool
){
  if @.branch.elems > 0 {  &items_syntax_chk(@.branch) }
  else {True}
}

  # check on syntax
  sub items_syntax_chk (
  Hash @branch -->  Bool
  ) {
     my @items = @branch.map({
       # if first field is defined then it must be correct
       # then if the second is not defined, ok
       # then if the second is defined it must be correct
       my Int $sib = $_<si>.defined and $sib = $_<si>.check ?? 1 !! 0;
       my Int $unb = $_<un>.defined and $unb = $_<un>.check_num ?? 1 !!
                     (not $_<un>.defined ?? 1 !! 0);
       if $sib + $unb == 2 {1} else {0}
     });
     my $factor = [+] gather for @items {take $_};
     if $factor == @branch.elems {True} else {False}
  }

  sub check_unum (
  Int:D $unum
  --> Bool
  ) {
    my token decimal_digit { <[1234567890]> }
    my token after { '_' || <decimal_digit> }
    my rule unum { <decimal_digit> <after>* }
    if $unum ~~ m/ <unum> / { True }
    else { False }
  }

  method check_range returns Bool {
    if @.range.elems != 0 { &check_range(@.range,$.contents) }
    else {True}
  }

  sub check_range (
  Int:D @range,
  Str $contents
  --> Bool) {
    if not $contents.defined { False }
    elsif @range.elems == 0 { True }
    elsif @range.elems == 2  {
      if @range[1] > @range[0] { True }
      elsif @range[1] == @range[0] { True }
      else { False }
    } else { False }
  }

  # this method makes this class an abstract one
  method check (
  --> Bool
  ) {...}

} #--------------------- end of role
