use v6.c;
use Test;
use lib 'lib/P6Parser/Verilog';
use Identifier;
use Simple_identifier;
use Simple_Hier_Identifier;
use Escaped_identifier;

constant package-name = 'Simple_Hier_Identifier';
use-ok package-name or bail-out "{package-name} did not compile";
use ::(package-name);
my $class = ::(package-name);
can-ok $class, 'new' or bail-out "$class cannot .new";

subtest {
  my Simple_Hier_Identifier $s;
  my %be = ( si => 'a' , un => 6 );
  my Hash @branch;
  push @branch, %be;
  my %be2 = ( si => 'b' , un => 0 );
  push @branch, %be2;
  my %be3 = ( si => 'c'  );
  push @branch, %be3;

  my Int @emptyrange;
  $s = Simple_Hier_Identifier.new('\a2a ',@emptyrange, @branch);
  is $s.contents, '\a2a ';
  $s.contents = '\ ';
  is $s.contents, '\ ';
  is $s.branch[0]<si>, 'a';
  is $s.branch[0]<un>, 6;
  is $s.branch[1]<si>, 'b';
  is $s.branch[1]<un>, 0;
  is $s.branch[2]<si>, 'c';
  nok $s.branch[2]<un>.defined;
}, 'accessors';

done-testing();
