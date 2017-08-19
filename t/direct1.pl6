use v6.c;
use lib 'lib/P6Parser/Verilog';
use Stringa;
use Simple_identifier;
use Escaped_identifier;
use Identifier;


my $veriog_code = q:to/EOI/;
    ciccio
EOI


my @malformed_string =  "\"\\१२३ \"", "\"2 a\"", "\"1\n7A\"",
"\"_a"~"\t\"", "\"\n"~"\$a\"", "\"\t\$A\"", "\"1¼³²³\"",
"\"\\1¼³²³\"", "\"\ x\"", "\"Иван\"", "\"fra,n:;@cy\""  ;
my @good_string = "\"Aa\"2a\"", "\"\\A17A\"", "\"222\"",
"\"\a2q\!\$a\"", "\"\\123\)\(\/\(\/\%\)\)\"" ;
my Stringa $s;
$s = Stringa.new;
for @malformed_string {
  $s.contents = $_;
  print "$_  :";
  say $s.check;
}

#my Identifier $i;
#$i = Identifier.new('Simple_identifier');
#my $ss = Simple_identifier.new('a2a');
#$i.set('a2a');
#say $i;


#my @malformed_string =  '\१२३ ', '2a', '17A', '_a', '$a', '$A', '_D', 'a2@', '1¼³²³ ', '1¼³²³ ', '\ x ' ;
#my @good_string = '\a2a ', '\A17A ', '\222 ', '\a2"q!$a ', '\123)(/(/%)) ', '\ ' ;
#my Escaped_identifier $s;
#$s = Escaped_identifier.new;
#for @malformed_string {
#  $s.contents = $_;
#  say $_ ~ $s.check;
#}
#for @good_string {
#  $s.contents = $_;
#  say $_ ~ $s.check;
#}
