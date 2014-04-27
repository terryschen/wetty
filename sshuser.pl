#!/usr/bin/perl

my $addr = $ARGV[0];
my $port = $ARGV[1];

print "Enter your username: ";
my $username = <STDIN>;
chomp ( $username );
exec ("/usr/bin/ssh -p $port $username\@$addr");


