use v6.c;

=begin pod

=head1 SPEC

identifier ::= simple_identifier | escaped_identifier

=end pod

class Identifier {
  has Str $.contents is rw;
  has Int @.range is rw = 0;

  method new (
  Str $contents? ,
  Int @range?
  ) {
    print "I";
    self.bless( :$contents, :@range);
  }

  method check_range returns Bool {
    return &check_range(@.range,$.contents)
  }

  sub check_range (Int:D @range, Str $contents --> Bool) {
    if not $contents.defined { False }
    elsif @range.elems == 0 { True }
    elsif @range.elems == 2  {
      if @range[1] > @range[0] { True }
      elsif @range[1] == @range[0] { True }
      else { False }
    } else { False }
  }

} #--------------------- end of class
