#!/usr/bin/perl -w

use strict;
use warnings;

print("Type q to exit. \n");
print("Give me DNA Sequnecing to search for ORFs: \n");

while ( my $dna = <STDIN> ) #Read the DNA sequences
	{

#Check if the input is correctly written or not, or the user pressed q in order to exit. 

	if ($dna =~ /[^atgc\n]/i) 
		{
		if( $dna eq "q\n")
			{
			last;
			}
		else
			{
			print("Error404, DNA Sequence not found. Please enter a legit DNA Sequence. (With ATGC or atgc) \n");
			}
		}

	elsif( $dna eq "\n")        
		{        
		print("");
		}

	else #Run the function find_orf in order to find ORFs in forward and reverse strands of input DNA sequences.
		{
		print("Forward strand: \n");
		find_ORF($dna);

		print("Reverse strand: \n");
		my $dna2 = reverse( $dna);
		find_ORF($dna2);
		}
	}

#Fuction to check if the dna sequences have none, one or many orfs. 

sub find_ORF
{

my $dna_seq = $_[0];

if($dna_seq =~ /ATG([ATCG][ATCG][ATGC])*(TAA|TAG|TGA)/i) #Checks if an orf exists (makes the programm a bit quicker for sequences without orfs). It can be executed without it.
	{
	while ($dna_seq =~ /(ATG)/i ) #Finds all the possible ATGs in the provided sequence.
		{
           	$dna_seq  =  $';		
		if ($dna_seq =~ /(([ATCG][ATCG][ATGC])*?(TAA|TGA|TAG))/i ) #Finds if an orf exists, using the atg that has found earlier.
			{
        		my $orf     =   $&;
        		my $dev     =   length($orf) / 3;
 
                	if ( $dev != 1 ) #checks if there exist a codon between atg and terminating codon or not.
                		{
				print("ATG", uc($orf),"\n\n");
                        	}
			else
				{
				print("\n", "Does that count as an ORF?...ATG", uc($orf),"\n\n");
				}
        		}
		}
	}

else
	{
	print("Didn't find. \n\n");
	}

return();

}
