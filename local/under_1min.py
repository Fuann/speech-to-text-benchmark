infile='utt2dur.3p'
outfile='utt2dur.3p.1min'
with open(infile) as in_file, open(outfile, "w") as out_file:
    for line in in_file:
        id = line.split()[0]
        dur = line.split()[1]
        if float(dur) <= 60 :
            out_file.write(line)
        else:
            continue
