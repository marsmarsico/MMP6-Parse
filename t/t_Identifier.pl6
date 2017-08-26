use v6.c;
use Test;
use lib 'lib/P6Parser/Verilog';
use Identifier;
use Escaped_identifier;
use Simple_identifier;

constant package-name = 'Identifier';
use-ok package-name or bail-out "{package-name} did not compile";
use ::(package-name);
my $role = ::(package-name);
#can-ok $role, 'new' or bail-out "$role cannot .new";

subtest {
  my Identifier $s;
  my Int @r = 0, 3;
  $s = Simple_identifier.new('a2a',@r);
  ok $s.check_range;
  is $s.contents, 'a2a';

  @r = 3,0;
  $s = Simple_identifier.new('a2a',@r);
  nok $s.check_range;
  is $s.contents, 'a2a';
  does-ok $s, Identifier;

  @r = 0,0;
  $s = Simple_identifier.new('a2a',@r);
  ok $s.check_range;
  is $s.contents, 'a2a';

  @r = 1,1;
  $s = Simple_identifier.new('a2a',@r);
  ok $s.check_range;
  is $s.contents, 'a2a';

  @r = 1,1,1;
  $s = Simple_identifier.new('a2a',@r);
  nok $s.check_range;
  is $s.contents, 'a2a';

  @r = 1;
  $s = Simple_identifier.new('a2a',@r);
  nok $s.check_range;
  is $s.contents, 'a2a';

  @r = 1,1;
  my Str $t;
  $s = Simple_identifier.new($t,@r);
  nok $s.check_range;

}, 'range';

done-testing();
