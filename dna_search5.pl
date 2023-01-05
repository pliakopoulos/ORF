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
			print("Error404, DNA Sequence not found. Please enter a legit DNA Sequence without spaces. (With ATGC or atgc) \n");
			}
		}

	elsif( $dna eq "\n")        
		{        
		print("");
		}

	else #Run the function find_orf in order to find ORFs in forward and reverse strands of input DNA sequences.
		{
		my $dna2    = reverse( $dna);
		print("\nIf the dna sequence has a direction 5-3: \n\n");
		print("Check in forward strand \n");
		my $overall = find_ORF_Forward($dna, 0);
		print("Check in reverse strand \n");
		   $overall = find_ORF_Reverse($dna2,$overall);

		print("If the dna sequence has a direction 3-5: \n");
		print("Check in forward strand \n");
         	   $overall = find_ORF_Reverse($dna, $overall);
		print("Check in reverse strand \n");
		   $overall = find_ORF_Forward($dna2,$overall);
	
		if ($overall != 0)
			{
			print "\nTo summarize, we found ORF. \n\n";
			}
		else

			{
			print "\nTo summarize, we did not find an ORF. \n\n";
			}
		}
	}

#Fuction to check if the dna sequences have none, one or many orfs. 

sub find_ORF_Forward
{

my $dna_seq = $_[0];

my $overall = $_[1]; 

if($dna_seq =~ /ATG([ATCG][ATCG][ATGC])*(TAA|TAG|TGA)/i) #Checks if an orf exists (makes the programm a bit quicker for sequences without orfs). It can be executed without it.
	{
	$overall = $overall + 1;
	while ($dna_seq =~ /(ATG)/i ) #Finds all the possible ATGs in the provided sequence.
		{
           	$dna_seq  =  $';		
		if ($dna_seq =~ /(([ATCG][ATCG][ATGC])*?(TAA|TGA|TAG))/i ) #Finds if an orf exists, using the atg that has found earlier.
			{
        		my $orf     =   $&;
        		my $dev     =   length($orf) / 3;
 
                	if ( $dev != 1 ) #checks if there exist a codon between atg and terminating codon or not.
                		{
				print("5'- ATG", uc($orf), " -3'","\n");
                        	}
			else
				{
				print("\n", "Does that count as an ORF?... 5' - ATG", uc($orf),"- 3'", "\n");
				}
        		}
		}
	}

else
	{
	print("Didn't find. \n\n");
	}

return($overall);

}


sub find_ORF_Reverse
{

my $dna_seq = $_[0];
my $overall = $_[1];

if($dna_seq =~ /TAC([ATCG][ATCG][ATGC])*(ATT|ATC|ACT)/i) #Checks if an orf exists (makes the programm a bit quicker for sequences without orfs). It can be executed without it.
	{
	$overall = $overall + 1;
	while ($dna_seq =~ /(TAC)/i ) #Finds all the possible ATGs in the provided sequence.
		{
           	$dna_seq  =  $';		
		if ($dna_seq =~ /(([ATCG][ATCG][ATGC])*?(ATT|ATC|ACT))/i ) #Finds if an orf exists, using the atg that has found earlier.
			{
        	my $orf     =   $&;
			my $orf2    =   $&;
			   $orf2    =~  tr/ATCGatgc/TAGCtacg/;
        		my $dev     =   length($orf) / 3;
 
                	if ( $dev != 1 ) #checks if there exist a codon between atg and terminating codon or not.
                		{
				print("3'- TAC", uc($orf),  " -5'", "\n");		
				print("5'- ATG", uc($orf2), " -3'","\n\n");
                        	}
			else
				{
				print("\n", "Does that count as an ORF?...3'- TAC", uc($orf), " -5'","\n\n");
				}
        		}
		}
	}

else
	{
	print("Didn't find. \n\n");
	}

return($overall);

}
