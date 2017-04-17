# classify_blast_results_from_PFAM_database
This R script is made to convert the PFAM IDs from Blast result tables to interpretable descriptions and molecular function names of proteins





This tool works on blast result tables that were generated using the -outfmt 6 option, for example


blast_output_example.txt

...

D00420:119:HVWNHBCXX:2:1101:1137:2200	PF00145	35.088	57	36	1	20	190	61	116	1.7	32.7
D00420:119:HVWNHBCXX:2:1101:1137:2200	PF00145	35.088	57	36	1	201	31	61	116	1.7	32.7
D00420:119:HVWNHBCXX:2:1101:1473:2123	PF00888	25.532	47	29	1	2	142	516	556	0.81	33.9
D00420:119:HVWNHBCXX:2:1101:1473:2123	PF00888	25.532	47	29	1	189	49	516	556	0.81	33.9
D00420:119:HVWNHBCXX:2:1101:1922:2189	PF00124	97.059	34	1	0	172	273	1	34	6.74e-15	68.9
D00420:119:HVWNHBCXX:2:1101:1922:2189	PF00124	97.059	34	1	0	103	2	1	34	6.74e-15	68.9
D00420:119:HVWNHBCXX:2:1101:1805:2237	PF07528	62.500	48	18	0	261	404	1	48	1.98e-12	68.6
D00420:119:HVWNHBCXX:2:1101:1805:2237	PF07528	62.500	48	18	0	144	1	1	48	1.98e-12	68.6
D00420:119:HVWNHBCXX:2:1101:2391:2102	PF07729	29.688	64	37	2	32	199	30	93	0.51	34.3
D00420:119:HVWNHBCXX:2:1101:2391:2102	PF07729	29.688	64	37	2	207	40	30	93	0.51	34.3

...


The columns above correspond to:

 1. 	 qseqid 	 query (e.g., gene) sequence id
 2. 	 sseqid 	 subject (e.g., reference genome) sequence id
 3. 	 pident 	 percentage of identical matches
 4. 	 length 	 alignment length
 5. 	 mismatch 	 number of mismatches
 6. 	 gapopen 	 number of gap openings
 7. 	 qstart 	 start of alignment in query
 8. 	 qend 	 end of alignment in query
 9. 	 sstart 	 start of alignment in subject
 10. 	 send 	 end of alignment in subject
 11. 	 evalue 	 expect value
 12. 	 bitscore 	 bit score



You can run the present tool by:

Rscript convert_PFAM_to_molecular_function.R blast_output_example.txt 75 1e-5

where:

the first paremeter is the blast output file (blast_output_example.txt in this case)

the second parameter is the sequence identity cuttoff value (75% in this case)

the third parameter is the e-value cuttoff (1e-5 in this example)


