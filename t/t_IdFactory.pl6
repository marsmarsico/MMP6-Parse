use v6.c;
use Test;
use lib 'lib/P6Parser/Verilog';
use Factory;
use Identifier;

constant package-name = 'IdFactory';
use-ok package-name or bail-out "{package-name} did not compile";
use ::(package-name);
my $class = ::(package-name);
can-ok $class, 'new' or bail-out "$class cannot .new";

subtest {
my Factory $PF = IdFactory.new();
my Int @r =<1 1>;
my Identifier $s = $PF.create("a2a",@r);
is $s.contents, "a2a";
is $s.range, <1 1>;

@r = <33 1>; # error is here lo > hi
my Identifier $g = $PF.create("a2a",@r);
nok $g.defined;

@r = <1 33>;
my Identifier $f = $PF.create("2a",@r); # error is "2a"
nok $f.defined;
}, 'create_Simple_Identifiers';


subtest {
my Factory $PF = IdFactory.new();
my Int @r =<1 1>;
my Identifier $s = $PF.create("\\a2a ",@r);
is $s.contents, '\a2a ';
is $s.range, <1 1>;

@r = <33 1>; # error is here lo > hi
my Identifier $g = $PF.create("\\a2a ",@r);
nok $g.defined;

@r = <1 33>;
my Identifier $f = $PF.create("\\2a",@r); # error is "\2a" missing final space
nok $f.defined;
}, 'create_Escaped_Identifiers';

done-testing();
