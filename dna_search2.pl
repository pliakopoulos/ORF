#!/usr/bin/perl -w
use strict;
use warnings;



while ( my $dna = <STDIN> )
{

find_ORF($dna);

my $dna2 = reverse( $dna);

find_ORF($dna2);

}







sub find_ORF
{

my $dna_seq = $_[0];

while($dna_seq =~ /TAA/ )
{
my $prev =      $`;
   $dna_seq  =  $'; 
while ( $prev =~ /ATG/ )
        {
        $prev   =       $';
        my $len =       length($prev);
        my $dev =       $len / 3;
        my $remainder = $len % 3;

        if ($remainder  == 0)
                {
                        if ( $dev != 0 )
                        {
			print("ATG", $prev, "TAA\n");
                        }
                }
        }
}
return();
}
