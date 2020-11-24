#Filesystem               Size  Used Avail Use% Mounted on
#[mike@workbench ~]$ df -x devtmpfs -x tmpfs -lPh 
#/dev/mapper/centos-root   34G   22G   12G  65% /
#

#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';
use diagnostics;
#use POSIX ();
use POSIX qw(strftime);
#use Time::Local;
use IPC::PerlSSH;

my $currenttime = strftime "%F-%H:%M:%S", localtime;
my $in;
my $mnttmp;
my $tmpvar;
my $joinstr;
my $filesys; my $size; my $used; my $avail, my $percentageu; my $mountedon;
my $richstring;
my $plainperc;

my @richarray;
my @inarray;
my @tmpvar;

my @i = ("reimu.afk47.org");
my $count = "0";
my $totalcount = scalar @i;

my $fh; 
open( $fh, '>:encoding(UTF-8)', "test.html" ) || die "cannot open file!\n";


sub Head {
	print $fh <<"EOF";
<HTML>
<HEAD>
<TITLE>Filesytems</TITLE>
</HEAD>
<style>
table, th, td {
  border: 1px solid black;
  border-collapse: collapse;
}
th, td {
  padding: 5px;
}
th {
  text-align: left;
}
</style>
<BODY>
<H1>Filesystem Report</H1>
<table>
 <tr>
    <th>Filesystem</th>
    <th>Size</th> 
    <th>Used</th>
    <th>Available</th>
    <th> % </th>
    <th>Mounted on</th>
  </tr>
EOF

&GetData();


print $fh <<"EOF";
</table>
<h6>Generated on: $currenttime </h6>
</body>
</html>
EOF
close($fh) || die;

}


sub GetData {

	while ("$count" < "$totalcount") { print "debug count: $count\n";
	print "debug totalcount: $totalcount\n";
	print "debug count: $count\n";

		print "Debug: $i[$count]\n";
		#my $ips = IPC::PerlSSH->new( Host => $i[$count] );
		#$ips->eval( "use POSIX qw( uname )" );
		print $fh "<tr><td><b>$i[$count]</b></td></tr>\n";
		#$ips->eval( open( $in, "df -x devtmpfs -x tmpfs -lPh |" ));
		#system ("ssh $i[$count] \"hostname -s\"");
		system ("ssh $i[$count] \"df -x devtmpfs -x tmpfs -lPh \"");
		
		#while (<$in>) {
		#	chomp;
		#	next if /Filesystem               Size  Used Avail Use% Mounted on/;
		#	print "DEBUG $_\n";
		#	my @inarray = ( $filesys, $size, $used, $avail, $percentageu, $mountedon ) = split(" ");
		#	my $joinstr = join( ' ', @inarray[ 0 ... 5 ] );	
		#
		#	@tmpvar = split( /\s+/, $joinstr );
		#	$plainperc = $inarray[4]; 
		#	$plainperc =~ s/\%//;
		#
		#	if ($plainperc gt "60" ) {
		#		$richstring = "<span style=\"background-color: #ff0000\">$inarray[4]<span>";
		#		print $fh "<tr>\n <td>$inarray[0]</td> <td>$inarray[1]</td> <td>$inarray[2]</td> <td>$inarray[3]</td> <td>$richstring</td> <td>$inarray[5]</td> </tr>\n";
		#
		#	} else {
		#		$richstring = "<span style=\"background-color: #00ff77\">$inarray[4]<span>";
		#		print $fh "<tr>\n <td>$inarray[0]</td> <td>$inarray[1]</td> <td>$inarray[2]</td> <td>$inarray[3]</td> <td>$richstring</td> <td>$inarray[5]</td> </tr>\n";
		#}	
		#
		# print "debug 2 totalcount: $totalcount\n";
		# print "debug 2 count: $count\n";
		#}
		#close ( $in );	
		$count++;	
		#$ips = "FAKE";
	}
}




&Head();
