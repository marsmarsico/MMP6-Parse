use v6.c;
use Test;
use lib 'lib/P6Parser/Verilog';
use Stringa;

constant package-name = 'Stringa';
use-ok package-name or bail-out "{package-name} did not compile";
use ::(package-name);
my $class = ::(package-name);
can-ok $class, 'new' or bail-out "$class cannot .new";

subtest {
my Stringa $s;
$s = Stringa.new('ciccio');
is $s.contents, 'ciccio';
$s.contents = 'baciccio';
is $s.contents, 'baciccio';
}, 'accessors';

subtest {
  my $malformed_string = "\"ciccio\nbaciccio\"";
  my $good_string = "\"cicciobaciccio\"";
  say $malformed_string;
  my Stringa $s;
  $s = Stringa.new;
  $s.contents = $malformed_string;
  nok $s.check;
  $s.contents = $good_string;
  ok $s.check;
}, 'syntax';


subtest {
  my @malformed_string =  "\"\\१२३ \"", "\"2 a\"", "\"1\n7A\"",
  "\"_a"~"\t\"", "\"\n"~"\$a\"", "\"\t\$A\"", "\"1¼³²³\"",
  "\"\\1¼³²³\"", "\"\ x\"", "\"Иван\""  ;
  my @good_string = "\"Aa\"2a\"", "\"\\A17A\"", "\"222\"",
  "\"\a2q\!\$a\"", "\"\\123\)\(\/\(\/\%\)\)\"", "\"fra,n:;@cy\"" ;
  my Stringa $s;
  $s = Stringa.new;
  for @malformed_string {
    $s.contents = $_;
    nok $s.check;
  }
  for @good_string {
    $s.contents = $_;
    ok $s.check;
  }
}, 'syntax';

done-testing();
