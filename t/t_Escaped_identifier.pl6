use v6.c;
use Test;
use lib 'lib/P6Parser/Verilog';
use Identifier;
use Escaped_identifier;


constant package-name = 'Escaped_identifier';
use-ok package-name or bail-out "{package-name} did not compile";
use ::(package-name);
my $class = ::(package-name);
can-ok $class, 'new' or bail-out "$class cannot .new";

subtest {
  my Escaped_identifier $s;
  $s = Escaped_identifier.new('a2a');
  does-ok $s, Identifier;
  is $s.contents, 'a2a';
  $s.contents = 'h$$$';
  is $s.contents, 'h$$$';
}, 'accessors';

subtest {
  my @malformed_string =  '\१२३ ', '2a', '17A', '_a', '$a', '$A', '_D', 'a2@', '1¼³²³ ', '\1¼³²³ ', '\ x '  ;
  my @good_string = '\a2a ', '\A17A ', '\222 ', '\a2"q!$a ', '\123)(/(/%)) ', '\ ' ;
  my Escaped_identifier $s;
  $s = Escaped_identifier.new;
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
  $s.contents = '\A17A ';
  push $s.branch, %be;
  ok $s.check;
  nok $s.check_no_branch;
}, 'syntax';


done-testing();
