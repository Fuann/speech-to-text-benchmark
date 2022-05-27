infile='exp/azure/SPOKEN_TEST_2022_JAN28/hyp'
outfile='hyp'
with open(infile) as in_file, open(outfile, "a") as out_file:
    for line in in_file:
        id = line.split(" ", maxsplit=1)[0]
        text = line.split(" ", maxsplit=1)[1]
        out_file.write(id+" "+text.upper())
