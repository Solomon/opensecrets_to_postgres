import os
import glob
import fileinput
import sys
import subprocess

def unzip_committee_files():
    file_list = glob.glob('local_files/fec_committees/*.zip')
    for f in file_list:
        new_fileprefix = f.split('/')[2][:4]
        year = new_fileprefix[2:4]
        new_filename = new_fileprefix + '.txt'
        subprocess.call(['unzip', f])
        os.rename('cm.txt', 'local_files/fec_committees/' + new_filename)

def add_cycle_to_files():
    file_list = glob.glob('local_files/fec_committees/*.txt')
    for f in file_list:
        year = f.split('/')[2][2:4]
        if int(year) < 30:
            year = '20' + year
        else:
            year = '19' + year

        for line in fileinput.input([f], inplace=True):
            sys.stdout.write('{c}|{l}'.format(c=year, l=line))

def combine_committee_files():
    file_list = glob.glob('local_files/fec_committees/*.txt')
    with open('local_files/fec_committees/combined_fec_committees.csv', 'w') as outfile:
        for fname in file_list:
            with open(fname) as infile:
                outfile.write(infile.read())

# Get table metadata here and add to the combined file: http://www.fec.gov/finance/disclosure/metadata/cm_header_file.csv
# get rid of microsoft quotes: iconv -f cp1252 -t UTF-8 combined_fec_committees.csv > combined_new.csv
# mv combined_new.csv combined_fec_committees.csv
#sed -i '.original' 's/\x0//g' combined_fec_committees.csv
# sed didn't completely work, go into vim and do the following:
#Then search for NUL char with: 
#/<c-v>000<Enter> 
#(where <c-v> is "control-v" key) 
#and I see the NUL chars highlighted. 

# run in2csv -d "|" -v combined_fec_committees.csv > fec_committees.csv
# csvsql --db postgresql:///campaign_finance --table fec_committees --insert filename.csv
