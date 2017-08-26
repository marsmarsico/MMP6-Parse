use v6.c;
use Test;
use lib 'lib/P6Parser/Verilog';
use Identifier;
use Simple_identifier;

constant package-name = 'Simple_identifier';
use-ok package-name or bail-out "{package-name} did not compile";
use ::(package-name);
my $class = ::(package-name);
can-ok $class, 'new' or bail-out "$class cannot .new";

subtest {
  my Simple_identifier $s;
  $s = Simple_identifier.new('a2a');
  is $s.contents, 'a2a';
  $s.contents = 'h$$$';
  is $s.contents, 'h$$$';
}, 'accessors';

subtest {
  my @malformed_string = < 2a 17A $a $A  a2@ Иван >;
  my @good_string = < a2a A17A x_a _a a$a _D w_$A u_D >;
  my Simple_identifier $s;
  $s = Simple_identifier.new;
  for @malformed_string {
    $s.contents = $_;
    nok $s.check;
    ok $s.check_no_branch;
  }
  for @good_string {
    $s.contents = $_;
    ok $s.check;
    ok $s.check_no_branch;
  }
  my %be = (si=>'a',un=>6);
  $s.contents = 'abba';
  push $s.branch, %be;
  ok $s.check;
  nok $s.check_no_branch;
}, 'syntax';


done-testing();
